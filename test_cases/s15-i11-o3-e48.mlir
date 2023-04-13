module  {
  func @fastwavesuv(%arg0: !stencil.field<?x?x?xf64>, %arg1: !stencil.field<?x?x?xf64>, %arg2: !stencil.field<?x?x?xf64>, %arg3: !stencil.field<?x?x?xf64>, %arg4: !stencil.field<?x?x?xf64>, %arg5: !stencil.field<?x?x?xf64>, %arg6: !stencil.field<?x?x?xf64>, %arg7: !stencil.field<?x?x?xf64>, %arg8: !stencil.field<?x?x?xf64>, %arg9: !stencil.field<?x?x?xf64>, %arg10: !stencil.field<?x?x?xf64>, %arg11: !stencil.field<?x?x?xf64>, %arg12: !stencil.field<?x?x?xf64>, %arg13: !stencil.field<?x?x?xf64>) attributes {stencil.program} {
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
    %14 = stencil.load %0 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %15 = stencil.load %1 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %16 = stencil.load %2 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %17 = stencil.load %3 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %18 = stencil.load %4 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %19 = stencil.load %5 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %20 = stencil.load %6 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %21 = stencil.load %7 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %22 = stencil.load %8 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %23 = stencil.load %9 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %24 = stencil.load %10 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %25 = stencil.apply (%arg14 = %14 : !stencil.temp<?x?x?xf64>, %arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %40 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg14 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = addf %40, %41 : f64
      %47 = divf %42, %43 : f64
      %48 = mulf %42, %43 : f64
      %49 = divf %44, %45 : f64
      %50 = subf %48, %49 : f64
      %51 = mulf %48, %49 : f64
      %52 = subf %46, %47 : f64
      %53 = addf %51, %52 : f64
      %54 = subf %50, %53 : f64
      %55 = stencil.store_result %54 : (f64) -> !stencil.result<f64>
      stencil.return %55 : !stencil.result<f64>
    }
    %26 = stencil.apply (%arg14 = %15 : !stencil.temp<?x?x?xf64>, %arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %40 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg14 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = subf %40, %41 : f64
      %48 = divf %40, %41 : f64
      %49 = divf %45, %47 : f64
      %50 = divf %48, %43 : f64
      %51 = subf %49, %42 : f64
      %52 = divf %49, %42 : f64
      %53 = subf %44, %46 : f64
      %54 = divf %53, %52 : f64
      %55 = divf %50, %51 : f64
      %56 = divf %54, %55 : f64
      %57 = stencil.store_result %56 : (f64) -> !stencil.result<f64>
      stencil.return %57 : !stencil.result<f64>
    }
    %27 = stencil.apply (%arg14 = %26 : !stencil.temp<?x?x?xf64>, %arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %20 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %40 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg14 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg14 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = addf %43, %40 : f64
      %48 = mulf %46, %45 : f64
      %49 = mulf %41, %42 : f64
      %50 = subf %44, %47 : f64
      %51 = divf %49, %50 : f64
      %52 = mulf %51, %48 : f64
      %53 = stencil.store_result %52 : (f64) -> !stencil.result<f64>
      stencil.return %53 : !stencil.result<f64>
    }
    %28 = stencil.apply (%arg14 = %20 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -1.000000e+00 : f64
      %40 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg14 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = addf %40, %cst : f64
      %43 = subf %40, %cst : f64
      %44 = mulf %42, %41 : f64
      %45 = subf %43, %44 : f64
      %46 = addf %43, %44 : f64
      %47 = subf %45, %46 : f64
      %48 = mulf %45, %46 : f64
      %49 = mulf %47, %48 : f64
      %50 = addf %47, %48 : f64
      %51 = divf %49, %50 : f64
      %52 = stencil.store_result %51 : (f64) -> !stencil.result<f64>
      stencil.return %52 : !stencil.result<f64>
    }
    %29 = stencil.apply (%arg14 = %18 : !stencil.temp<?x?x?xf64>, %arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 1.000000e+00 : f64
      %40 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg14 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg14 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = mulf %40, %41 : f64
      %49 = mulf %42, %43 : f64
      %50 = addf %42, %43 : f64
      %51 = subf %44, %45 : f64
      %52 = divf %46, %47 : f64
      %53 = mulf %cst, %48 : f64
      %54 = divf %49, %50 : f64
      %55 = addf %52, %51 : f64
      %56 = subf %54, %55 : f64
      %57 = mulf %56, %53 : f64
      %58 = subf %56, %53 : f64
      %59 = mulf %57, %58 : f64
      %60 = stencil.store_result %59 : (f64) -> !stencil.result<f64>
      stencil.return %60 : !stencil.result<f64>
    }
    %30 = stencil.apply (%arg14 = %19 : !stencil.temp<?x?x?xf64>, %arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 2.000000e+00 : f64
      %40 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg14 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = subf %40, %42 : f64
      %47 = mulf %40, %42 : f64
      %48 = divf %46, %43 : f64
      %49 = addf %45, %48 : f64
      %50 = subf %41, %44 : f64
      %51 = addf %41, %44 : f64
      %52 = mulf %cst, %49 : f64
      %53 = subf %cst, %49 : f64
      %54 = divf %47, %50 : f64
      %55 = subf %52, %54 : f64
      %56 = addf %52, %54 : f64
      %57 = divf %53, %55 : f64
      %58 = addf %56, %57 : f64
      %59 = mulf %58, %51 : f64
      %60 = stencil.store_result %59 : (f64) -> !stencil.result<f64>
      stencil.return %60 : !stencil.result<f64>
    }
    %31 = stencil.apply (%arg14 = %25 : !stencil.temp<?x?x?xf64>, %arg15 = %26 : !stencil.temp<?x?x?xf64>, %arg16 = %24 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %40 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg14 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg14 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg15 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = mulf %40, %41 : f64
      %49 = subf %42, %43 : f64
      %50 = mulf %44, %45 : f64
      %51 = mulf %46, %47 : f64
      %52 = addf %48, %51 : f64
      %53 = mulf %50, %49 : f64
      %54 = addf %52, %53 : f64
      %55 = stencil.store_result %54 : (f64) -> !stencil.result<f64>
      stencil.return %55 : !stencil.result<f64>
    }
    %32 = stencil.apply (%arg14 = %14 : !stencil.temp<?x?x?xf64>, %arg15 = %25 : !stencil.temp<?x?x?xf64>, %arg16 = %26 : !stencil.temp<?x?x?xf64>, %arg17 = %20 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 1.000000e+00 : f64
      %40 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg14 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg15 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg15 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = subf %42, %cst : f64
      %51 = addf %47, %50 : f64
      %52 = mulf %47, %50 : f64
      %53 = mulf %46, %43 : f64
      %54 = subf %40, %41 : f64
      %55 = subf %44, %45 : f64
      %56 = subf %54, %53 : f64
      %57 = divf %56, %55 : f64
      %58 = addf %52, %51 : f64
      %59 = addf %48, %49 : f64
      %60 = mulf %57, %58 : f64
      %61 = subf %59, %60 : f64
      %62 = mulf %59, %60 : f64
      %63 = mulf %61, %62 : f64
      %64 = addf %61, %62 : f64
      %65 = addf %63, %64 : f64
      %66 = stencil.store_result %65 : (f64) -> !stencil.result<f64>
      stencil.return %66 : !stencil.result<f64>
    }
    %33 = stencil.apply (%arg14 = %32 : !stencil.temp<?x?x?xf64>, %arg15 = %21 : !stencil.temp<?x?x?xf64>, %arg16 = %27 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -1.000000e+00 : f64
      %40 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg14 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg15 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = mulf %40, %41 : f64
      %48 = addf %cst, %43 : f64
      %49 = subf %cst, %43 : f64
      %50 = subf %44, %49 : f64
      %51 = addf %42, %45 : f64
      %52 = addf %51, %46 : f64
      %53 = divf %51, %46 : f64
      %54 = mulf %47, %48 : f64
      %55 = mulf %53, %50 : f64
      %56 = mulf %55, %54 : f64
      %57 = divf %52, %56 : f64
      %58 = stencil.store_result %57 : (f64) -> !stencil.result<f64>
      stencil.return %58 : !stencil.result<f64>
    }
    %34 = stencil.apply (%arg14 = %32 : !stencil.temp<?x?x?xf64>, %arg15 = %21 : !stencil.temp<?x?x?xf64>, %arg16 = %27 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -1.000000e+00 : f64
      %40 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg14 [1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg15 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = mulf %40, %41 : f64
      %48 = subf %42, %43 : f64
      %49 = addf %42, %43 : f64
      %50 = mulf %44, %48 : f64
      %51 = divf %45, %46 : f64
      %52 = subf %45, %46 : f64
      %53 = mulf %cst, %47 : f64
      %54 = mulf %49, %50 : f64
      %55 = mulf %51, %52 : f64
      %56 = subf %53, %55 : f64
      %57 = divf %54, %56 : f64
      %58 = stencil.store_result %57 : (f64) -> !stencil.result<f64>
      stencil.return %58 : !stencil.result<f64>
    }
    %35 = stencil.apply (%arg14 = %20 : !stencil.temp<?x?x?xf64>, %arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %29 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 1.000000e+00 : f64
      %40 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg14 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg14 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = subf %46, %40 : f64
      %48 = mulf %47, %41 : f64
      %49 = divf %42, %43 : f64
      %50 = addf %44, %45 : f64
      %51 = subf %cst, %48 : f64
      %52 = addf %49, %50 : f64
      %53 = mulf %51, %52 : f64
      %54 = divf %51, %52 : f64
      %55 = subf %53, %54 : f64
      %56 = stencil.store_result %55 : (f64) -> !stencil.result<f64>
      stencil.return %56 : !stencil.result<f64>
    }
    %36 = stencil.apply (%arg14 = %20 : !stencil.temp<?x?x?xf64>, %arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %30 : !stencil.temp<?x?x?xf64>, %arg17 = %19 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -1.000000e+00 : f64
      %40 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg14 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg17 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg16 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = subf %40, %41 : f64
      %49 = mulf %42, %43 : f64
      %50 = divf %44, %45 : f64
      %51 = divf %46, %47 : f64
      %52 = mulf %46, %47 : f64
      %53 = addf %cst, %48 : f64
      %54 = divf %49, %53 : f64
      %55 = subf %51, %50 : f64
      %56 = subf %52, %54 : f64
      %57 = mulf %52, %54 : f64
      %58 = subf %55, %56 : f64
      %59 = mulf %57, %58 : f64
      %60 = stencil.store_result %59 : (f64) -> !stencil.result<f64>
      stencil.return %60 : !stencil.result<f64>
    }
    %37 = stencil.apply (%arg14 = %32 : !stencil.temp<?x?x?xf64>, %arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %33 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 2.000000e+00 : f64
      %40 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg14 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = mulf %40, %41 : f64
      %47 = mulf %42, %43 : f64
      %48 = addf %42, %43 : f64
      %49 = subf %44, %47 : f64
      %50 = addf %45, %cst : f64
      %51 = mulf %46, %49 : f64
      %52 = mulf %50, %48 : f64
      %53 = subf %52, %51 : f64
      %54 = stencil.store_result %53 : (f64) -> !stencil.result<f64>
      stencil.return %54 : !stencil.result<f64>
    }
    %38 = stencil.apply (%arg14 = %34 : !stencil.temp<?x?x?xf64>, %arg15 = %33 : !stencil.temp<?x?x?xf64>, %arg16 = %28 : !stencil.temp<?x?x?xf64>, %arg17 = %22 : !stencil.temp<?x?x?xf64>, %arg18 = %23 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %40 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg14 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg14 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg18 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg18 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = divf %40, %41 : f64
      %50 = mulf %42, %43 : f64
      %51 = divf %44, %45 : f64
      %52 = addf %46, %47 : f64
      %53 = subf %46, %47 : f64
      %54 = mulf %48, %49 : f64
      %55 = divf %50, %51 : f64
      %56 = subf %52, %53 : f64
      %57 = subf %54, %55 : f64
      %58 = mulf %56, %57 : f64
      %59 = stencil.store_result %58 : (f64) -> !stencil.result<f64>
      stencil.return %59 : !stencil.result<f64>
    }
    %39 = stencil.apply (%arg14 = %35 : !stencil.temp<?x?x?xf64>, %arg15 = %36 : !stencil.temp<?x?x?xf64>, %arg16 = %31 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -5.000000e-01 : f64
      %40 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg14 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = addf %40, %41 : f64
      %47 = divf %40, %41 : f64
      %48 = subf %44, %45 : f64
      %49 = addf %42, %43 : f64
      %50 = divf %cst, %46 : f64
      %51 = subf %cst, %46 : f64
      %52 = subf %47, %48 : f64
      %53 = divf %47, %48 : f64
      %54 = mulf %53, %49 : f64
      %55 = divf %50, %51 : f64
      %56 = addf %52, %54 : f64
      %57 = mulf %55, %56 : f64
      %58 = stencil.store_result %57 : (f64) -> !stencil.result<f64>
      stencil.return %58 : !stencil.result<f64>
    }
    stencil.store %37 to %11([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %38 to %12([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %39 to %13([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    return
  }
}

