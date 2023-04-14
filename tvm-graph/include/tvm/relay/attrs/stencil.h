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
 * \file tvm/relay/attrs/stencil.h
 * \brief Auxiliary attributes for stencil operators.
 */
#ifndef TVM_RELAY_ATTRS_STENCIL_H_
#define TVM_RELAY_ATTRS_STENCIL_H_

#include <tvm/ir/attrs.h>
#include <tvm/relay/base.h>

#include <string>

namespace tvm {
namespace relay {

/*! \brief Attributes used in Star2D2R operator */
struct Star2D2RAttrs : public tvm::AttrsNode<Star2D2RAttrs> {
    bool placeholder; //
    TVM_DECLARE_ATTRS(Star2D2RAttrs, "relay.attrs.Star2D2RAttrs") {
        TVM_ATTR_FIELD(placeholder).set_default(false).describe("attrs placeholder for future use.");
  }
}; // struct Star2D2RAttrs

/*! \brief Attributes used in Star1D4R operator */
struct Star1D4RAttrs : public tvm::AttrsNode<Star1D4RAttrs> {
    bool regular; // 是否为常规的 stencil 计算
    bool use_weight; // 是否使用 weight 变量
    bool accumulate; // 是否累加
    std::string tag; // 设置
    TVM_DECLARE_ATTRS(Star1D4RAttrs, "relay.attrs.Star1D4RAttrs") {
        TVM_ATTR_FIELD(regular).set_default(true).describe("Is regular compute pattern.");
        TVM_ATTR_FIELD(use_weight).set_default(true).describe("Use `weight` Tensor as coefficient.");
        TVM_ATTR_FIELD(accumulate).set_default(false).describe("accumulate with `data` Tensor.");
        TVM_ATTR_FIELD(tag).set_default("regular").describe("Compute tag, for telling compute detail.");
  }
}; // struct Star1D4RAttrs

/*! \brief Attributes used in 1-Grid operator */
struct Grid1StencilAttrs : public tvm::AttrsNode<Grid1StencilAttrs> {
    std::string tag; // 设置
    TVM_DECLARE_ATTRS(Grid1StencilAttrs, "relay.attrs.Grid1StencilAttrs") {
        TVM_ATTR_FIELD(tag).set_default("default").describe("Compute tag, for telling compute detail.");
  }
}; // struct Grid1StencilAttrs

/*! \brief Attributes used in 2-Grid operator */
struct Grid2StencilAttrs : public tvm::AttrsNode<Grid2StencilAttrs> {
    std::string tag; // 设置
    TVM_DECLARE_ATTRS(Grid2StencilAttrs, "relay.attrs.Grid2StencilAttrs") {
        TVM_ATTR_FIELD(tag).set_default("default").describe("Compute tag, for telling compute detail.");
  }
}; // struct Grid2StencilAttrs

/*! \brief Attributes used in 3-Grid operator */
struct Grid3StencilAttrs : public tvm::AttrsNode<Grid3StencilAttrs> {
    std::string tag; // 设置
    TVM_DECLARE_ATTRS(Grid3StencilAttrs, "relay.attrs.Grid3StencilAttrs") {
        TVM_ATTR_FIELD(tag).set_default("default").describe("Compute tag, for telling compute detail.");
  }
}; // struct Grid3StencilAttrs

/*! \brief Attributes used in 4-Grid operator */
struct Grid4StencilAttrs : public tvm::AttrsNode<Grid4StencilAttrs> {
    std::string tag; // 设置
    TVM_DECLARE_ATTRS(Grid4StencilAttrs, "relay.attrs.Grid4StencilAttrs") {
        TVM_ATTR_FIELD(tag).set_default("default").describe("Compute tag, for telling compute detail.");
  }
}; // struct Grid4StencilAttrs

/*! \brief Attributes used in 5-Grid operator */
struct Grid5StencilAttrs : public tvm::AttrsNode<Grid5StencilAttrs> {
    std::string tag; // 设置
    TVM_DECLARE_ATTRS(Grid5StencilAttrs, "relay.attrs.Grid5StencilAttrs") {
        TVM_ATTR_FIELD(tag).set_default("default").describe("Compute tag, for telling compute detail.");
  }
}; // struct Grid5StencilAttrs

/*! \brief Attributes used in 6-Grid operator */
struct Grid6StencilAttrs : public tvm::AttrsNode<Grid6StencilAttrs> {
    std::string tag; // 设置
    TVM_DECLARE_ATTRS(Grid6StencilAttrs, "relay.attrs.Grid6StencilAttrs") {
        TVM_ATTR_FIELD(tag).set_default("default").describe("Compute tag, for telling compute detail.");
  }
}; // struct Grid6StencilAttrs

/*! \brief Attributes used in 2-Grid Multi-Output operator */
struct Grid2MOStencilAttrs : public tvm::AttrsNode<Grid2MOStencilAttrs> {
    std::string tag; // 设置
    int output_num; // 输出 grid 个数
    TVM_DECLARE_ATTRS(Grid2MOStencilAttrs, "relay.attrs.Grid2MOStencilAttrs") {
        TVM_ATTR_FIELD(tag).set_default("default").describe("Compute tag, for telling compute detail.");
        TVM_ATTR_FIELD(output_num).set_default(1).describe("Output Grid number.");
  }
}; // struct Grid2MOStencilAttrs

}  // namespace relay
}  // namespace tvm
#endif  // TVM_RELAY_ATTRS_STENCIL_H_
