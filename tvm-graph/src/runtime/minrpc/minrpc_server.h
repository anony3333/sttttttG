/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

/*!
 * \file minrpc_server.h
 * \brief Minimum RPC server implementation,
 *        redirects all the calls to C runtime API.
 *
 * \note This file do not depend on c++ std or c std,
 *       and only depends on TVM's C runtime API.
 */
#ifndef TVM_RUNTIME_MINRPC_MINRPC_SERVER_H_
#define TVM_RUNTIME_MINRPC_MINRPC_SERVER_H_

#define DMLC_LITTLE_ENDIAN true
#include <string.h>
#include <tvm/runtime/c_runtime_api.h>

#include "../../support/generic_arena.h"
#include "rpc_reference.h"

/*! \brief Whether or not to enable glog style DLOG */
#ifndef TVM_MINRPC_ENABLE_LOGGING
#define TVM_MINRPC_ENABLE_LOGGING 0
#endif

#ifndef MINRPC_CHECK
#define MINRPC_CHECK(cond) \
  if (!(cond)) this->ThrowError(RPCServerStatus::kCheckError);
#endif

#if TVM_MINRPC_ENABLE_LOGGING
#include <tvm/runtime/logging.h>
#endif

namespace tvm {
namespace runtime {

namespace detail {
template <typename TIOHandler>
class PageAllocator;
}

/*!
 * \brief A minimum RPC server that only depends on the tvm C runtime..
 *
 *  All the dependencies are provided by the io arguments.
 *
 * \tparam TIOHandler IO provider to provide io handling.
 *         An IOHandler needs to provide the following functions:
 *         - PosixWrite, PosixRead, Close: posix style, read, write, close API.
 *         - MessageStart(num_bytes), MessageDone(): framing APIs.
 *         - Exit: exit with status code.
 */
template <typename TIOHandler, template <typename> class Allocator = detail::PageAllocator>
class MinRPCServer {
 public:
  using PageAllocator = Allocator<TIOHandler>;

  /*!
   * \brief Constructor.
   * \param io The IO handler.
   */
  explicit MinRPCServer(TIOHandler* io) : io_(io), arena_(PageAllocator(io)) {}

  /*! \brief Process a single request.
   *
   * \return true when the server should continue processing requests. false when it should be
   *  shutdown.
   */
  bool ProcessOnePacket() {
    RPCCode code;
    uint64_t packet_len;

    arena_.RecycleAll();
    allow_clean_shutdown_ = true;

    this->Read(&packet_len);
    if (packet_len == 0) return true;
    this->Read(&code);

    allow_clean_shutdown_ = false;

    if (code >= RPCCode::kSyscallCodeStart) {
      this->HandleSyscallFunc(code);
    } else {
      switch (code) {
        case RPCCode::kCallFunc: {
          HandleNormalCallFunc();
          break;
        }
        case RPCCode::kInitServer: {
          HandleInitServer();
          break;
        }
        case RPCCode::kCopyFromRemote: {
          HandleCopyFromRemote();
          break;
        }
        case RPCCode::kCopyToRemote: {
          HandleCopyToRemote();
          break;
        }
        case RPCCode::kShutdown: {
          this->Shutdown();
          return false;
        }
        default: {
          this->ThrowError(RPCServerStatus::kUnknownRPCCode);
          break;
        }
      }
    }

    return true;
  }

  void Shutdown() {
    arena_.FreeAll();
    io_->Close();
  }

