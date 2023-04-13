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
      %42 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg15 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg16 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = addf %45, %42 : f64
      %50 = mulf %43, %44 : f64
      %51 = subf %43, %44 : f64
      %52 = subf %49, %51 : f64
      %53 = addf %49, %51 : f64
      %54 = mulf %46, %47 : f64
      %55 = mulf %48, %50 : f64
      %56 = divf %54, %52 : f64
      %57 = divf %53, %55 : f64
      %58 = addf %53, %55 : f64
      %59 = subf %57, %58 : f64
      %60 = mulf %57, %58 : f64
      %61 = addf %56, %59 : f64
      %62 = mulf %56, %59 : f64
      %63 = addf %61, %62 : f64
      %64 = subf %61, %62 : f64
      %65 = mulf %60, %63 : f64
      %66 = subf %65, %64 : f64
      %67 = addf %65, %64 : f64
      %68 = mulf %66, %67 : f64
      %69 = stencil.store_result %68 : (f64) -> !stencil.result<f64>
      stencil.return %69 : !stencil.result<f64>
    }
    %28 = stencil.apply (%arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg15 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = subf %42, %43 : f64
      %50 = mulf %44, %48 : f64
      %51 = divf %45, %47 : f64
      %52 = subf %46, %49 : f64
      %53 = divf %50, %51 : f64
      %54 = addf %53, %52 : f64
      %55 = mulf %53, %52 : f64
      %56 = mulf %55, %54 : f64
      %57 = stencil.store_result %56 : (f64) -> !stencil.result<f64>
      stencil.return %57 : !stencil.result<f64>
    }
    %29 = stencil.apply (%arg15 = %28 : !stencil.temp<?x?x?xf64>, %arg16 = %18 : !stencil.temp<?x?x?xf64>, %arg17 = %21 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 5.000000e-01 : f64
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg17 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = subf %42, %43 : f64
      %50 = subf %cst, %48 : f64
      %51 = subf %44, %45 : f64
      %52 = subf %46, %47 : f64
      %53 = mulf %46, %47 : f64
      %54 = mulf %49, %50 : f64
      %55 = subf %51, %52 : f64
      %56 = subf %53, %54 : f64
      %57 = subf %55, %56 : f64
      %58 = stencil.store_result %57 : (f64) -> !stencil.result<f64>
      stencil.return %58 : !stencil.result<f64>
    }
    %30 = stencil.apply (%arg15 = %21 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = divf %43, %42 : f64
      %45 = stencil.store_result %44 : (f64) -> !stencil.result<f64>
      stencil.return %45 : !stencil.result<f64>
    }
    %31 = stencil.apply (%arg15 = %19 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %42 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg16 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = mulf %42, %43 : f64
      %50 = divf %45, %49 : f64
      %51 = divf %44, %46 : f64
      %52 = subf %47, %48 : f64
      %53 = addf %50, %51 : f64
      %54 = subf %50, %51 : f64
      %55 = subf %52, %53 : f64
      %56 = addf %54, %55 : f64
      %57 = stencil.store_result %56 : (f64) -> !stencil.result<f64>
      stencil.return %57 : !stencil.result<f64>
    }
    %32 = stencil.apply (%arg15 = %20 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 2.000000e+00 : f64
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg16 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg16 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = subf %49, %47 : f64
      %51 = mulf %49, %47 : f64
      %52 = mulf %42, %43 : f64
      %53 = addf %44, %45 : f64
      %54 = mulf %44, %45 : f64
      %55 = mulf %46, %48 : f64
      %56 = divf %46, %48 : f64
      %57 = subf %cst, %50 : f64
      %58 = addf %51, %52 : f64
      %59 = subf %57, %58 : f64
      %60 = divf %57, %58 : f64
      %61 = mulf %55, %54 : f64
      %62 = mulf %59, %61 : f64
      %63 = mulf %53, %56 : f64
      %64 = subf %60, %62 : f64
      %65 = divf %63, %64 : f64
      %66 = stencil.store_result %65 : (f64) -> !stencil.result<f64>
      stencil.return %66 : !stencil.result<f64>
    }
    %33 = stencil.apply (%arg15 = %27 : !stencil.temp<?x?x?xf64>, %arg16 = %28 : !stencil.temp<?x?x?xf64>, %arg17 = %25 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 0.66666669999999995 : f64
      %42 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = divf %42, %43 : f64
      %48 = divf %44, %45 : f64
      %49 = mulf %cst, %46 : f64
      %50 = divf %cst, %46 : f64
      %51 = addf %49, %50 : f64
      %52 = mulf %47, %48 : f64
      %53 = subf %51, %52 : f64
      %54 = stencil.store_result %53 : (f64) -> !stencil.result<f64>
      stencil.return %54 : !stencil.result<f64>
    }
    %34 = stencil.apply (%arg15 = %31 : !stencil.temp<?x?x?xf64>, %arg16 = %32 : !stencil.temp<?x?x?xf64>, %arg17 = %26 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %42 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = subf %46, %44 : f64
      %49 = mulf %46, %44 : f64
      %50 = divf %47, %42 : f64
      %51 = mulf %48, %49 : f64
      %52 = subf %50, %51 : f64
      %53 = divf %43, %45 : f64
      %54 = divf %53, %52 : f64
      %55 = subf %53, %52 : f64
      %56 = mulf %54, %55 : f64
      %57 = stencil.store_result %56 : (f64) -> !stencil.result<f64>
      stencil.return %57 : !stencil.result<f64>
    }
    %35 = stencil.apply (%arg15 = %15 : !stencil.temp<?x?x?xf64>, %arg16 = %27 : !stencil.temp<?x?x?xf64>, %arg17 = %28 : !stencil.temp<?x?x?xf64>, %arg18 = %21 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg17 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg17 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg18 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = addf %42, %43 : f64
      %51 = subf %42, %43 : f64
      %52 = addf %49, %48 : f64
      %53 = addf %44, %45 : f64
      %54 = subf %51, %50 : f64
      %55 = divf %52, %54 : f64
      %56 = addf %52, %54 : f64
      %57 = divf %46, %47 : f64
      %58 = mulf %53, %55 : f64
      %59 = subf %57, %56 : f64
      %60 = divf %58, %59 : f64
      %61 = stencil.store_result %60 : (f64) -> !stencil.result<f64>
      stencil.return %61 : !stencil.result<f64>
    }
    %36 = stencil.apply (%arg15 = %35 : !stencil.temp<?x?x?xf64>, %arg16 = %22 : !stencil.temp<?x?x?xf64>, %arg17 = %29 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg17 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg16 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg16 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = divf %44, %48 : f64
      %50 = addf %42, %43 : f64
      %51 = subf %45, %46 : f64
      %52 = addf %45, %46 : f64
      %53 = addf %47, %49 : f64
      %54 = divf %50, %51 : f64
      %55 = mulf %52, %53 : f64
      %56 = divf %52, %53 : f64
      %57 = divf %54, %55 : f64
      %58 = addf %56, %57 : f64
      %59 = stencil.store_result %58 : (f64) -> !stencil.result<f64>
      stencil.return %59 : !stencil.result<f64>
    }
    %37 = stencil.apply (%arg15 = %21 : !stencil.temp<?x?x?xf64>, %arg16 = %18 : !stencil.temp<?x?x?xf64>, %arg17 = %31 : !stencil.temp<?x?x?xf64>, %arg18 = %19 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 1.000000e+00 : f64
      %42 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg17 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg18 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg18 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = divf %42, %43 : f64
      %49 = divf %47, %45 : f64
      %50 = addf %44, %46 : f64
      %51 = addf %cst, %48 : f64
      %52 = addf %49, %50 : f64
      %53 = mulf %51, %52 : f64
      %54 = stencil.store_result %53 : (f64) -> !stencil.result<f64>
      stencil.return %54 : !stencil.result<f64>
    }
    %38 = stencil.apply (%arg15 = %21 : !stencil.temp<?x?x?xf64>, %arg16 = %18 : !stencil.temp<?x?x?xf64>, %arg17 = %32 : !stencil.temp<?x?x?xf64>, %arg18 = %20 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %42 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg16 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg17 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg17 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = stencil.access %arg18 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %51 = subf %49, %47 : f64
      %52 = divf %42, %51 : f64
      %53 = mulf %43, %44 : f64
      %54 = mulf %53, %46 : f64
      %55 = addf %45, %48 : f64
      %56 = mulf %50, %52 : f64
      %57 = subf %54, %55 : f64
      %58 = divf %56, %57 : f64
      %59 = mulf %56, %57 : f64
      %60 = addf %58, %59 : f64
      %61 = stencil.store_result %60 : (f64) -> !stencil.result<f64>
      stencil.return %61 : !stencil.result<f64>
    }
    %39 = stencil.apply (%arg15 = %35 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>, %arg17 = %30 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %42 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = addf %42, %43 : f64
      %47 = mulf %44, %45 : f64
      %48 = mulf %46, %47 : f64
      %49 = stencil.store_result %48 : (f64) -> !stencil.result<f64>
      stencil.return %49 : !stencil.result<f64>
    }
    %40 = stencil.apply (%arg15 = %36 : !stencil.temp<?x?x?xf64>, %arg16 = %29 : !stencil.temp<?x?x?xf64>, %arg17 = %30 : !stencil.temp<?x?x?xf64>, %arg18 = %23 : !stencil.temp<?x?x?xf64>, %arg19 = %24 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 0.66666669999999995 : f64
      %42 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg19 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg16 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg18 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg17 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = stencil.access %arg19 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %51 = divf %42, %43 : f64
      %52 = mulf %51, %cst : f64
      %53 = subf %46, %50 : f64
      %54 = addf %52, %49 : f64
      %55 = subf %45, %48 : f64
      %56 = addf %44, %47 : f64
      %57 = subf %53, %54 : f64
      %58 = mulf %57, %55 : f64
      %59 = addf %58, %56 : f64
      %60 = stencil.store_result %59 : (f64) -> !stencil.result<f64>
      stencil.return %60 : !stencil.result<f64>
    }
    %41 = stencil.apply (%arg15 = %37 : !stencil.temp<?x?x?xf64>, %arg16 = %38 : !stencil.temp<?x?x?xf64>, %arg17 = %33 : !stencil.temp<?x?x?xf64>, %arg18 = %34 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 2.000000e+00 : f64
      %42 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = stencil.access %arg16 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %47 = stencil.access %arg18 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %48 = stencil.access %arg18 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %49 = stencil.access %arg17 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %50 = stencil.access %arg17 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %51 = mulf %42, %43 : f64
      %52 = addf %44, %45 : f64
      %53 = subf %48, %52 : f64
      %54 = divf %46, %47 : f64
      %55 = addf %46, %47 : f64
      %56 = subf %49, %50 : f64
      %57 = subf %cst, %51 : f64
      %58 = divf %cst, %51 : f64
      %59 = addf %53, %54 : f64
      %60 = subf %53, %54 : f64
      %61 = subf %55, %56 : f64
      %62 = mulf %57, %58 : f64
      %63 = addf %62, %60 : f64
      %64 = subf %62, %60 : f64
      %65 = divf %59, %61 : f64
      %66 = addf %63, %64 : f64
      %67 = subf %65, %66 : f64
      %68 = stencil.store_result %67 : (f64) -> !stencil.result<f64>
      stencil.return %68 : !stencil.result<f64>
    }
    stencil.store %39 to %12([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %40 to %13([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %41 to %14([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    return
  }
}

