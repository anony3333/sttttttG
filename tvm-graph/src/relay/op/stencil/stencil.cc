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
 * \file stencil.cc
 * \brief Property def of stencil operators.
 */

#include <tvm/relay/attrs/stencil.h>
#include <tvm/relay/op.h>
#include <algorithm>
#include <string>
#include <vector>

#include "../../transforms/infer_layout_utils.h"
#include "../make_op.h"
#include "../op_common.h"
#include "../type_relations.h"

namespace tvm {
namespace relay {

// star 2d2r
TVM_REGISTER_NODE_TYPE(Star2D2RAttrs);
bool Star2D2RRel(const Array<Type>& types, int num_inputs, const Attrs& attrs, const TypeReporter& reporter) {
  // types: [data, weight, output]
  ICHECK_EQ(types.size(), 3) << "Expects three types, for input, weight and output";
  const auto *data = types[0].as<TensorTypeNode>();
  if (data == nullptr) {
    ICHECK(types[0].as<IncompleteTypeNode>()) << "Star2D2R: expect input type to be TensorType but get " << types[0];
    return false;
  }

//   const auto *param = attrs.as<Star2D2RAttrs>();
  std::vector<IndexExpr> out_shape(data->shape.begin(), data->shape.end());
  reporter->Assign(types[2], TensorType(Array<IndexExpr>(out_shape), data->dtype));
  return true;
}

RELAY_REGISTER_OP("stencil.star2d2r")
    .describe(R"doc(Process star2d2r stencil compute)doc" TVM_ADD_FILELINE)
    .set_num_inputs(2)
    .add_argument("data", "Tensor", "The input tensor")
    .add_argument("weight", "Tensor", "The compute weight")
    .set_support_level(3)
    .add_type_rel("Star2D2R", Star2D2RRel)
    .set_attr<TOpPattern>("TOpPattern", kOutEWiseFusable);


Expr MakeStar2d2r(Expr data, Expr weight, Bool placeholder) {
    auto attrs = make_object<Star2D2RAttrs>();
    attrs->placeholder = placeholder;
    static const Op& op = Op::Get("stencil.star2d2r");
    return Call(op, {data, weight}, Attrs(attrs), {});
}

TVM_REGISTER_GLOBAL("relay.op._make.star2d2r").set_body_typed(MakeStar2d2r);

// star 1d4r
TVM_REGISTER_NODE_TYPE(Star1D4RAttrs);
bool Star1D4RRel(const Array<Type>& types, int num_inputs, const Attrs& attrs, const TypeReporter& reporter) {
  // types: [data, weight, output]
  ICHECK_EQ(types.size(), 3) << "Expects three types, for input, weight and output";
  const auto *data = types[0].as<TensorTypeNode>();
  if (data == nullptr) {
    ICHECK(types[0].as<IncompleteTypeNode>()) << "Star1D4R: expect input type to be TensorType but get " << types[0];
    return false;
  }

  std::vector<IndexExpr> out_shape(data->shape.begin(), data->shape.end());
  reporter->Assign(types[2], TensorType(Array<IndexExpr>(out_shape), data->dtype));
  return true;
}

RELAY_REGISTER_OP("stencil.star1d4r")
    .describe(R"doc(Process star1d4r stencil compute)doc" TVM_ADD_FILELINE)
    .set_num_inputs(2)
    .add_argument("data", "Tensor", "The input tensor")
    .add_argument("weight", "Tensor", "The compute weight")
    .set_support_level(3)
    .add_type_rel("Star1D4R", Star1D4RRel)
    .set_attr<TOpPattern>("TOpPattern", kOutEWiseFusable);


Expr MakeStar1d4r(Expr data, Expr weight, Bool regular, Bool use_weight, Bool accumulate, tvm::String tag) {
    auto attrs = make_object<Star1D4RAttrs>();
    attrs->regular = regular;
    attrs->use_weight = use_weight;
    attrs->accumulate = accumulate;
    attrs->tag = std::move(tag);
    static const Op& op = Op::Get("stencil.star1d4r");
    return Call(op, {data, weight}, Attrs(attrs), {});
}

TVM_REGISTER_GLOBAL("relay.op._make.star1d4r").set_body_typed(MakeStar1d4r);

// 1 grid stencil
TVM_REGISTER_NODE_TYPE(Grid1StencilAttrs);
bool Grid1StencilRel(const Array<Type>& types, int num_inputs, const Attrs& attrs, const TypeReporter& reporter) {
  // types: [data, weight, output]
  ICHECK_EQ(types.size(), 2) << "Expects three types, for input, output";
  const auto *data = types[0].as<TensorTypeNode>();
  if (data == nullptr) {
    ICHECK(types[0].as<IncompleteTypeNode>()) << "Grid2Stencil: expect input type to be TensorType but get " << types[0];
    return false;
  }

  std::vector<IndexExpr> out_shape(data->shape.begin(), data->shape.end());
  reporter->Assign(types[1], TensorType(Array<IndexExpr>(out_shape), data->dtype));
  return true;
}

RELAY_REGISTER_OP("stencil.grid1stencil")
    .describe(R"doc(Process 1 grid stencil compute)doc" TVM_ADD_FILELINE)
    .set_num_inputs(1)
    .add_argument("grid1", "Tensor", "The input tensor")
    .set_support_level(3)
    .add_type_rel("Grid1Stencil", Grid1StencilRel)
    .set_attr<TOpPattern>("TOpPattern", kOutEWiseFusable);


Expr MakeGrid1Stencil(Expr grid1, tvm::String tag) {
    auto attrs = make_object<Grid1StencilAttrs>();
    attrs->tag = std::move(tag);
    static const Op& op = Op::Get("stencil.grid1stencil");
    return Call(op, {grid1}, Attrs(attrs), {});
}

TVM_REGISTER_GLOBAL("relay.op._make.grid1stencil").set_body_typed(MakeGrid1Stencil);

// 2 grid stencil
TVM_REGISTER_NODE_TYPE(Grid2StencilAttrs);
bool Grid2StencilRel(const Array<Type>& types, int num_inputs, const Attrs& attrs, const TypeReporter& reporter) {
  // types: [data, weight, output]
  ICHECK_EQ(types.size(), 3) << "Expects three types, for input, weight and output";
  const auto *data = types[0].as<TensorTypeNode>();
  if (data == nullptr) {
    ICHECK(types[0].as<IncompleteTypeNode>()) << "Grid2Stencil: expect input type to be TensorType but get " << types[0];
    return false;
  }
  data = types[1].as<TensorTypeNode>();
  if (data == nullptr) {
    ICHECK(types[1].as<IncompleteTypeNode>()) << "Grid2Stencil: expect input type to be TensorType but get " << types[1];
    return false;
  }

  std::vector<IndexExpr> out_shape(data->shape.begin(), data->shape.end());
  reporter->Assign(types[2], TensorType(Array<IndexExpr>(out_shape), data->dtype));
  return true;
}

RELAY_REGISTER_OP("stencil.grid2stencil")
    .describe(R"doc(Process 2 grid stencil compute)doc" TVM_ADD_FILELINE)
    .set_num_inputs(2)
    .add_argument("grid1", "Tensor", "The input tensor")
    .add_argument("grid2", "Tensor", "The compute weight")
    .set_support_level(3)
    .add_type_rel("Grid2Stencil", Grid2StencilRel)
    .set_attr<TOpPattern>("TOpPattern", kOutEWiseFusable);


Expr MakeGrid2Stencil(Expr grid1, Expr grid2, tvm::String tag) {
    auto attrs = make_object<Grid2StencilAttrs>();
    attrs->tag = std::move(tag);
    static const Op& op = Op::Get("stencil.grid2stencil");
    return Call(op, {grid1, grid2}, Attrs(attrs), {});
}

TVM_REGISTER_GLOBAL("relay.op._make.grid2stencil").set_body_typed(MakeGrid2Stencil);


// 3 grid stencil
TVM_REGISTER_NODE_TYPE(Grid3StencilAttrs);
bool Grid3StencilRel(const Array<Type>& types, int num_inputs, const Attrs& attrs, const TypeReporter& reporter) {
  // types: [grid1, grid2, grid3, output]
  ICHECK_EQ(types.size(), 4) << "Expects three types, for input, weight and output";
  for (int i = 0; i < 3; i++) {
    const auto *data = types[i].as<TensorTypeNode>();
    if (data == nullptr) {
      ICHECK(types[0].as<IncompleteTypeNode>()) << "Grid3Stencil: expect input type to be TensorType but get " << types[i];
      return false;
    }
  }

  const auto *data = types[0].as<TensorTypeNode>();
  std::vector<IndexExpr> out_shape(data->shape.begin(), data->shape.end());
  reporter->Assign(types[3], TensorType(Array<IndexExpr>(out_shape), data->dtype));
  return true;
}

RELAY_REGISTER_OP("stencil.grid3stencil")
    .describe(R"doc(Process 3 grid stencil compute)doc" TVM_ADD_FILELINE)
    .set_num_inputs(3)
    .add_argument("grid1", "Tensor", "The grid1 tensor")
    .add_argument("grid2", "Tensor", "The grid2 tensor")
    .add_argument("grid3", "Tensor", "The grid3 tensor")
    .set_support_level(3)
    .add_type_rel("Grid3Stencil", Grid3StencilRel)
    .set_attr<TOpPattern>("TOpPattern", kOutEWiseFusable);


Expr MakeGrid3Stencil(Expr grid1, Expr grid2, Expr grid3, tvm::String tag) {
    auto attrs = make_object<Grid3StencilAttrs>();
    attrs->tag = std::move(tag);
    static const Op& op = Op::Get("stencil.grid3stencil");
    return Call(op, {grid1, grid2, grid3}, Attrs(attrs), {});
}

TVM_REGISTER_GLOBAL("relay.op._make.grid3stencil").set_body_typed(MakeGrid3Stencil);


// 4 grid stencil
TVM_REGISTER_NODE_TYPE(Grid4StencilAttrs);
bool Grid4StencilRel(const Array<Type>& types, int num_inputs, const Attrs& attrs, const TypeReporter& reporter) {
  // types: [grid1, grid2, grid3, grid4, output]
  ICHECK_EQ(types.size(), 5) << "Expects three types, for input, weight and output";
  for (int i = 0; i < 4; i++) {
    const auto *data = types[i].as<TensorTypeNode>();
    if (data == nullptr) {
      ICHECK(types[0].as<IncompleteTypeNode>()) << "Grid4Stencil: expect input type to be TensorType but get " << types[i];
      return false;
    }
  }

  const auto *data = types[0].as<TensorTypeNode>();
  std::vector<IndexExpr> out_shape(data->shape.begin(), data->shape.end());
  reporter->Assign(types[4], TensorType(Array<IndexExpr>(out_shape), data->dtype));
  return true;
}

RELAY_REGISTER_OP("stencil.grid4stencil")
    .describe(R"doc(Process 4 grid stencil compute)doc" TVM_ADD_FILELINE)
    .set_num_inputs(4)
    .add_argument("grid1", "Tensor", "The grid1 tensor")
    .add_argument("grid2", "Tensor", "The grid2 tensor")
    .add_argument("grid3", "Tensor", "The grid3 tensor")
    .add_argument("grid4", "Tensor", "The grid4 tensor")
    .set_support_level(3)
    .add_type_rel("Grid4Stencil", Grid4StencilRel)
    .set_attr<TOpPattern>("TOpPattern", kOutEWiseFusable);


Expr MakeGrid4Stencil(Expr grid1, Expr grid2, Expr grid3, Expr grid4, tvm::String tag) {
    auto attrs = make_object<Grid4StencilAttrs>();
    attrs->tag = std::move(tag);
    static const Op& op = Op::Get("stencil.grid4stencil");
    return Call(op, {grid1, grid2, grid3, grid4}, Attrs(attrs), {});
}

TVM_REGISTER_GLOBAL("relay.op._make.grid4stencil").set_body_typed(MakeGrid4Stencil);


// 5 grid stencil
TVM_REGISTER_NODE_TYPE(Grid5StencilAttrs);
bool Grid5StencilRel(const Array<Type>& types, int num_inputs, const Attrs& attrs, const TypeReporter& reporter) {
  // types: [grid1, grid2, grid3, grid4, grid5, output]
  ICHECK_EQ(types.size(), 6) << "Expects three types, for input, weight and output";
  for (int i = 0; i < 5; i++) {
    const auto *data = types[i].as<TensorTypeNode>();
    if (data == nullptr) {
      ICHECK(types[0].as<IncompleteTypeNode>()) << "Grid5Stencil: expect input type to be TensorType but get " << types[i];
      return false;
    }
  }

  const auto *data = types[0].as<TensorTypeNode>();
  std::vector<IndexExpr> out_shape(data->shape.begin(), data->shape.end());
  reporter->Assign(types[5], TensorType(Array<IndexExpr>(out_shape), data->dtype));
  return true;
}

RELAY_REGISTER_OP("stencil.grid5stencil")
    .describe(R"doc(Process 5 grid stencil compute)doc" TVM_ADD_FILELINE)
    .set_num_inputs(5)
    .add_argument("grid1", "Tensor", "The grid1 tensor")
    .add_argument("grid2", "Tensor", "The grid2 tensor")
    .add_argument("grid3", "Tensor", "The grid3 tensor")
    .add_argument("grid4", "Tensor", "The grid4 tensor")
    .add_argument("grid5", "Tensor", "The grid5 tensor")
    .set_support_level(3)
    .add_type_rel("Grid5Stencil", Grid5StencilRel)
    .set_attr<TOpPattern>("TOpPattern", kOutEWiseFusable);


Expr MakeGrid5Stencil(Expr grid1, Expr grid2, Expr grid3, Expr grid4, Expr grid5, tvm::String tag) {
    auto attrs = make_object<Grid5StencilAttrs>();
    attrs->tag = std::move(tag);
    static const Op& op = Op::Get("stencil.grid5stencil");
    return Call(op, {grid1, grid2, grid3, grid4, grid5}, Attrs(attrs), {});
}

TVM_REGISTER_GLOBAL("relay.op._make.grid5stencil").set_body_typed(MakeGrid5Stencil);


// 6 grid stencil
TVM_REGISTER_NODE_TYPE(Grid6StencilAttrs);
bool Grid6StencilRel(const Array<Type>& types, int num_inputs, const Attrs& attrs, const TypeReporter& reporter) {
  // types: [grid1, grid2, grid3, grid4, grid5, grid6, output]
  ICHECK_EQ(types.size(), 7) << "Expects three types, for input, weight and output";
  for (int i = 0; i < 6; i++) {
    const auto *data = types[i].as<TensorTypeNode>();
    if (data == nullptr) {
      ICHECK(types[0].as<IncompleteTypeNode>()) << "Grid6Stencil: expect input type to be TensorType but get " << types[i];
      return false;
    }
  }

  const auto *data = types[0].as<TensorTypeNode>();
  std::vector<IndexExpr> out_shape(data->shape.begin(), data->shape.end());
  reporter->Assign(types[6], TensorType(Array<IndexExpr>(out_shape), data->dtype));
  return true;
}

RELAY_REGISTER_OP("stencil.grid6stencil")
    .describe(R"doc(Process 6 grid stencil compute)doc" TVM_ADD_FILELINE)
    .set_num_inputs(6)
    .add_argument("grid1", "Tensor", "The grid1 tensor")
    .add_argument("grid2", "Tensor", "The grid2 tensor")
    .add_argument("grid3", "Tensor", "The grid3 tensor")
    .add_argument("grid4", "Tensor", "The grid4 tensor")
    .add_argument("grid5", "Tensor", "The grid5 tensor")
    .add_argument("grid6", "Tensor", "The grid6 tensor")
    .set_support_level(3)
    .add_type_rel("Grid6Stencil", Grid6StencilRel)
    .set_attr<TOpPattern>("TOpPattern", kOutEWiseFusable);


Expr MakeGrid6Stencil(Expr grid1, Expr grid2, Expr grid3, Expr grid4, Expr grid5, Expr grid6, tvm::String tag) {
    auto attrs = make_object<Grid6StencilAttrs>();
    attrs->tag = std::move(tag);
    static const Op& op = Op::Get("stencil.grid6stencil");
    return Call(op, {grid1, grid2, grid3, grid4, grid5, grid6}, Attrs(attrs), {});
}

TVM_REGISTER_GLOBAL("relay.op._make.grid6stencil").set_body_typed(MakeGrid6Stencil);


// 2 grid multi-output stencil
TVM_REGISTER_NODE_TYPE(Grid2MOStencilAttrs);
bool Grid2MOStencilRel(const Array<Type>& types, int num_inputs, const Attrs& attrs, const TypeReporter& reporter) {
  // types: [grid1, grid2, out1, ...]
  const auto* param = attrs.as<Grid2MOStencilAttrs>();
  ICHECK(param != nullptr);
  ICHECK_EQ(types.size(), 3) << "Expects three types, for grid1, grid2, output...";
  for (int i = 0; i < 2; i++) {
    const auto *data = types[i].as<TensorTypeNode>();
    if (data == nullptr) {
      ICHECK(types[i].as<IncompleteTypeNode>()) << "Grid2MOStencilAttrs: expect input type to be TensorType but get " << types[i];
      return false;
    }
  }
  const auto *data = types[0].as<TensorTypeNode>();
  std::vector<Type> out_tensor_list;
  for (int i = 0; i < param->output_num; i++) {
    std::vector<IndexExpr> out_shape(data->shape.begin(), data->shape.end());
    auto vec_type = TensorType(out_shape, data->dtype);
    out_tensor_list.push_back(vec_type);
  }
  reporter->Assign(types[2], TupleType(Array<Type>(out_tensor_list)));
  return true;
}

RELAY_REGISTER_OP("stencil.grid2mostencil")
    .describe(R"doc(Process 2 grid stencil multi-output compute)doc" TVM_ADD_FILELINE)
    .set_num_inputs(2)
    .add_argument("grid1", "Tensor", "The input tensor")
    .add_argument("grid2", "Tensor", "The compute weight")
    .set_support_level(3)
    .add_type_rel("Grid2MOStencil", Grid2MOStencilRel)
    .set_attr<TOpPattern>("TOpPattern", kOutEWiseFusable);


Expr MakeGrid2MOStencil(Expr grid1, Expr grid2, tvm::String tag, int output_num) {
    auto attrs = make_object<Grid2MOStencilAttrs>();
    attrs->tag = std::move(tag);
    attrs->output_num = output_num;
    static const Op& op = Op::Get("stencil.grid2mostencil");
    return Call(op, {grid1, grid2}, Attrs(attrs), {});
}

TVM_REGISTER_GLOBAL("relay.op._make.grid2mostencil").set_body_typed(MakeGrid2MOStencil);

}  // namespace relay
}  // namespace tvm