  void HandleNormalCallFunc() {
    uint64_t call_handle;
    TVMValue* values;
    int* tcodes;
    int num_args;
    TVMValue ret_value[3];
    int ret_tcode[3];

    this->Read(&call_handle);
    RecvPackedSeq(&values, &tcodes, &num_args);

    int call_ecode = TVMFuncCall(reinterpret_cast<void*>(call_handle), values, tcodes, num_args,
                                 &(ret_value[1]), &(ret_tcode[1]));

    if (call_ecode == 0) {
      // Return value encoding as in LocalSession
      int rv_tcode = ret_tcode[1];
      ret_tcode[0] = kDLInt;
      ret_value[0].v_int64 = rv_tcode;
      if (rv_tcode == kTVMNDArrayHandle) {
        ret_tcode[1] = kTVMDLTensorHandle;
        ret_value[2].v_handle = ret_value[1].v_handle;
        ret_tcode[2] = kTVMOpaqueHandle;
        this->ReturnPackedSeq(ret_value, ret_tcode, 3);
      } else if (rv_tcode == kTVMBytes) {
        ret_tcode[1] = kTVMBytes;
        this->ReturnPackedSeq(ret_value, ret_tcode, 2);
        TVMByteArrayFree(reinterpret_cast<TVMByteArray*>(ret_value[1].v_handle));  // NOLINT(*)
      } else if (rv_tcode == kTVMPackedFuncHandle || rv_tcode == kTVMModuleHandle) {
        ret_tcode[1] = kTVMOpaqueHandle;
        this->ReturnPackedSeq(ret_value, ret_tcode, 2);
      } else {
        this->ReturnPackedSeq(ret_value, ret_tcode, 2);
      }
    } else {
      this->ReturnLastTVMError();
    }
  }

  void HandleCopyFromRemote() {
    DLTensor* arr = this->ArenaAlloc<DLTensor>(1);
    uint64_t data_handle;
    this->Read(&data_handle);
    arr->data = reinterpret_cast<void*>(data_handle);
    this->Read(&(arr->device));
    this->Read(&(arr->ndim));
    this->Read(&(arr->dtype));
    arr->shape = this->ArenaAlloc<int64_t>(arr->ndim);
    this->ReadArray(arr->shape, arr->ndim);
    arr->strides = nullptr;
    this->Read(&(arr->byte_offset));

    uint64_t num_bytes;
    this->Read(&num_bytes);

    uint8_t* data_ptr;
    int call_ecode = 0;
    if (arr->device.device_type == kDLCPU) {
      data_ptr = reinterpret_cast<uint8_t*>(data_handle) + arr->byte_offset;
    } else {
      data_ptr = this->ArenaAlloc<uint8_t>(num_bytes);
      DLTensor temp;
      temp.data = reinterpret_cast<void*>(data_ptr);
      temp.device = DLDevice{kDLCPU, 0};
      temp.ndim = arr->ndim;
      temp.dtype = arr->dtype;
      temp.shape = arr->shape;
      temp.strides = nullptr;
      temp.byte_offset = 0;
      call_ecode = TVMDeviceCopyDataFromTo(arr, &temp, nullptr);
      // need sync to make sure that the copy is completed.
      if (call_ecode == 0) {
        call_ecode = TVMSynchronize(arr->device.device_type, arr->device.device_id, nullptr);
      }
    }

    if (call_ecode == 0) {
      RPCCode code = RPCCode::kCopyAck;
      uint64_t packet_nbytes = sizeof(code) + num_bytes;

      io_->MessageStart(packet_nbytes);
      this->Write(packet_nbytes);
      this->Write(code);
      this->WriteArray(data_ptr, num_bytes);
      io_->MessageDone();
    } else {
      this->ReturnLastTVMError();
    }
  }

