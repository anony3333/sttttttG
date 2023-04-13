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
    %25 = stencil.load %11 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %26 = stencil.apply (%arg14 = %20 : !stencil.temp<?x?x?xf64>, %arg15 = %21 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 1.000000e+00 : f64
      %36 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg15 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = mulf %36, %37 : f64
      %43 = addf %36, %37 : f64
      %44 = divf %39, %43 : f64
      %45 = addf %39, %43 : f64
      %46 = divf %38, %40 : f64
      %47 = divf %41, %cst : f64
      %48 = mulf %42, %44 : f64
      %49 = addf %42, %44 : f64
      %50 = subf %48, %45 : f64
      %51 = mulf %48, %45 : f64
      %52 = divf %46, %47 : f64
      %53 = addf %46, %47 : f64
      %54 = subf %49, %50 : f64
      %55 = divf %51, %54 : f64
      %56 = subf %55, %53 : f64
      %57 = mulf %52, %56 : f64
      %58 = stencil.store_result %57 : (f64) -> !stencil.result<f64>
      stencil.return %58 : !stencil.result<f64>
    }
    %27 = stencil.apply (%arg14 = %21 : !stencil.temp<?x?x?xf64>, %arg15 = %26 : !stencil.temp<?x?x?xf64>, %arg16 = %22 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 5.000000e-01 : f64
      %36 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg15 [1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = addf %36, %41 : f64
      %43 = subf %36, %41 : f64
      %44 = subf %37, %38 : f64
      %45 = subf %39, %40 : f64
      %46 = mulf %cst, %42 : f64
      %47 = mulf %43, %44 : f64
      %48 = addf %45, %46 : f64
      %49 = mulf %47, %48 : f64
      %50 = stencil.store_result %49 : (f64) -> !stencil.result<f64>
      stencil.return %50 : !stencil.result<f64>
    }
    %28 = stencil.apply (%arg14 = %21 : !stencil.temp<?x?x?xf64>, %arg15 = %26 : !stencil.temp<?x?x?xf64>, %arg16 = %22 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %36 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg16 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = subf %36, %38 : f64
      %43 = divf %37, %39 : f64
      %44 = subf %37, %39 : f64
      %45 = mulf %40, %41 : f64
      %46 = mulf %42, %43 : f64
      %47 = divf %44, %45 : f64
      %48 = addf %47, %46 : f64
      %49 = stencil.store_result %48 : (f64) -> !stencil.result<f64>
      stencil.return %49 : !stencil.result<f64>
    }
    %29 = stencil.apply (%arg14 = %21 : !stencil.temp<?x?x?xf64>, %arg15 = %26 : !stencil.temp<?x?x?xf64>, %arg16 = %22 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -0.66666669999999995 : f64
      %36 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg16 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = addf %36, %37 : f64
      %44 = mulf %38, %39 : f64
      %45 = subf %40, %41 : f64
      %46 = mulf %40, %41 : f64
      %47 = subf %42, %cst : f64
      %48 = subf %43, %44 : f64
      %49 = mulf %46, %48 : f64
      %50 = subf %49, %47 : f64
      %51 = divf %45, %50 : f64
      %52 = stencil.store_result %51 : (f64) -> !stencil.result<f64>
      stencil.return %52 : !stencil.result<f64>
    }
    %30 = stencil.apply (%arg14 = %14 : !stencil.temp<?x?x?xf64>, %arg15 = %15 : !stencil.temp<?x?x?xf64>, %arg16 = %27 : !stencil.temp<?x?x?xf64>, %arg17 = %23 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 1.000000e+00 : f64
      %36 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg14 [1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg17 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = mulf %36, %37 : f64
      %47 = addf %36, %37 : f64
      %48 = addf %38, %39 : f64
      %49 = subf %40, %41 : f64
      %50 = mulf %40, %41 : f64
      %51 = mulf %49, %44 : f64
      %52 = addf %42, %47 : f64
      %53 = mulf %52, %46 : f64
      %54 = divf %52, %46 : f64
      %55 = mulf %43, %45 : f64
      %56 = mulf %50, %55 : f64
      %57 = addf %50, %55 : f64
      %58 = addf %cst, %56 : f64
      %59 = addf %51, %53 : f64
      %60 = subf %48, %54 : f64
      %61 = mulf %57, %58 : f64
      %62 = addf %59, %60 : f64
      %63 = subf %62, %61 : f64
      %64 = mulf %62, %61 : f64
      %65 = addf %63, %64 : f64
      %66 = stencil.store_result %65 : (f64) -> !stencil.result<f64>
      stencil.return %66 : !stencil.result<f64>
    }
    %31 = stencil.apply (%arg14 = %18 : !stencil.temp<?x?x?xf64>, %arg15 = %19 : !stencil.temp<?x?x?xf64>, %arg16 = %28 : !stencil.temp<?x?x?xf64>, %arg17 = %23 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %36 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg14 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg17 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = subf %36, %37 : f64
      %45 = subf %41, %40 : f64
      %46 = addf %38, %39 : f64
      %47 = mulf %38, %39 : f64
      %48 = divf %44, %42 : f64
      %49 = addf %44, %42 : f64
      %50 = addf %47, %48 : f64
      %51 = mulf %47, %48 : f64
      %52 = subf %46, %43 : f64
      %53 = addf %46, %43 : f64
      %54 = subf %52, %50 : f64
      %55 = mulf %52, %50 : f64
      %56 = subf %45, %49 : f64
      %57 = divf %45, %49 : f64
      %58 = divf %55, %53 : f64
      %59 = subf %51, %54 : f64
      %60 = subf %56, %57 : f64
      %61 = divf %56, %57 : f64
      %62 = subf %58, %59 : f64
      %63 = addf %60, %61 : f64
      %64 = addf %63, %62 : f64
      %65 = stencil.store_result %64 : (f64) -> !stencil.result<f64>
      stencil.return %65 : !stencil.result<f64>
    }
    %32 = stencil.apply (%arg14 = %16 : !stencil.temp<?x?x?xf64>, %arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %29 : !stencil.temp<?x?x?xf64>, %arg17 = %23 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %36 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg14 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg17 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = divf %37, %44 : f64
      %47 = addf %37, %44 : f64
      %48 = divf %36, %38 : f64
      %49 = mulf %40, %48 : f64
      %50 = addf %39, %41 : f64
      %51 = mulf %42, %43 : f64
      %52 = subf %45, %46 : f64
      %53 = addf %45, %46 : f64
      %54 = subf %49, %51 : f64
      %55 = mulf %53, %54 : f64
      %56 = mulf %47, %50 : f64
      %57 = addf %47, %50 : f64
      %58 = mulf %56, %52 : f64
      %59 = mulf %57, %55 : f64
      %60 = mulf %58, %59 : f64
      %61 = stencil.store_result %60 : (f64) -> !stencil.result<f64>
      stencil.return %61 : !stencil.result<f64>
    }
    %33 = stencil.apply (%arg14 = %20 : !stencil.temp<?x?x?xf64>, %arg15 = %30 : !stencil.temp<?x?x?xf64>, %arg16 = %32 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %36 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg15 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = divf %39, %42 : f64
      %45 = mulf %36, %41 : f64
      %46 = divf %43, %37 : f64
      %47 = divf %38, %40 : f64
      %48 = divf %46, %47 : f64
      %49 = divf %45, %48 : f64
      %50 = addf %44, %49 : f64
      %51 = mulf %44, %49 : f64
      %52 = addf %50, %51 : f64
      %53 = divf %50, %51 : f64
      %54 = addf %52, %53 : f64
      %55 = stencil.store_result %54 : (f64) -> !stencil.result<f64>
      stencil.return %55 : !stencil.result<f64>
    }
    %34 = stencil.apply (%arg14 = %20 : !stencil.temp<?x?x?xf64>, %arg15 = %31 : !stencil.temp<?x?x?xf64>, %arg16 = %32 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %36 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg14 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = addf %36, %37 : f64
      %44 = divf %36, %37 : f64
      %45 = addf %40, %42 : f64
      %46 = mulf %38, %39 : f64
      %47 = addf %46, %43 : f64
      %48 = addf %41, %47 : f64
      %49 = subf %41, %47 : f64
      %50 = mulf %49, %48 : f64
      %51 = addf %44, %45 : f64
      %52 = divf %50, %51 : f64
      %53 = mulf %50, %51 : f64
      %54 = mulf %52, %53 : f64
      %55 = stencil.store_result %54 : (f64) -> !stencil.result<f64>
      stencil.return %55 : !stencil.result<f64>
    }
    %35 = stencil.apply (%arg14 = %30 : !stencil.temp<?x?x?xf64>, %arg15 = %33 : !stencil.temp<?x?x?xf64>, %arg16 = %31 : !stencil.temp<?x?x?xf64>, %arg17 = %34 : !stencil.temp<?x?x?xf64>, %arg18 = %24 : !stencil.temp<?x?x?xf64>, %arg19 = %25 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 5.000000e-01 : f64
      %36 = stencil.access %arg19 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg19 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg14 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg18 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg18 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = addf %36, %37 : f64
      %51 = subf %36, %37 : f64
      %52 = subf %38, %39 : f64
      %53 = subf %40, %41 : f64
      %54 = mulf %42, %43 : f64
      %55 = subf %42, %43 : f64
      %56 = subf %51, %48 : f64
      %57 = subf %44, %45 : f64
      %58 = divf %44, %45 : f64
      %59 = subf %57, %cst : f64
      %60 = divf %57, %cst : f64
      %61 = mulf %46, %47 : f64
      %62 = divf %46, %47 : f64
      %63 = divf %50, %55 : f64
      %64 = subf %50, %55 : f64
      %65 = divf %63, %49 : f64
      %66 = mulf %63, %49 : f64
      %67 = divf %54, %66 : f64
      %68 = mulf %60, %61 : f64
      %69 = addf %52, %56 : f64
      %70 = mulf %52, %56 : f64
      %71 = subf %62, %53 : f64
      %72 = addf %58, %59 : f64
      %73 = subf %58, %59 : f64
      %74 = mulf %70, %65 : f64
      %75 = subf %70, %65 : f64
      %76 = subf %71, %72 : f64
      %77 = addf %67, %73 : f64
      %78 = subf %67, %73 : f64
      %79 = addf %76, %69 : f64
      %80 = subf %68, %64 : f64
      %81 = addf %74, %75 : f64
      %82 = mulf %74, %75 : f64
      %83 = addf %77, %78 : f64
      %84 = divf %83, %80 : f64
      %85 = divf %84, %79 : f64
      %86 = subf %81, %85 : f64
      %87 = subf %82, %86 : f64
      %88 = mulf %82, %86 : f64
      %89 = divf %88, %87 : f64
      %90 = stencil.store_result %89 : (f64) -> !stencil.result<f64>
      stencil.return %90 : !stencil.result<f64>
    }
    stencil.store %32 to %12([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %35 to %13([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    return
  }
}

