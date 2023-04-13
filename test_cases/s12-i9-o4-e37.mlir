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
    %19 = stencil.load %6 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %20 = stencil.load %7 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %21 = stencil.load %8 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %22 = stencil.load %9 : (!stencil.field<72x72x72xf64>) -> !stencil.temp<?x?x?xf64>
    %23 = stencil.apply (%arg14 = %18 : !stencil.temp<?x?x?xf64>, %arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -0.66666669999999995 : f64
      %35 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg15 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg16 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = addf %37, %40 : f64
      %43 = mulf %37, %40 : f64
      %44 = subf %35, %36 : f64
      %45 = subf %38, %39 : f64
      %46 = divf %44, %42 : f64
      %47 = divf %41, %cst : f64
      %48 = addf %43, %47 : f64
      %49 = mulf %43, %47 : f64
      %50 = mulf %46, %48 : f64
      %51 = addf %49, %45 : f64
      %52 = subf %51, %50 : f64
      %53 = stencil.store_result %52 : (f64) -> !stencil.result<f64>
      stencil.return %53 : !stencil.result<f64>
    }
    %24 = stencil.apply (%arg14 = %14 : !stencil.temp<?x?x?xf64>, %arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %35 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg15 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg16 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = addf %35, %36 : f64
      %42 = divf %35, %36 : f64
      %43 = addf %37, %38 : f64
      %44 = addf %39, %40 : f64
      %45 = mulf %39, %40 : f64
      %46 = subf %41, %42 : f64
      %47 = divf %41, %42 : f64
      %48 = subf %45, %46 : f64
      %49 = divf %45, %46 : f64
      %50 = addf %43, %47 : f64
      %51 = divf %44, %48 : f64
      %52 = addf %49, %50 : f64
      %53 = mulf %52, %51 : f64
      %54 = addf %52, %51 : f64
      %55 = subf %53, %54 : f64
      %56 = stencil.store_result %55 : (f64) -> !stencil.result<f64>
      stencil.return %56 : !stencil.result<f64>
    }
    %25 = stencil.apply (%arg14 = %15 : !stencil.temp<?x?x?xf64>, %arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 2.000000e+00 : f64
      %35 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg15 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg15 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = addf %36, %35 : f64
      %43 = divf %36, %35 : f64
      %44 = addf %37, %38 : f64
      %45 = subf %37, %38 : f64
      %46 = divf %41, %42 : f64
      %47 = mulf %39, %40 : f64
      %48 = mulf %cst, %43 : f64
      %49 = mulf %44, %46 : f64
      %50 = subf %44, %46 : f64
      %51 = divf %45, %47 : f64
      %52 = mulf %48, %49 : f64
      %53 = divf %48, %49 : f64
      %54 = addf %51, %53 : f64
      %55 = mulf %52, %50 : f64
      %56 = divf %55, %54 : f64
      %57 = stencil.store_result %56 : (f64) -> !stencil.result<f64>
      stencil.return %57 : !stencil.result<f64>
    }
    %26 = stencil.apply (%arg14 = %25 : !stencil.temp<?x?x?xf64>, %arg15 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %35 = stencil.access %arg14 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = mulf %35, %36 : f64
      %38 = subf %35, %36 : f64
      %39 = subf %38, %37 : f64
      %40 = stencil.store_result %39 : (f64) -> !stencil.result<f64>
      stencil.return %40 : !stencil.result<f64>
    }
    %27 = stencil.apply (%arg14 = %19 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 2.000000e+00 : f64
      %35 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg14 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = addf %35, %36 : f64
      %39 = subf %35, %36 : f64
      %40 = subf %37, %39 : f64
      %41 = mulf %40, %cst : f64
      %42 = mulf %38, %41 : f64
      %43 = stencil.store_result %42 : (f64) -> !stencil.result<f64>
      stencil.return %43 : !stencil.result<f64>
    }
    %28 = stencil.apply (%arg14 = %19 : !stencil.temp<?x?x?xf64>, %arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %23 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %35 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg17 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg17 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = divf %35, %36 : f64
      %45 = mulf %35, %36 : f64
      %46 = mulf %37, %38 : f64
      %47 = addf %39, %40 : f64
      %48 = mulf %46, %44 : f64
      %49 = subf %46, %44 : f64
      %50 = subf %41, %42 : f64
      %51 = divf %50, %47 : f64
      %52 = divf %45, %48 : f64
      %53 = subf %49, %43 : f64
      %54 = subf %51, %52 : f64
      %55 = addf %53, %54 : f64
      %56 = mulf %53, %54 : f64
      %57 = addf %55, %56 : f64
      %58 = stencil.store_result %57 : (f64) -> !stencil.result<f64>
      stencil.return %58 : !stencil.result<f64>
    }
    %29 = stencil.apply (%arg14 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 2.000000e+00 : f64
      %35 = stencil.access %arg14 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = divf %35, %cst : f64
      %37 = stencil.store_result %36 : (f64) -> !stencil.result<f64>
      stencil.return %37 : !stencil.result<f64>
    }
    %30 = stencil.apply (%arg14 = %14 : !stencil.temp<?x?x?xf64>, %arg15 = %24 : !stencil.temp<?x?x?xf64>, %arg16 = %25 : !stencil.temp<?x?x?xf64>, %arg17 = %19 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %35 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg16 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = addf %35, %36 : f64
      %41 = mulf %40, %39 : f64
      %42 = subf %37, %38 : f64
      %43 = addf %41, %42 : f64
      %44 = stencil.store_result %43 : (f64) -> !stencil.result<f64>
      stencil.return %44 : !stencil.result<f64>
    }
    %31 = stencil.apply (%arg14 = %30 : !stencil.temp<?x?x?xf64>, %arg15 = %20 : !stencil.temp<?x?x?xf64>, %arg16 = %26 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -0.66666669999999995 : f64
      %35 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg16 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = addf %38, %39 : f64
      %42 = subf %37, %35 : f64
      %43 = subf %cst, %36 : f64
      %44 = addf %cst, %36 : f64
      %45 = divf %40, %41 : f64
      %46 = divf %44, %42 : f64
      %47 = subf %43, %45 : f64
      %48 = divf %43, %45 : f64
      %49 = subf %46, %47 : f64
      %50 = subf %49, %48 : f64
      %51 = stencil.store_result %50 : (f64) -> !stencil.result<f64>
      stencil.return %51 : !stencil.result<f64>
    }
    %32 = stencil.apply (%arg14 = %30 : !stencil.temp<?x?x?xf64>, %arg15 = %20 : !stencil.temp<?x?x?xf64>, %arg16 = %26 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %35 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg15 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg15 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = subf %38, %36 : f64
      %43 = addf %35, %39 : f64
      %44 = subf %41, %42 : f64
      %45 = divf %41, %42 : f64
      %46 = subf %44, %40 : f64
      %47 = mulf %44, %40 : f64
      %48 = mulf %45, %43 : f64
      %49 = addf %48, %46 : f64
      %50 = mulf %37, %49 : f64
      %51 = divf %37, %49 : f64
      %52 = subf %47, %50 : f64
      %53 = addf %51, %52 : f64
      %54 = stencil.store_result %53 : (f64) -> !stencil.result<f64>
      stencil.return %54 : !stencil.result<f64>
    }
    %33 = stencil.apply (%arg14 = %30 : !stencil.temp<?x?x?xf64>, %arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %31 : !stencil.temp<?x?x?xf64>, %arg17 = %27 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %35 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg17 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg16 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg15 [0, 1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = subf %39, %37 : f64
      %41 = subf %36, %40 : f64
      %42 = subf %35, %38 : f64
      %43 = divf %41, %42 : f64
      %44 = stencil.store_result %43 : (f64) -> !stencil.result<f64>
      stencil.return %44 : !stencil.result<f64>
    }
    %34 = stencil.apply (%arg14 = %32 : !stencil.temp<?x?x?xf64>, %arg15 = %31 : !stencil.temp<?x?x?xf64>, %arg16 = %26 : !stencil.temp<?x?x?xf64>, %arg17 = %27 : !stencil.temp<?x?x?xf64>, %arg18 = %21 : !stencil.temp<?x?x?xf64>, %arg19 = %22 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %35 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg19 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg17 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg17 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg14 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg18 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = mulf %35, %36 : f64
      %44 = divf %37, %38 : f64
      %45 = divf %39, %40 : f64
      %46 = mulf %42, %45 : f64
      %47 = addf %46, %44 : f64
      %48 = addf %41, %43 : f64
      %49 = subf %47, %48 : f64
      %50 = stencil.store_result %49 : (f64) -> !stencil.result<f64>
      stencil.return %50 : !stencil.result<f64>
    }
    stencil.store %28 to %10([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %29 to %11([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %33 to %12([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %34 to %13([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    return
  }
}