  void HandleCopyToRemote() {
    DLTensor* arr = this->ArenaAlloc<DLTensor>(1);
    uint64_t data_handle;
    this->Read(&data_handle);
    arr->data = reinterpret_cast<void*>(data_handle);
    this->Read(&(arr->device));
    this->Read(&(arr->ndim));
    this->Read(&(arr->dtype));
    arr->shape = this->ArenaAlloc<int64_t>(arr->ndim);
    this->ReadArray(arr->shape, arr->ndim);
    arr->strides = nullptr;
    this->Read(&(arr->byte_offset));
    uint64_t num_bytes;
    this->Read(&num_bytes);

    int call_ecode = 0;
    if (arr->device.device_type == kDLCPU) {
      uint8_t* dptr = reinterpret_cast<uint8_t*>(data_handle) + arr->byte_offset;
      this->ReadArray(dptr, num_bytes);
    } else {
      uint8_t* temp_data = this->ArenaAlloc<uint8_t>(num_bytes);
      this->ReadArray(temp_data, num_bytes);
      DLTensor temp;
      temp.data = temp_data;
      temp.device = DLDevice{kDLCPU, 0};
      temp.ndim = arr->ndim;
      temp.dtype = arr->dtype;
      temp.shape = arr->shape;
      temp.strides = nullptr;
      temp.byte_offset = 0;
      call_ecode = TVMDeviceCopyDataFromTo(&temp, arr, nullptr);
      // need sync to make sure that the copy is completed.
      if (call_ecode == 0) {
        call_ecode = TVMSynchronize(arr->device.device_type, arr->device.device_id, nullptr);
      }
    }

    if (call_ecode == 0) {
      this->ReturnVoid();
    } else {
      this->ReturnLastTVMError();
    }
  }

  void HandleSyscallFunc(RPCCode code) {
    TVMValue* values;
    int* tcodes;
    int num_args;
    RecvPackedSeq(&values, &tcodes, &num_args);
    switch (code) {
      case RPCCode::kFreeHandle: {
        this->SyscallFreeHandle(values, tcodes, num_args);
        break;
      }
      case RPCCode::kGetGlobalFunc: {
        this->SyscallGetGlobalFunc(values, tcodes, num_args);
        break;
      }
      case RPCCode::kDevSetDevice: {
        this->ReturnException("SetDevice not supported");
        break;
      }
      case RPCCode::kDevGetAttr: {
        this->ReturnException("GetAttr not supported");
        break;
      }
      case RPCCode::kDevAllocData: {
        this->SyscallDevAllocData(values, tcodes, num_args);
        break;
      }
      case RPCCode::kDevAllocDataWithScope: {
        this->SyscallDevAllocDataWithScope(values, tcodes, num_args);
        break;
      }
      case RPCCode::kDevFreeData: {
        this->SyscallDevFreeData(values, tcodes, num_args);
        break;
      }
      case RPCCode::kDevCreateStream: {
        this->SyscallDevCreateStream(values, tcodes, num_args);
        break;
      }
      case RPCCode::kDevFreeStream: {
        this->SyscallDevFreeStream(values, tcodes, num_args);
        break;
      }
      case RPCCode::kDevStreamSync: {
        this->SyscallDevStreamSync(values, tcodes, num_args);
        break;
      }
      case RPCCode::kDevSetStream: {
        this->SyscallDevSetStream(values, tcodes, num_args);
        break;
      }
      case RPCCode::kCopyAmongRemote: {
        this->SyscallCopyAmongRemote(values, tcodes, num_args);
        break;
      }
      default: {
        this->ReturnException("Syscall not recognized");
        break;
      }
    }
  }

  void HandleInitServer() {
    uint64_t len;
    this->Read(&len);
    char* proto_ver = this->ArenaAlloc<char>(len + 1);
    this->ReadArray(proto_ver, len);

    TVMValue* values;
    int* tcodes;
    int num_args;
    RecvPackedSeq(&values, &tcodes, &num_args);
    MINRPC_CHECK(num_args == 0);
    this->ReturnVoid();
  }

  void SyscallFreeHandle(TVMValue* values, int* tcodes, int num_args) {
    MINRPC_CHECK(num_args == 2);
    MINRPC_CHECK(tcodes[0] == kTVMOpaqueHandle);
    MINRPC_CHECK(tcodes[1] == kDLInt);

    void* handle = values[0].v_handle;
    int64_t type_code = values[1].v_int64;
    int call_ecode;

    if (type_code == kTVMNDArrayHandle) {
      call_ecode = TVMArrayFree(static_cast<TVMArrayHandle>(handle));
    } else if (type_code == kTVMPackedFuncHandle) {
      call_ecode = TVMFuncFree(handle);
    } else {
      MINRPC_CHECK(type_code == kTVMModuleHandle);
      call_ecode = TVMModFree(handle);
    }

    if (call_ecode == 0) {
      this->ReturnVoid();
    } else {
      this->ReturnLastTVMError();
    }
  }

