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
    %24 = stencil.load %11 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %25 = stencil.apply (%arg15 = %15 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %39 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = subf %39, %40 : f64
      %47 = addf %41, %42 : f64
      %48 = subf %41, %42 : f64
      %49 = addf %46, %48 : f64
      %50 = addf %44, %49 : f64
      %51 = divf %43, %45 : f64
      %52 = subf %47, %50 : f64
      %53 = divf %51, %52 : f64
      %54 = stencil.store_result %53 : (f64) -> !stencil.result<f64>
      stencil.return %54 : !stencil.result<f64>
    }
    %26 = stencil.apply (%arg15 = %16 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 5.000000e-01 : f64
      %39 = stencil.access %arg15 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = subf %39, %cst : f64
      %41 = mulf %39, %cst : f64
      %42 = subf %40, %41 : f64
      %43 = stencil.store_result %42 : (f64) -> !stencil.result<f64>
      stencil.return %43 : !stencil.result<f64>
    }
    %27 = stencil.apply (%arg15 = %26 : !stencil.temp<?x?x?xf64>, %arg16 = %18 : !stencil.temp<?x?x?xf64>, %arg17 = %21 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %39 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = mulf %39, %40 : f64
      %46 = addf %39, %40 : f64
      %47 = subf %41, %42 : f64
      %48 = addf %43, %44 : f64
      %49 = divf %45, %46 : f64
      %50 = addf %45, %46 : f64
      %51 = mulf %47, %48 : f64
      %52 = subf %47, %48 : f64
      %53 = divf %49, %50 : f64
      %54 = mulf %49, %50 : f64
      %55 = subf %52, %51 : f64
      %56 = addf %55, %54 : f64
      %57 = subf %55, %54 : f64
      %58 = subf %56, %57 : f64
      %59 = subf %53, %58 : f64
      %60 = stencil.store_result %59 : (f64) -> !stencil.result<f64>
      stencil.return %60 : !stencil.result<f64>
    }
    %28 = stencil.apply (%arg15 = %21 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %39 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg15 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = subf %40, %39 : f64
      %43 = divf %41, %42 : f64
      %44 = addf %41, %42 : f64
      %45 = divf %43, %44 : f64
      %46 = mulf %43, %44 : f64
      %47 = mulf %46, %45 : f64
      %48 = divf %46, %45 : f64
      %49 = addf %47, %48 : f64
      %50 = stencil.store_result %49 : (f64) -> !stencil.result<f64>
      stencil.return %50 : !stencil.result<f64>
    }
    %29 = stencil.apply (%arg15 = %19 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -0.66666669999999995 : f64
      %39 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = mulf %39, %40 : f64
      %43 = mulf %41, %cst : f64
      %44 = mulf %43, %42 : f64
      %45 = stencil.store_result %44 : (f64) -> !stencil.result<f64>
      stencil.return %45 : !stencil.result<f64>
    }
    %30 = stencil.apply (%arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %18 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 1.000000e+00 : f64
      %39 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = mulf %40, %41 : f64
      %44 = mulf %39, %42 : f64
      %45 = mulf %cst, %43 : f64
      %46 = addf %44, %45 : f64
      %47 = stencil.store_result %46 : (f64) -> !stencil.result<f64>
      stencil.return %47 : !stencil.result<f64>
    }
    %31 = stencil.apply (%arg15 = %29 : !stencil.temp<?x?x?xf64>, %arg16 = %30 : !stencil.temp<?x?x?xf64>, %arg17 = %24 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -2.000000e+00 : f64
      %39 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg17 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = addf %39, %40 : f64
      %48 = subf %41, %42 : f64
      %49 = mulf %41, %42 : f64
      %50 = subf %43, %44 : f64
      %51 = subf %50, %cst : f64
      %52 = divf %48, %46 : f64
      %53 = subf %48, %46 : f64
      %54 = mulf %45, %47 : f64
      %55 = subf %53, %54 : f64
      %56 = addf %53, %54 : f64
      %57 = addf %49, %51 : f64
      %58 = divf %52, %55 : f64
      %59 = addf %52, %55 : f64
      %60 = mulf %56, %57 : f64
      %61 = divf %56, %57 : f64
      %62 = mulf %59, %60 : f64
      %63 = divf %61, %62 : f64
      %64 = mulf %58, %63 : f64
      %65 = stencil.store_result %64 : (f64) -> !stencil.result<f64>
      stencil.return %65 : !stencil.result<f64>
    }
    %32 = stencil.apply (%arg15 = %15 : !stencil.temp<?x?x?xf64>, %arg16 = %25 : !stencil.temp<?x?x?xf64>, %arg17 = %26 : !stencil.temp<?x?x?xf64>, %arg18 = %21 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 1.000000e+00 : f64
      %39 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg18 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg18 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = divf %39, %40 : f64
      %50 = subf %39, %40 : f64
      %51 = divf %41, %42 : f64
      %52 = subf %43, %50 : f64
      %53 = addf %44, %45 : f64
      %54 = divf %49, %52 : f64
      %55 = subf %47, %cst : f64
      %56 = divf %54, %53 : f64
      %57 = addf %48, %46 : f64
      %58 = divf %55, %56 : f64
      %59 = mulf %51, %57 : f64
      %60 = addf %58, %59 : f64
      %61 = stencil.store_result %60 : (f64) -> !stencil.result<f64>
      stencil.return %61 : !stencil.result<f64>
    }
    %33 = stencil.apply (%arg15 = %32 : !stencil.temp<?x?x?xf64>, %arg16 = %22 : !stencil.temp<?x?x?xf64>, %arg17 = %27 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %39 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = mulf %41, %42 : f64
      %44 = subf %39, %40 : f64
      %45 = subf %43, %44 : f64
      %46 = stencil.store_result %45 : (f64) -> !stencil.result<f64>
      stencil.return %46 : !stencil.result<f64>
    }
    %34 = stencil.apply (%arg15 = %21 : !stencil.temp<?x?x?xf64>, %arg16 = %18 : !stencil.temp<?x?x?xf64>, %arg17 = %29 : !stencil.temp<?x?x?xf64>, %arg18 = %19 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %39 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg17 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = mulf %41, %46 : f64
      %48 = addf %39, %40 : f64
      %49 = mulf %42, %43 : f64
      %50 = addf %44, %45 : f64
      %51 = addf %47, %48 : f64
      %52 = subf %49, %50 : f64
      %53 = divf %51, %52 : f64
      %54 = stencil.store_result %53 : (f64) -> !stencil.result<f64>
      stencil.return %54 : !stencil.result<f64>
    }
    %35 = stencil.apply (%arg15 = %21 : !stencil.temp<?x?x?xf64>, %arg16 = %18 : !stencil.temp<?x?x?xf64>, %arg17 = %30 : !stencil.temp<?x?x?xf64>, %arg18 = %20 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %39 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg18 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg18 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = divf %39, %40 : f64
      %48 = mulf %45, %47 : f64
      %49 = addf %41, %48 : f64
      %50 = addf %44, %46 : f64
      %51 = subf %44, %46 : f64
      %52 = mulf %42, %43 : f64
      %53 = divf %42, %43 : f64
      %54 = mulf %49, %53 : f64
      %55 = mulf %52, %54 : f64
      %56 = subf %51, %55 : f64
      %57 = addf %56, %50 : f64
      %58 = stencil.store_result %57 : (f64) -> !stencil.result<f64>
      stencil.return %58 : !stencil.result<f64>
    }
    %36 = stencil.apply (%arg15 = %32 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>, %arg18 = %33 : !stencil.temp<?x?x?xf64>, %arg19 = %28 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %39 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg15 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg17 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg19 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg18 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg18 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = divf %39, %40 : f64
      %48 = mulf %45, %43 : f64
      %49 = mulf %41, %42 : f64
      %50 = addf %44, %46 : f64
      %51 = addf %47, %48 : f64
      %52 = divf %47, %48 : f64
      %53 = subf %49, %50 : f64
      %54 = divf %51, %52 : f64
      %55 = mulf %53, %54 : f64
      %56 = stencil.store_result %55 : (f64) -> !stencil.result<f64>
      stencil.return %56 : !stencil.result<f64>
    }
    %37 = stencil.apply (%arg15 = %33 : !stencil.temp<?x?x?xf64>, %arg16 = %27 : !stencil.temp<?x?x?xf64>, %arg17 = %23 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %39 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg17 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg17 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = addf %39, %40 : f64
      %45 = divf %43, %41 : f64
      %46 = subf %42, %44 : f64
      %47 = divf %45, %46 : f64
      %48 = stencil.store_result %47 : (f64) -> !stencil.result<f64>
      stencil.return %48 : !stencil.result<f64>
    }
    %38 = stencil.apply (%arg15 = %34 : !stencil.temp<?x?x?xf64>, %arg16 = %35 : !stencil.temp<?x?x?xf64>, %arg17 = %31 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %39 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = divf %39, %40 : f64
      %45 = addf %43, %44 : f64
      %46 = mulf %41, %42 : f64
      %47 = subf %45, %46 : f64
      %48 = stencil.store_result %47 : (f64) -> !stencil.result<f64>
      stencil.return %48 : !stencil.result<f64>
    }
    stencil.store %36 to %12([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %37 to %13([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %38 to %14([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    return
  }
}

