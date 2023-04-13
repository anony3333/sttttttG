module  {
  func @fastwavesuv(%arg0: !stencil.field<?x?x?xf64>, %arg1: !stencil.field<?x?x?xf64>, %arg2: !stencil.field<?x?x?xf64>, %arg3: !stencil.field<?x?x?xf64>, %arg4: !stencil.field<?x?x?xf64>, %arg5: !stencil.field<?x?x?xf64>, %arg6: !stencil.field<?x?x?xf64>, %arg7: !stencil.field<?x?x?xf64>, %arg8: !stencil.field<?x?x?xf64>, %arg9: !stencil.field<?x?x?xf64>, %arg10: !stencil.field<?x?x?xf64>, %arg11: !stencil.field<?x?x?xf64>, %arg12: !stencil.field<?x?x?xf64>, %arg13: !stencil.field<?x?x?xf64>, %arg14: !stencil.field<?x?x?xf64>) attributes {stencil.program} {
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
    %15 = stencil.load %0 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %16 = stencil.load %1 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %17 = stencil.load %2 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %18 = stencil.load %3 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %19 = stencil.load %4 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %20 = stencil.load %5 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %21 = stencil.load %6 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %22 = stencil.load %7 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %23 = stencil.load %8 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %24 = stencil.load %9 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %25 = stencil.load %10 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %26 = stencil.load %11 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %27 = stencil.apply (%arg15 = %15 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = subf %41, %42 : f64
      %48 = divf %46, %47 : f64
      %49 = mulf %46, %47 : f64
      %50 = addf %43, %44 : f64
      %51 = subf %50, %49 : f64
      %52 = divf %51, %45 : f64
      %53 = subf %52, %48 : f64
      %54 = stencil.store_result %53 : (f64) -> !stencil.result<f64>
      stencil.return %54 : !stencil.result<f64>
    }
    %28 = stencil.apply (%arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -0.66666669999999995 : f64
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg16 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = addf %41, %42 : f64
      %50 = subf %43, %44 : f64
      %51 = subf %45, %46 : f64
      %52 = divf %47, %51 : f64
      %53 = divf %49, %48 : f64
      %54 = subf %cst, %50 : f64
      %55 = mulf %52, %53 : f64
      %56 = subf %52, %53 : f64
      %57 = addf %54, %55 : f64
      %58 = addf %57, %56 : f64
      %59 = stencil.store_result %58 : (f64) -> !stencil.result<f64>
      stencil.return %59 : !stencil.result<f64>
    }
    %29 = stencil.apply (%arg15 = %28 : !stencil.temp<?x?x?xf64>, %arg16 = %18 : !stencil.temp<?x?x?xf64>, %arg17 = %21 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -0.66666669999999995 : f64
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = subf %41, %45 : f64
      %49 = divf %41, %45 : f64
      %50 = addf %42, %43 : f64
      %51 = subf %44, %46 : f64
      %52 = mulf %49, %50 : f64
      %53 = addf %47, %cst : f64
      %54 = addf %53, %52 : f64
      %55 = mulf %48, %51 : f64
      %56 = addf %48, %51 : f64
      %57 = divf %54, %56 : f64
      %58 = addf %55, %57 : f64
      %59 = stencil.store_result %58 : (f64) -> !stencil.result<f64>
      stencil.return %59 : !stencil.result<f64>
    }
    %30 = stencil.apply (%arg15 = %21 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = addf %41, %42 : f64
      %44 = mulf %41, %42 : f64
      %45 = divf %43, %44 : f64
      %46 = stencil.store_result %45 : (f64) -> !stencil.result<f64>
      stencil.return %46 : !stencil.result<f64>
    }
    %31 = stencil.apply (%arg15 = %19 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -2.000000e+00 : f64
      %41 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg17 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg16 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = subf %41, %cst : f64
      %49 = subf %45, %43 : f64
      %50 = mulf %45, %43 : f64
      %51 = divf %42, %44 : f64
      %52 = subf %42, %44 : f64
      %53 = addf %46, %47 : f64
      %54 = divf %48, %49 : f64
      %55 = addf %50, %51 : f64
      %56 = addf %52, %53 : f64
      %57 = mulf %54, %55 : f64
      %58 = subf %57, %56 : f64
      %59 = stencil.store_result %58 : (f64) -> !stencil.result<f64>
      stencil.return %59 : !stencil.result<f64>
    }
    %32 = stencil.apply (%arg15 = %20 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = divf %41, %42 : f64
      %47 = mulf %43, %46 : f64
      %48 = addf %43, %46 : f64
      %49 = mulf %44, %45 : f64
      %50 = divf %47, %48 : f64
      %51 = addf %49, %50 : f64
      %52 = mulf %49, %50 : f64
      %53 = mulf %51, %52 : f64
      %54 = addf %51, %52 : f64
      %55 = addf %54, %53 : f64
      %56 = stencil.store_result %55 : (f64) -> !stencil.result<f64>
      stencil.return %56 : !stencil.result<f64>
    }
    %33 = stencil.apply (%arg15 = %27 : !stencil.temp<?x?x?xf64>, %arg16 = %28 : !stencil.temp<?x?x?xf64>, %arg17 = %25 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -1.000000e+00 : f64
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg17 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = divf %44, %48 : f64
      %50 = mulf %43, %49 : f64
      %51 = addf %46, %45 : f64
      %52 = divf %46, %45 : f64
      %53 = addf %cst, %41 : f64
      %54 = divf %cst, %41 : f64
      %55 = mulf %42, %47 : f64
      %56 = divf %53, %52 : f64
      %57 = mulf %55, %50 : f64
      %58 = subf %57, %54 : f64
      %59 = mulf %57, %54 : f64
      %60 = addf %51, %56 : f64
      %61 = mulf %58, %59 : f64
      %62 = addf %61, %60 : f64
      %63 = stencil.store_result %62 : (f64) -> !stencil.result<f64>
      stencil.return %63 : !stencil.result<f64>
    }
    %34 = stencil.apply (%arg15 = %15 : !stencil.temp<?x?x?xf64>, %arg16 = %27 : !stencil.temp<?x?x?xf64>, %arg17 = %28 : !stencil.temp<?x?x?xf64>, %arg18 = %21 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 1.000000e+00 : f64
      %41 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg18 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg18 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg17 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = divf %42, %47 : f64
      %50 = divf %41, %49 : f64
      %51 = addf %43, %44 : f64
      %52 = divf %46, %51 : f64
      %53 = addf %45, %48 : f64
      %54 = mulf %cst, %52 : f64
      %55 = subf %50, %54 : f64
      %56 = mulf %53, %55 : f64
      %57 = stencil.store_result %56 : (f64) -> !stencil.result<f64>
      stencil.return %57 : !stencil.result<f64>
    }
    %35 = stencil.apply (%arg15 = %34 : !stencil.temp<?x?x?xf64>, %arg16 = %22 : !stencil.temp<?x?x?xf64>, %arg17 = %29 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -0.66666669999999995 : f64
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = divf %43, %cst : f64
      %47 = addf %43, %cst : f64
      %48 = mulf %47, %45 : f64
      %49 = divf %41, %42 : f64
      %50 = addf %49, %44 : f64
      %51 = addf %46, %48 : f64
      %52 = subf %50, %51 : f64
      %53 = stencil.store_result %52 : (f64) -> !stencil.result<f64>
      stencil.return %53 : !stencil.result<f64>
    }
    %36 = stencil.apply (%arg15 = %21 : !stencil.temp<?x?x?xf64>, %arg16 = %18 : !stencil.temp<?x?x?xf64>, %arg17 = %31 : !stencil.temp<?x?x?xf64>, %arg18 = %19 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %41 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg18 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg17 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = divf %41, %42 : f64
      %47 = divf %43, %44 : f64
      %48 = divf %46, %45 : f64
      %49 = addf %48, %47 : f64
      %50 = stencil.store_result %49 : (f64) -> !stencil.result<f64>
      stencil.return %50 : !stencil.result<f64>
    }
    %37 = stencil.apply (%arg15 = %21 : !stencil.temp<?x?x?xf64>, %arg16 = %18 : !stencil.temp<?x?x?xf64>, %arg17 = %32 : !stencil.temp<?x?x?xf64>, %arg18 = %20 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg16 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg17 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg17 [1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = stencil.access %arg18 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %51 = mulf %41, %42 : f64
      %52 = divf %43, %44 : f64
      %53 = addf %52, %45 : f64
      %54 = mulf %52, %45 : f64
      %55 = addf %46, %47 : f64
      %56 = addf %53, %50 : f64
      %57 = mulf %53, %50 : f64
      %58 = subf %48, %49 : f64
      %59 = mulf %51, %54 : f64
      %60 = divf %51, %54 : f64
      %61 = mulf %55, %56 : f64
      %62 = addf %55, %56 : f64
      %63 = divf %57, %58 : f64
      %64 = addf %59, %60 : f64
      %65 = addf %61, %62 : f64
      %66 = subf %63, %64 : f64
      %67 = subf %65, %66 : f64
      %68 = stencil.store_result %67 : (f64) -> !stencil.result<f64>
      stencil.return %68 : !stencil.result<f64>
    }
    %38 = stencil.apply (%arg15 = %34 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>, %arg17 = %35 : !stencil.temp<?x?x?xf64>, %arg18 = %30 : !stencil.temp<?x?x?xf64>, %arg19 = %26 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg19 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg19 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg19 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = mulf %42, %44 : f64
      %50 = subf %41, %43 : f64
      %51 = addf %45, %46 : f64
      %52 = divf %47, %48 : f64
      %53 = addf %49, %50 : f64
      %54 = addf %51, %52 : f64
      %55 = divf %53, %54 : f64
      %56 = stencil.store_result %55 : (f64) -> !stencil.result<f64>
      stencil.return %56 : !stencil.result<f64>
    }
    %39 = stencil.apply (%arg15 = %35 : !stencil.temp<?x?x?xf64>, %arg16 = %23 : !stencil.temp<?x?x?xf64>, %arg17 = %24 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %41 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg17 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = addf %41, %42 : f64
      %46 = addf %43, %44 : f64
      %47 = mulf %45, %46 : f64
      %48 = stencil.store_result %47 : (f64) -> !stencil.result<f64>
      stencil.return %48 : !stencil.result<f64>
    }
    %40 = stencil.apply (%arg15 = %36 : !stencil.temp<?x?x?xf64>, %arg16 = %37 : !stencil.temp<?x?x?xf64>, %arg17 = %33 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %41 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = mulf %43, %47 : f64
      %49 = mulf %41, %42 : f64
      %50 = addf %41, %42 : f64
      %51 = mulf %44, %46 : f64
      %52 = mulf %45, %48 : f64
      %53 = addf %49, %50 : f64
      %54 = mulf %51, %52 : f64
      %55 = subf %53, %54 : f64
      %56 = stencil.store_result %55 : (f64) -> !stencil.result<f64>
      stencil.return %56 : !stencil.result<f64>
    }
    stencil.store %38 to %12([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %39 to %13([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %40 to %14([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    return
  }
}