  void SyscallGetGlobalFunc(TVMValue* values, int* tcodes, int num_args) {
    MINRPC_CHECK(num_args == 1);
    MINRPC_CHECK(tcodes[0] == kTVMStr);

    void* handle;
    int call_ecode = TVMFuncGetGlobal(values[0].v_str, &handle);

    if (call_ecode == 0) {
      this->ReturnHandle(handle);
    } else {
      this->ReturnLastTVMError();
    }
  }

  void SyscallCopyAmongRemote(TVMValue* values, int* tcodes, int num_args) {
    MINRPC_CHECK(num_args == 3);
    // from dltensor
    MINRPC_CHECK(tcodes[0] == kTVMDLTensorHandle);
    // to dltensor
    MINRPC_CHECK(tcodes[1] == kTVMDLTensorHandle);
    // stream
    MINRPC_CHECK(tcodes[2] == kTVMOpaqueHandle);

    void* from = values[0].v_handle;
    void* to = values[1].v_handle;
    TVMStreamHandle stream = values[2].v_handle;

    int call_ecode = TVMDeviceCopyDataFromTo(reinterpret_cast<DLTensor*>(from),
                                             reinterpret_cast<DLTensor*>(to), stream);

    if (call_ecode == 0) {
      this->ReturnVoid();
    } else {
      this->ReturnLastTVMError();
    }
  }

  void SyscallDevAllocData(TVMValue* values, int* tcodes, int num_args) {
    MINRPC_CHECK(num_args == 4);
    MINRPC_CHECK(tcodes[0] == kDLDevice);
    MINRPC_CHECK(tcodes[1] == kDLInt);
    MINRPC_CHECK(tcodes[2] == kDLInt);
    MINRPC_CHECK(tcodes[3] == kTVMDataType);

    DLDevice dev = values[0].v_device;
    int64_t nbytes = values[1].v_int64;
    int64_t alignment = values[2].v_int64;
    DLDataType type_hint = values[3].v_type;

    void* handle;
    int call_ecode = TVMDeviceAllocDataSpace(dev, nbytes, alignment, type_hint, &handle);

    if (call_ecode == 0) {
      this->ReturnHandle(handle);
    } else {
      this->ReturnLastTVMError();
    }
  }

  void SyscallDevAllocDataWithScope(TVMValue* values, int* tcodes, int num_args) {
    MINRPC_CHECK(num_args == 2);
    MINRPC_CHECK(tcodes[0] == kTVMDLTensorHandle);
    MINRPC_CHECK(tcodes[1] == kTVMNullptr || tcodes[1] == kTVMStr);

    DLTensor* arr = reinterpret_cast<DLTensor*>(values[0].v_handle);
    const char* mem_scope = (tcodes[1] == kTVMNullptr ? nullptr : values[1].v_str);
    void* handle;
    int call_ecode = TVMDeviceAllocDataSpaceWithScope(arr->device, arr->ndim, arr->shape,
                                                      arr->dtype, mem_scope, &handle);
    if (call_ecode == 0) {
      this->ReturnHandle(handle);
    } else {
      this->ReturnLastTVMError();
    }
  }

  void SyscallDevFreeData(TVMValue* values, int* tcodes, int num_args) {
    MINRPC_CHECK(num_args == 2);
    MINRPC_CHECK(tcodes[0] == kDLDevice);
    MINRPC_CHECK(tcodes[1] == kTVMOpaqueHandle);

    DLDevice dev = values[0].v_device;
    void* handle = values[1].v_handle;

    int call_ecode = TVMDeviceFreeDataSpace(dev, handle);

    if (call_ecode == 0) {
      this->ReturnVoid();
    } else {
      this->ReturnLastTVMError();
    }
  }

