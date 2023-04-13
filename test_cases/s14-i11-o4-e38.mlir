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
    %26 = stencil.apply (%arg15 = %21 : !stencil.temp<?x?x?xf64>, %arg16 = %22 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -1.000000e+00 : f64
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = subf %cst, %43 : f64
      %46 = divf %cst, %43 : f64
      %47 = addf %41, %42 : f64
      %48 = addf %46, %47 : f64
      %49 = mulf %46, %47 : f64
      %50 = subf %44, %45 : f64
      %51 = divf %48, %49 : f64
      %52 = subf %48, %49 : f64
      %53 = divf %50, %51 : f64
      %54 = addf %52, %53 : f64
      %55 = stencil.store_result %54 : (f64) -> !stencil.result<f64>
      stencil.return %55 : !stencil.result<f64>
    }
    %27 = stencil.apply (%arg15 = %26 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -1.000000e+00 : f64
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = mulf %cst, %42 : f64
      %45 = addf %41, %44 : f64
      %46 = addf %43, %45 : f64
      %47 = stencil.store_result %46 : (f64) -> !stencil.result<f64>
      stencil.return %47 : !stencil.result<f64>
    }

    %28 = stencil.apply (%arg15 = %22 : !stencil.temp<?x?x?xf64>, %arg16 = %27 : !stencil.temp<?x?x?xf64>, %arg17 = %23 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 2.000000e+00 : f64
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg17 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg16 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = addf %41, %42 : f64
      %49 = mulf %41, %42 : f64
      %50 = mulf %46, %48 : f64
      %51 = divf %43, %44 : f64
      %52 = subf %45, %47 : f64
      %53 = addf %cst, %49 : f64
      %54 = mulf %50, %51 : f64
      %55 = mulf %52, %53 : f64
      %56 = divf %52, %53 : f64
      %57 = mulf %56, %55 : f64
      %58 = mulf %57, %54 : f64
      %59 = divf %57, %54 : f64
      %60 = divf %58, %59 : f64
      %61 = stencil.store_result %60 : (f64) -> !stencil.result<f64>
      stencil.return %61 : !stencil.result<f64>
    }
    %29 = stencil.apply (%arg15 = %22 : !stencil.temp<?x?x?xf64>, %arg16 = %27 : !stencil.temp<?x?x?xf64>, %arg17 = %23 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = subf %42, %43 : f64
      %48 = subf %41, %44 : f64
      %49 = divf %45, %46 : f64
      %50 = mulf %47, %49 : f64
      %51 = divf %47, %49 : f64
      %52 = divf %50, %48 : f64
      %53 = divf %51, %52 : f64
      %54 = mulf %51, %52 : f64
      %55 = subf %54, %53 : f64
      %56 = divf %54, %53 : f64
      %57 = divf %55, %56 : f64
      %58 = stencil.store_result %57 : (f64) -> !stencil.result<f64>
      stencil.return %58 : !stencil.result<f64>
    }
    %30 = stencil.apply (%arg15 = %22 : !stencil.temp<?x?x?xf64>, %arg16 = %27 : !stencil.temp<?x?x?xf64>, %arg17 = %23 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -1.000000e+00 : f64
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg16 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = divf %47, %45 : f64
      %50 = mulf %cst, %46 : f64
      %51 = subf %41, %42 : f64
      %52 = mulf %43, %44 : f64
      %53 = subf %49, %48 : f64
      %54 = divf %50, %51 : f64
      %55 = mulf %52, %53 : f64
      %56 = subf %54, %55 : f64
      %57 = stencil.store_result %56 : (f64) -> !stencil.result<f64>
      stencil.return %57 : !stencil.result<f64>
    }
    %31 = stencil.apply (%arg15 = %22 : !stencil.temp<?x?x?xf64>, %arg16 = %27 : !stencil.temp<?x?x?xf64>, %arg17 = %23 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -1.000000e+00 : f64
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg16 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = mulf %44, %cst : f64
      %49 = subf %47, %43 : f64
      %50 = subf %48, %46 : f64
      %51 = subf %41, %42 : f64
      %52 = mulf %45, %49 : f64
      %53 = subf %52, %51 : f64
      %54 = addf %50, %53 : f64
      %55 = mulf %50, %53 : f64
      %56 = addf %55, %54 : f64
      %57 = stencil.store_result %56 : (f64) -> !stencil.result<f64>
      stencil.return %57 : !stencil.result<f64>
    }
    %32 = stencil.apply (%arg15 = %19 : !stencil.temp<?x?x?xf64>, %arg16 = %20 : !stencil.temp<?x?x?xf64>, %arg17 = %28 : !stencil.temp<?x?x?xf64>, %arg18 = %24 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg15 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg16 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg16 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = stencil.access %arg18 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %51 = subf %47, %44 : f64
      %52 = mulf %42, %43 : f64
      %53 = mulf %45, %49 : f64
      %54 = subf %41, %46 : f64
      %55 = divf %48, %53 : f64
      %56 = subf %50, %54 : f64
      %57 = mulf %50, %54 : f64
      %58 = subf %51, %52 : f64
      %59 = addf %55, %57 : f64
      %60 = mulf %56, %58 : f64
      %61 = subf %59, %60 : f64
      %62 = stencil.store_result %61 : (f64) -> !stencil.result<f64>
      stencil.return %62 : !stencil.result<f64>
    }
    %33 = stencil.apply (%arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %18 : !stencil.temp<?x?x?xf64>, %arg17 = %29 : !stencil.temp<?x?x?xf64>, %arg18 = %24 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -5.000000e-01 : f64
      %41 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg16 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg16 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = stencil.access %arg18 [1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %51 = stencil.access %arg18 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %52 = divf %41, %42 : f64
      %53 = addf %48, %49 : f64
      %54 = subf %43, %44 : f64
      %55 = addf %45, %46 : f64
      %56 = mulf %47, %50 : f64
      %57 = addf %55, %54 : f64
      %58 = mulf %55, %54 : f64
      %59 = addf %51, %cst : f64
      %60 = mulf %59, %57 : f64
      %61 = mulf %52, %53 : f64
      %62 = divf %56, %58 : f64
      %63 = addf %62, %60 : f64
      %64 = addf %61, %63 : f64
      %65 = mulf %61, %63 : f64
      %66 = subf %64, %65 : f64
      %67 = stencil.store_result %66 : (f64) -> !stencil.result<f64>
      stencil.return %67 : !stencil.result<f64>
    }
    %34 = stencil.apply (%arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %18 : !stencil.temp<?x?x?xf64>, %arg17 = %30 : !stencil.temp<?x?x?xf64>, %arg18 = %24 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -1.000000e+00 : f64
      %41 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg16 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg18 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = mulf %cst, %46 : f64
      %51 = addf %42, %41 : f64
      %52 = divf %44, %45 : f64
      %53 = mulf %51, %47 : f64
      %54 = subf %43, %48 : f64
      %55 = mulf %49, %50 : f64
      %56 = mulf %52, %54 : f64
      %57 = subf %52, %54 : f64
      %58 = addf %53, %56 : f64
      %59 = mulf %53, %56 : f64
      %60 = addf %55, %57 : f64
      %61 = mulf %58, %59 : f64
      %62 = addf %58, %59 : f64
      %63 = divf %62, %61 : f64
      %64 = subf %62, %61 : f64
      %65 = divf %63, %60 : f64
      %66 = subf %65, %64 : f64
      %67 = addf %65, %64 : f64
      %68 = addf %66, %67 : f64
      %69 = subf %66, %67 : f64
      %70 = mulf %69, %68 : f64
      %71 = addf %69, %68 : f64
      %72 = mulf %70, %71 : f64
      %73 = addf %70, %71 : f64
      %74 = divf %72, %73 : f64
      %75 = stencil.store_result %74 : (f64) -> !stencil.result<f64>
      stencil.return %75 : !stencil.result<f64>
    }
    %35 = stencil.apply (%arg15 = %15 : !stencil.temp<?x?x?xf64>, %arg16 = %16 : !stencil.temp<?x?x?xf64>, %arg17 = %31 : !stencil.temp<?x?x?xf64>, %arg18 = %24 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 0.66666669999999995 : f64
      %41 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg18 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg18 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = divf %45, %46 : f64
      %49 = addf %43, %47 : f64
      %50 = divf %43, %47 : f64
      %51 = addf %41, %42 : f64
      %52 = mulf %41, %42 : f64
      %53 = subf %44, %cst : f64
      %54 = divf %51, %53 : f64
      %55 = divf %48, %49 : f64
      %56 = divf %50, %52 : f64
      %57 = subf %50, %52 : f64
      %58 = addf %54, %55 : f64
      %59 = subf %54, %55 : f64
      %60 = mulf %57, %59 : f64
      %61 = subf %57, %59 : f64
      %62 = addf %56, %58 : f64
      %63 = divf %60, %61 : f64
      %64 = addf %63, %62 : f64
      %65 = stencil.store_result %64 : (f64) -> !stencil.result<f64>
      stencil.return %65 : !stencil.result<f64>
    }
    %36 = stencil.apply (%arg15 = %21 : !stencil.temp<?x?x?xf64>, %arg16 = %32 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -5.000000e-01 : f64
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = mulf %43, %cst : f64
      %46 = subf %41, %42 : f64
      %47 = mulf %46, %45 : f64
      %48 = mulf %44, %47 : f64
      %49 = stencil.store_result %48 : (f64) -> !stencil.result<f64>
      stencil.return %49 : !stencil.result<f64>
    }
    %37 = stencil.apply (%arg15 = %25 : !stencil.temp<?x?x?xf64>, %arg16 = %33 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = addf %41, %42 : f64
      %46 = mulf %44, %45 : f64
      %47 = subf %43, %46 : f64
      %48 = stencil.store_result %47 : (f64) -> !stencil.result<f64>
      stencil.return %48 : !stencil.result<f64>
    }
    %38 = stencil.apply (%arg15 = %34 : !stencil.temp<?x?x?xf64>, %arg16 = %37 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -2.000000e+00 : f64
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = addf %41, %42 : f64
      %48 = subf %43, %44 : f64
      %49 = addf %cst, %48 : f64
      %50 = subf %45, %46 : f64
      %51 = mulf %47, %49 : f64
      %52 = addf %47, %49 : f64
      %53 = divf %50, %51 : f64
      %54 = subf %50, %51 : f64
      %55 = mulf %52, %53 : f64
      %56 = divf %54, %55 : f64
      %57 = stencil.store_result %56 : (f64) -> !stencil.result<f64>
      stencil.return %57 : !stencil.result<f64>
    }

    %39 = stencil.apply (%arg15 = %38 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -1.000000e+00 : f64
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = mulf %cst, %42 : f64
      %45 = addf %41, %44 : f64
      %46 = addf %43, %45 : f64
      %47 = stencil.store_result %46 : (f64) -> !stencil.result<f64>
      stencil.return %47 : !stencil.result<f64>
    }
    stencil.store %36 to %11([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %37 to %12([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %38 to %13([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %39 to %14([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    return
  }
}

