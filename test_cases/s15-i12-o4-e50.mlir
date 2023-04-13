module  {
  func @fastwavesuv(%arg0: !stencil.field<?x?x?xf64>, %arg1: !stencil.field<?x?x?xf64>, %arg2: !stencil.field<?x?x?xf64>, %arg3: !stencil.field<?x?x?xf64>, %arg4: !stencil.field<?x?x?xf64>, %arg5: !stencil.field<?x?x?xf64>, %arg6: !stencil.field<?x?x?xf64>, %arg7: !stencil.field<?x?x?xf64>, %arg8: !stencil.field<?x?x?xf64>, %arg9: !stencil.field<?x?x?xf64>, %arg10: !stencil.field<?x?x?xf64>, %arg11: !stencil.field<?x?x?xf64>, %arg12: !stencil.field<?x?x?xf64>, %arg13: !stencil.field<?x?x?xf64>, %arg14: !stencil.field<?x?x?xf64>, %arg15: !stencil.field<?x?x?xf64>) attributes {stencil.program} {
    %0 = stencil.cast %arg0([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %1 = stencil.cast %arg1([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %2 = stencil.cast %arg2([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %3 = stencil.cast %arg3([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %4 = stencil.cast %arg4([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %5 = stencil.cast %arg5([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %6 = stencil.cast %arg6([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %7 = stencil.cast %arg7([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %8 = stencil.cast %arg8([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %9 = stencil.cast %arg9([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %10 = stencil.cast %arg10([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %11 = stencil.cast %arg11([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %12 = stencil.cast %arg12([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %13 = stencil.cast %arg13([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %14 = stencil.cast %arg14([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %15 = stencil.cast %arg15([-4, -4, -4] : [68, 68, 68]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<72x72x72xf64>
    %16 = stencil.load %0 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %17 = stencil.load %1 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %18 = stencil.load %2 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %19 = stencil.load %3 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %20 = stencil.load %4 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %21 = stencil.load %5 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %22 = stencil.load %6 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %23 = stencil.load %7 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %24 = stencil.load %8 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %25 = stencil.load %9 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %26 = stencil.load %10 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %27 = stencil.load %11 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %28 = stencil.apply (%arg16 = %16 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>, %arg18 = %19 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %43 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg17 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg18 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = addf %43, %44 : f64
      %51 = mulf %43, %44 : f64
      %52 = subf %45, %46 : f64
      %53 = divf %47, %48 : f64
      %54 = addf %49, %50 : f64
      %55 = divf %51, %52 : f64
      %56 = subf %51, %52 : f64
      %57 = mulf %56, %55 : f64
      %58 = mulf %57, %54 : f64
      %59 = subf %53, %58 : f64
      %60 = stencil.store_result %59 : (f64) -> !stencil.result<f64>
      stencil.return %60 : !stencil.result<f64>
    }
    %29 = stencil.apply (%arg16 = %17 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>, %arg18 = %19 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %43 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg18 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg18 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = divf %47, %48 : f64
      %51 = subf %47, %48 : f64
      %52 = subf %49, %50 : f64
      %53 = subf %43, %44 : f64
      %54 = mulf %43, %44 : f64
      %55 = divf %45, %53 : f64
      %56 = addf %54, %55 : f64
      %57 = divf %54, %55 : f64
      %58 = divf %46, %51 : f64
      %59 = addf %52, %56 : f64
      %60 = addf %57, %58 : f64
      %61 = addf %59, %60 : f64
      %62 = stencil.store_result %61 : (f64) -> !stencil.result<f64>
      stencil.return %62 : !stencil.result<f64>
    }
    %30 = stencil.apply (%arg16 = %22 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %43 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = subf %43, %44 : f64
      %47 = addf %46, %45 : f64
      %48 = mulf %46, %45 : f64
      %49 = addf %47, %48 : f64
      %50 = divf %47, %48 : f64
      %51 = subf %50, %49 : f64
      %52 = stencil.store_result %51 : (f64) -> !stencil.result<f64>
      stencil.return %52 : !stencil.result<f64>
    }
    %31 = stencil.apply (%arg16 = %29 : !stencil.temp<?x?x?xf64>, %arg17 = %19 : !stencil.temp<?x?x?xf64>, %arg18 = %22 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -5.000000e-01 : f64
      %43 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg18 [1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg18 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = subf %48, %47 : f64
      %50 = mulf %43, %44 : f64
      %51 = addf %49, %46 : f64
      %52 = addf %45, %cst : f64
      %53 = subf %45, %cst : f64
      %54 = addf %53, %52 : f64
      %55 = divf %50, %51 : f64
      %56 = subf %54, %55 : f64
      %57 = addf %54, %55 : f64
      %58 = addf %56, %57 : f64
      %59 = mulf %56, %57 : f64
      %60 = mulf %58, %59 : f64
      %61 = stencil.store_result %60 : (f64) -> !stencil.result<f64>
      stencil.return %61 : !stencil.result<f64>
    }
    %32 = stencil.apply (%arg16 = %20 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>, %arg18 = %19 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 1.000000e+00 : f64
      %43 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg18 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = divf %43, %44 : f64
      %50 = mulf %43, %44 : f64
      %51 = subf %45, %48 : f64
      %52 = divf %46, %50 : f64
      %53 = subf %47, %cst : f64
      %54 = addf %49, %51 : f64
      %55 = divf %52, %53 : f64
      %56 = mulf %54, %55 : f64
      %57 = stencil.store_result %56 : (f64) -> !stencil.result<f64>
      stencil.return %57 : !stencil.result<f64>
    }
    %33 = stencil.apply (%arg16 = %21 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>, %arg18 = %19 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %43 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg17 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg18 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = stencil.access %arg18 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %51 = mulf %43, %44 : f64
      %52 = addf %43, %44 : f64
      %53 = subf %49, %51 : f64
      %54 = subf %45, %46 : f64
      %55 = divf %47, %48 : f64
      %56 = divf %53, %52 : f64
      %57 = divf %50, %54 : f64
      %58 = mulf %55, %56 : f64
      %59 = addf %58, %57 : f64
      %60 = stencil.store_result %59 : (f64) -> !stencil.result<f64>
      stencil.return %60 : !stencil.result<f64>
    }
    %34 = stencil.apply (%arg16 = %22 : !stencil.temp<?x?x?xf64>, %arg17 = %19 : !stencil.temp<?x?x?xf64>, %arg18 = %33 : !stencil.temp<?x?x?xf64>, %arg19 = %21 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %43 = stencil.access %arg19 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg16 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg17 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = stencil.access %arg17 [1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %51 = stencil.access %arg18 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %52 = subf %43, %44 : f64
      %53 = subf %46, %45 : f64
      %54 = subf %47, %48 : f64
      %55 = divf %50, %52 : f64
      %56 = addf %55, %54 : f64
      %57 = addf %53, %49 : f64
      %58 = divf %51, %56 : f64
      %59 = divf %57, %58 : f64
      %60 = stencil.store_result %59 : (f64) -> !stencil.result<f64>
      stencil.return %60 : !stencil.result<f64>
    }
    %35 = stencil.apply (%arg16 = %16 : !stencil.temp<?x?x?xf64>, %arg17 = %29 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -5.000000e-01 : f64
      %43 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg17 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = mulf %cst, %43 : f64
      %47 = divf %44, %45 : f64
      %48 = subf %46, %47 : f64
      %49 = stencil.store_result %48 : (f64) -> !stencil.result<f64>
      stencil.return %49 : !stencil.result<f64>
    }
    %36 = stencil.apply (%arg16 = %35 : !stencil.temp<?x?x?xf64>, %arg17 = %23 : !stencil.temp<?x?x?xf64>, %arg18 = %30 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %43 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg18 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = divf %46, %48 : f64
      %50 = subf %46, %48 : f64
      %51 = addf %47, %44 : f64
      %52 = subf %51, %45 : f64
      %53 = addf %43, %49 : f64
      %54 = subf %50, %52 : f64
      %55 = divf %53, %54 : f64
      %56 = subf %53, %54 : f64
      %57 = divf %55, %56 : f64
      %58 = stencil.store_result %57 : (f64) -> !stencil.result<f64>
      stencil.return %58 : !stencil.result<f64>
    }
    %37 = stencil.apply (%arg16 = %35 : !stencil.temp<?x?x?xf64>, %arg17 = %23 : !stencil.temp<?x?x?xf64>, %arg18 = %30 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 2.000000e+00 : f64
      %43 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg17 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg17 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = stencil.access %arg18 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %51 = divf %43, %44 : f64
      %52 = divf %45, %49 : f64
      %53 = subf %48, %46 : f64
      %54 = subf %47, %50 : f64
      %55 = mulf %52, %cst : f64
      %56 = mulf %51, %53 : f64
      %57 = addf %51, %53 : f64
      %58 = subf %54, %55 : f64
      %59 = divf %56, %57 : f64
      %60 = divf %58, %59 : f64
      %61 = subf %58, %59 : f64
      %62 = addf %60, %61 : f64
      %63 = stencil.store_result %62 : (f64) -> !stencil.result<f64>
      stencil.return %63 : !stencil.result<f64>
    }
    %38 = stencil.apply (%arg16 = %22 : !stencil.temp<?x?x?xf64>, %arg17 = %19 : !stencil.temp<?x?x?xf64>, %arg18 = %32 : !stencil.temp<?x?x?xf64>, %arg19 = %20 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %43 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg17 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg19 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = divf %43, %44 : f64
      %48 = addf %45, %46 : f64
      %49 = subf %48, %47 : f64
      %50 = addf %48, %47 : f64
      %51 = subf %49, %50 : f64
      %52 = stencil.store_result %51 : (f64) -> !stencil.result<f64>
      stencil.return %52 : !stencil.result<f64>
    }
    %39 = stencil.apply (%arg16 = %32 : !stencil.temp<?x?x?xf64>, %arg17 = %33 : !stencil.temp<?x?x?xf64>, %arg18 = %27 : !stencil.temp<?x?x?xf64>, %arg19 = %34 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -0.66666669999999995 : f64
      %43 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg19 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg18 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg19 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg19 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = stencil.access %arg17 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %51 = stencil.access %arg17 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %52 = divf %43, %44 : f64
      %53 = addf %45, %47 : f64
      %54 = addf %cst, %52 : f64
      %55 = subf %51, %48 : f64
      %56 = subf %49, %46 : f64
      %57 = mulf %54, %53 : f64
      %58 = divf %50, %55 : f64
      %59 = subf %56, %57 : f64
      %60 = addf %58, %59 : f64
      %61 = stencil.store_result %60 : (f64) -> !stencil.result<f64>
      stencil.return %61 : !stencil.result<f64>
    }
    %40 = stencil.apply (%arg16 = %35 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>, %arg18 = %19 : !stencil.temp<?x?x?xf64>, %arg19 = %31 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 5.000000e-01 : f64
      %43 = stencil.access %arg19 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg18 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = stencil.access %arg17 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %51 = stencil.access %arg19 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %52 = divf %43, %44 : f64
      %53 = mulf %50, %51 : f64
      %54 = subf %52, %47 : f64
      %55 = mulf %45, %46 : f64
      %56 = addf %48, %49 : f64
      %57 = divf %55, %56 : f64
      %58 = divf %cst, %53 : f64
      %59 = addf %54, %57 : f64
      %60 = mulf %58, %59 : f64
      %61 = stencil.store_result %60 : (f64) -> !stencil.result<f64>
      stencil.return %61 : !stencil.result<f64>
    }
    %41 = stencil.apply (%arg16 = %37 : !stencil.temp<?x?x?xf64>, %arg17 = %36 : !stencil.temp<?x?x?xf64>, %arg18 = %30 : !stencil.temp<?x?x?xf64>, %arg19 = %31 : !stencil.temp<?x?x?xf64>, %arg20 = %24 : !stencil.temp<?x?x?xf64>, %arg21 = %25 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %43 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg20 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg21 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg20 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg17 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = stencil.access %arg17 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %51 = stencil.access %arg19 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %52 = addf %46, %47 : f64
      %53 = divf %49, %51 : f64
      %54 = divf %44, %52 : f64
      %55 = mulf %43, %45 : f64
      %56 = mulf %53, %54 : f64
      %57 = divf %48, %50 : f64
      %58 = divf %55, %56 : f64
      %59 = mulf %57, %58 : f64
      %60 = stencil.store_result %59 : (f64) -> !stencil.result<f64>
      stencil.return %60 : !stencil.result<f64>
    }
    %42 = stencil.apply (%arg16 = %28 : !stencil.temp<?x?x?xf64>, %arg17 = %29 : !stencil.temp<?x?x?xf64>, %arg18 = %26 : !stencil.temp<?x?x?xf64>, %arg19 = %38 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %43 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg18 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg18 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = stencil.access %arg19 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %51 = stencil.access %arg19 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %52 = mulf %48, %50 : f64
      %53 = subf %43, %47 : f64
      %54 = mulf %43, %47 : f64
      %55 = addf %44, %45 : f64
      %56 = subf %46, %49 : f64
      %57 = subf %56, %55 : f64
      %58 = mulf %51, %52 : f64
      %59 = addf %57, %53 : f64
      %60 = divf %54, %58 : f64
      %61 = divf %59, %60 : f64
      %62 = stencil.store_result %61 : (f64) -> !stencil.result<f64>
      stencil.return %62 : !stencil.result<f64>
    }
    stencil.store %40 to %12([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %41 to %13([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %42 to %14([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %39 to %15([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    return
  }
}