  void SyscallDevCreateStream(TVMValue* values, int* tcodes, int num_args) {
    MINRPC_CHECK(num_args == 1);
    MINRPC_CHECK(tcodes[0] == kDLDevice);

    DLDevice dev = values[0].v_device;
    void* handle;

    int call_ecode = TVMStreamCreate(dev.device_type, dev.device_id, &handle);

    if (call_ecode == 0) {
      this->ReturnHandle(handle);
    } else {
      this->ReturnLastTVMError();
    }
  }

  void SyscallDevFreeStream(TVMValue* values, int* tcodes, int num_args) {
    MINRPC_CHECK(num_args == 2);
    MINRPC_CHECK(tcodes[0] == kDLDevice);
    MINRPC_CHECK(tcodes[1] == kTVMOpaqueHandle);

    DLDevice dev = values[0].v_device;
    void* handle = values[1].v_handle;

    int call_ecode = TVMStreamFree(dev.device_type, dev.device_id, handle);

    if (call_ecode == 0) {
      this->ReturnVoid();
    } else {
      this->ReturnLastTVMError();
    }
  }

  void SyscallDevStreamSync(TVMValue* values, int* tcodes, int num_args) {
    MINRPC_CHECK(num_args == 2);
    MINRPC_CHECK(tcodes[0] == kDLDevice);
    MINRPC_CHECK(tcodes[1] == kTVMOpaqueHandle);

    DLDevice dev = values[0].v_device;
    void* handle = values[1].v_handle;

    int call_ecode = TVMSynchronize(dev.device_type, dev.device_id, handle);

    if (call_ecode == 0) {
      this->ReturnVoid();
    } else {
      this->ReturnLastTVMError();
    }
  }

  void SyscallDevSetStream(TVMValue* values, int* tcodes, int num_args) {
    MINRPC_CHECK(num_args == 2);
    MINRPC_CHECK(tcodes[0] == kDLDevice);
    MINRPC_CHECK(tcodes[1] == kTVMOpaqueHandle);

    DLDevice dev = values[0].v_device;
    void* handle = values[1].v_handle;

    int call_ecode = TVMSetStream(dev.device_type, dev.device_id, handle);

    if (call_ecode == 0) {
      this->ReturnVoid();
    } else {
      this->ReturnLastTVMError();
    }
  }

  void ThrowError(RPCServerStatus code, RPCCode info = RPCCode::kNone) {
    io_->Exit(static_cast<int>(code));
  }

  template <typename T>
  T* ArenaAlloc(int count) {
    static_assert(std::is_pod<T>::value, "need to be trival");
    return arena_.template allocate_<T>(count);
  }

  template <typename T>
  void Read(T* data) {
    static_assert(std::is_pod<T>::value, "need to be trival");
    this->ReadRawBytes(data, sizeof(T));
  }

  template <typename T>
  void ReadArray(T* data, size_t count) {
    static_assert(std::is_pod<T>::value, "need to be trival");
    return this->ReadRawBytes(data, sizeof(T) * count);
  }

  template <typename T>
  void Write(const T& data) {
    static_assert(std::is_pod<T>::value, "need to be trival");
    return this->WriteRawBytes(&data, sizeof(T));
  }

  template <typename T>
  void WriteArray(T* data, size_t count) {
    static_assert(std::is_pod<T>::value, "need to be trival");
    return this->WriteRawBytes(data, sizeof(T) * count);
  }

  void MessageStart(uint64_t packet_nbytes) { io_->MessageStart(packet_nbytes); }

  void MessageDone() { io_->MessageDone(); }

 private:
  void RecvPackedSeq(TVMValue** out_values, int** out_tcodes, int* out_num_args) {
    RPCReference::RecvPackedSeq(out_values, out_tcodes, out_num_args, this);
  }

  void ReturnVoid() {
    int32_t num_args = 1;
    int32_t tcode = kTVMNullptr;
    RPCCode code = RPCCode::kReturn;

    uint64_t packet_nbytes = sizeof(code) + sizeof(num_args) + sizeof(tcode);

    io_->MessageStart(packet_nbytes);
    this->Write(packet_nbytes);
    this->Write(code);
    this->Write(num_args);
    this->Write(tcode);
    io_->MessageDone();
  }

