// RUN: xdsl-opt %s --print-debuginfo | xdsl-opt --print-debuginfo | filecheck %s

%in, %init = "test.op"() : () -> (tensor<4xf32>, tensor<f32>)
%res = linalg.reduce ins(%in:tensor<4xf32>) outs(%init:tensor<f32>) dimensions = [0]
(%lhs : f32, %rhs : f32) {
  %sum = arith.addf %lhs, %rhs : f32
  linalg.yield %sum : f32
}

// CHECK: builtin.module {
// CHECK-NEXT:   %{{.*}}, %{{.*}} = "test.op"() : () -> (tensor<4xf32>, tensor<f32>)
// CHECK-NEXT:   %{{.*}} = linalg.reduce ins(%{{.*}}:tensor<4xf32>) outs(%{{.*}}:tensor<f32>) dimensions = [0]
// CHECK-NEXT:   (%{{.*}} : f32 loc(unknown), %{{.*}} : f32 loc(unknown)) {
// CHECK-NEXT:     %{{.*}} = arith.addf %{{.*}}, %{{.*}} : f32
// CHECK-NEXT:     linalg.yield %{{.*}} : f32
// CHECK-NEXT:   }
// CHECK-NEXT: }
