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
    %24 = stencil.apply (%arg14 = %19 : !stencil.temp<?x?x?xf64>, %arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %36 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = subf %36, %37 : f64
      %43 = divf %39, %40 : f64
      %44 = subf %39, %40 : f64
      %45 = mulf %38, %43 : f64
      %46 = divf %45, %44 : f64
      %47 = subf %41, %42 : f64
      %48 = divf %47, %46 : f64
      %49 = stencil.store_result %48 : (f64) -> !stencil.result<f64>
      stencil.return %49 : !stencil.result<f64>
    }
    %25 = stencil.apply (%arg14 = %14 : !stencil.temp<?x?x?xf64>, %arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -5.000000e-01 : f64
      %36 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg15 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [-1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = mulf %cst, %41 : f64
      %44 = subf %40, %38 : f64
      %45 = addf %36, %37 : f64
      %46 = mulf %39, %42 : f64
      %47 = divf %43, %44 : f64
      %48 = addf %45, %46 : f64
      %49 = subf %47, %48 : f64
      %50 = stencil.store_result %49 : (f64) -> !stencil.result<f64>
      stencil.return %50 : !stencil.result<f64>
    }
    %26 = stencil.apply (%arg14 = %15 : !stencil.temp<?x?x?xf64>, %arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %36 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg15 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg16 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = subf %36, %37 : f64
      %42 = divf %36, %37 : f64
      %43 = mulf %38, %39 : f64
      %44 = mulf %40, %41 : f64
      %45 = mulf %44, %43 : f64
      %46 = mulf %42, %45 : f64
      %47 = stencil.store_result %46 : (f64) -> !stencil.result<f64>
      stencil.return %47 : !stencil.result<f64>
    }
    %27 = stencil.apply (%arg14 = %26 : !stencil.temp<?x?x?xf64>, %arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %20 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %36 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = addf %36, %37 : f64
      %44 = addf %38, %39 : f64
      %45 = mulf %38, %39 : f64
      %46 = addf %40, %41 : f64
      %47 = divf %46, %43 : f64
      %48 = addf %42, %44 : f64
      %49 = divf %42, %44 : f64
      %50 = addf %49, %48 : f64
      %51 = addf %45, %47 : f64
      %52 = subf %45, %47 : f64
      %53 = subf %52, %51 : f64
      %54 = divf %50, %53 : f64
      %55 = stencil.store_result %54 : (f64) -> !stencil.result<f64>
      stencil.return %55 : !stencil.result<f64>
    }
    %28 = stencil.apply (%arg14 = %20 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 5.000000e-01 : f64
      %36 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = mulf %36, %37 : f64
      %39 = subf %cst, %38 : f64
      %40 = stencil.store_result %39 : (f64) -> !stencil.result<f64>
      stencil.return %40 : !stencil.result<f64>
    }
    %29 = stencil.apply (%arg14 = %17 : !stencil.temp<?x?x?xf64>, %arg15 = %18 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %36 = stencil.access %arg15 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg15 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = mulf %36, %37 : f64
      %41 = divf %38, %39 : f64
      %42 = divf %40, %41 : f64
      %43 = stencil.store_result %42 : (f64) -> !stencil.result<f64>
      stencil.return %43 : !stencil.result<f64>
    }
    %30 = stencil.apply (%arg14 = %20 : !stencil.temp<?x?x?xf64>, %arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %24 : !stencil.temp<?x?x?xf64>, %arg17 = %19 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %36 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [0, -1, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg14 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg16 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg16 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = mulf %36, %37 : f64
      %46 = addf %38, %39 : f64
      %47 = subf %38, %39 : f64
      %48 = mulf %43, %44 : f64
      %49 = addf %43, %44 : f64
      %50 = addf %47, %42 : f64
      %51 = subf %47, %42 : f64
      %52 = addf %40, %41 : f64
      %53 = addf %45, %46 : f64
      %54 = mulf %48, %50 : f64
      %55 = subf %49, %54 : f64
      %56 = addf %49, %54 : f64
      %57 = addf %55, %51 : f64
      %58 = divf %52, %53 : f64
      %59 = addf %56, %57 : f64
      %60 = mulf %59, %58 : f64
      %61 = stencil.store_result %60 : (f64) -> !stencil.result<f64>
      stencil.return %61 : !stencil.result<f64>
    }
    %31 = stencil.apply (%arg14 = %14 : !stencil.temp<?x?x?xf64>, %arg15 = %25 : !stencil.temp<?x?x?xf64>, %arg16 = %26 : !stencil.temp<?x?x?xf64>, %arg17 = %20 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %36 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg17 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = mulf %40, %36 : f64
      %43 = addf %37, %38 : f64
      %44 = subf %42, %41 : f64
      %45 = addf %44, %39 : f64
      %46 = divf %43, %45 : f64
      %47 = stencil.store_result %46 : (f64) -> !stencil.result<f64>
      stencil.return %47 : !stencil.result<f64>
    }
    %32 = stencil.apply (%arg14 = %31 : !stencil.temp<?x?x?xf64>, %arg15 = %21 : !stencil.temp<?x?x?xf64>, %arg16 = %27 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %36 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg16 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = subf %36, %37 : f64
      %43 = divf %39, %40 : f64
      %44 = divf %38, %41 : f64
      %45 = mulf %44, %42 : f64
      %46 = subf %43, %45 : f64
      %47 = mulf %43, %45 : f64
      %48 = addf %47, %46 : f64
      %49 = stencil.store_result %48 : (f64) -> !stencil.result<f64>
      stencil.return %49 : !stencil.result<f64>
    }
    %33 = stencil.apply (%arg14 = %31 : !stencil.temp<?x?x?xf64>, %arg15 = %21 : !stencil.temp<?x?x?xf64>, %arg16 = %27 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 5.000000e-01 : f64
      %36 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg16 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = addf %36, %37 : f64
      %44 = addf %40, %39 : f64
      %45 = divf %41, %38 : f64
      %46 = divf %42, %cst : f64
      %47 = addf %46, %44 : f64
      %48 = subf %43, %45 : f64
      %49 = addf %43, %45 : f64
      %50 = divf %48, %49 : f64
      %51 = mulf %48, %49 : f64
      %52 = addf %47, %50 : f64
      %53 = subf %52, %51 : f64
      %54 = stencil.store_result %53 : (f64) -> !stencil.result<f64>
      stencil.return %54 : !stencil.result<f64>
    }
    %34 = stencil.apply (%arg14 = %31 : !stencil.temp<?x?x?xf64>, %arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>, %arg17 = %32 : !stencil.temp<?x?x?xf64>, %arg18 = %28 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %36 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg14 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg18 [1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg17 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg17 [0, -1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = mulf %36, %37 : f64
      %47 = subf %40, %46 : f64
      %48 = addf %41, %45 : f64
      %49 = divf %38, %39 : f64
      %50 = subf %42, %48 : f64
      %51 = addf %43, %49 : f64
      %52 = mulf %44, %47 : f64
      %53 = mulf %50, %51 : f64
      %54 = addf %53, %52 : f64
      %55 = subf %53, %52 : f64
      %56 = divf %55, %54 : f64
      %57 = stencil.store_result %56 : (f64) -> !stencil.result<f64>
      stencil.return %57 : !stencil.result<f64>
    }
    %35 = stencil.apply (%arg14 = %33 : !stencil.temp<?x?x?xf64>, %arg15 = %32 : !stencil.temp<?x?x?xf64>, %arg16 = %27 : !stencil.temp<?x?x?xf64>, %arg17 = %28 : !stencil.temp<?x?x?xf64>, %arg18 = %22 : !stencil.temp<?x?x?xf64>, %arg19 = %23 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %36 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg14 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg19 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg17 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg15 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = addf %40, %42 : f64
      %44 = subf %36, %37 : f64
      %45 = mulf %36, %37 : f64
      %46 = mulf %38, %45 : f64
      %47 = subf %43, %46 : f64
      %48 = addf %47, %39 : f64
      %49 = addf %41, %44 : f64
      %50 = mulf %49, %48 : f64
      %51 = stencil.store_result %50 : (f64) -> !stencil.result<f64>
      stencil.return %51 : !stencil.result<f64>
    }
    stencil.store %29 to %10([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %30 to %11([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %34 to %12([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %35 to %13([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    return
  }
}