  void ReturnHandle(void* handle) {
    int32_t num_args = 1;
    int32_t tcode = kTVMOpaqueHandle;
    RPCCode code = RPCCode::kReturn;
    uint64_t encode_handle = reinterpret_cast<uint64_t>(handle);
    uint64_t packet_nbytes =
        sizeof(code) + sizeof(num_args) + sizeof(tcode) + sizeof(encode_handle);

    io_->MessageStart(packet_nbytes);
    this->Write(packet_nbytes);
    this->Write(code);
    this->Write(num_args);
    this->Write(tcode);
    this->Write(encode_handle);
    io_->MessageDone();
  }

  void ReturnException(const char* msg) { RPCReference::ReturnException(msg, this); }

  void ReturnPackedSeq(const TVMValue* arg_values, const int* type_codes, int num_args) {
    RPCReference::ReturnPackedSeq(arg_values, type_codes, num_args, this);
  }

  void ReturnLastTVMError() { this->ReturnException(TVMGetLastError()); }

  void ReadRawBytes(void* data, size_t size) {
    uint8_t* buf = reinterpret_cast<uint8_t*>(data);
    size_t ndone = 0;
    while (ndone < size) {
      ssize_t ret = io_->PosixRead(buf, size - ndone);
      if (ret == 0) {
        if (allow_clean_shutdown_) {
          this->Shutdown();
          io_->Exit(0);
        } else {
          this->ThrowError(RPCServerStatus::kReadError);
        }
      }
      if (ret == -1) {
        this->ThrowError(RPCServerStatus::kReadError);
      }
      ndone += ret;
      buf += ret;
    }
  }

  void WriteRawBytes(const void* data, size_t size) {
    const uint8_t* buf = reinterpret_cast<const uint8_t*>(data);
    size_t ndone = 0;
    while (ndone < size) {
      ssize_t ret = io_->PosixWrite(buf, size - ndone);
      if (ret == 0 || ret == -1) {
        this->ThrowError(RPCServerStatus::kWriteError);
      }
      buf += ret;
      ndone += ret;
    }
  }

  /*! \brief IO handler. */
  TIOHandler* io_;
  /*! \brief internal arena. */
  support::GenericArena<PageAllocator> arena_;
  /*! \brief Whether we are in a state that allows clean shutdown. */
  bool allow_clean_shutdown_{true};
  static_assert(DMLC_LITTLE_ENDIAN, "MinRPC only works on little endian.");
};

namespace detail {
// Internal allocator that redirects alloc to TVM's C API.
template <typename TIOHandler>
class PageAllocator {
 public:
  using ArenaPageHeader = tvm::support::ArenaPageHeader;

  explicit PageAllocator(TIOHandler* io) : io_(io) {}

  ArenaPageHeader* allocate(size_t min_size) {
    size_t npages = ((min_size + kPageSize - 1) / kPageSize);
    void* data;

    if (TVMDeviceAllocDataSpace(DLDevice{kDLCPU, 0}, npages * kPageSize, kPageAlign,
                                DLDataType{kDLInt, 1, 1}, &data) != 0) {
      io_->Exit(static_cast<int>(RPCServerStatus::kAllocError));
    }

    ArenaPageHeader* header = static_cast<ArenaPageHeader*>(data);
    header->size = npages * kPageSize;
    header->offset = sizeof(ArenaPageHeader);
    return header;
  }

  void deallocate(ArenaPageHeader* page) {
    if (TVMDeviceFreeDataSpace(DLDevice{kDLCPU, 0}, page) != 0) {
      io_->Exit(static_cast<int>(RPCServerStatus::kAllocError));
    }
  }

  static const constexpr int kPageSize = 2 << 10;
  static const constexpr int kPageAlign = 8;

 private:
  TIOHandler* io_;
};
}  // namespace detail

}  // namespace runtime
}  // namespace tvm
#endif  // TVM_RUNTIME_MINRPC_MINRPC_SERVER_H_
