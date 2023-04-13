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
    %24 = stencil.apply (%arg14 = %18 : !stencil.temp<?x?x?xf64>, %arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -2.000000e+00 : f64
      %34 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %35 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg14 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg15 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg16 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = mulf %35, %cst : f64
      %40 = addf %37, %36 : f64
      %41 = subf %37, %36 : f64
      %42 = addf %34, %38 : f64
      %43 = addf %39, %40 : f64
      %44 = mulf %43, %41 : f64
      %45 = divf %42, %44 : f64
      %46 = addf %42, %44 : f64
      %47 = mulf %45, %46 : f64
      %48 = stencil.store_result %47 : (f64) -> !stencil.result<f64>
      stencil.return %48 : !stencil.result<f64>
    }
    %25 = stencil.apply (%arg14 = %15 : !stencil.temp<?x?x?xf64>, %arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant -1.000000e+00 : f64
      %34 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %35 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg14 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg15 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg16 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg16 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = addf %34, %35 : f64
      %41 = subf %39, %36 : f64
      %42 = mulf %37, %38 : f64
      %43 = divf %37, %38 : f64
      %44 = divf %41, %cst : f64
      %45 = mulf %41, %cst : f64
      %46 = divf %40, %43 : f64
      %47 = mulf %40, %43 : f64
      %48 = addf %47, %44 : f64
      %49 = subf %45, %48 : f64
      %50 = mulf %42, %46 : f64
      %51 = subf %49, %50 : f64
      %52 = stencil.store_result %51 : (f64) -> !stencil.result<f64>
      stencil.return %52 : !stencil.result<f64>
    }
    %26 = stencil.apply (%arg14 = %25 : !stencil.temp<?x?x?xf64>, %arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %20 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 2.000000e+00 : f64
      %34 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %35 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg14 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg16 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg15 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = subf %34, %35 : f64
      %40 = mulf %37, %36 : f64
      %41 = mulf %40, %38 : f64
      %42 = subf %cst, %39 : f64
      %43 = subf %41, %42 : f64
      %44 = divf %41, %42 : f64
      %45 = mulf %43, %44 : f64
      %46 = stencil.store_result %45 : (f64) -> !stencil.result<f64>
      stencil.return %46 : !stencil.result<f64>
    }
    %27 = stencil.apply (%arg14 = %20 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %cst = constant 5.000000e-01 : f64
      %34 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %35 = stencil.access %arg14 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = subf %cst, %35 : f64
      %37 = addf %34, %36 : f64
      %38 = stencil.store_result %37 : (f64) -> !stencil.result<f64>
      stencil.return %38 : !stencil.result<f64>
    }
    %28 = stencil.apply (%arg14 = %20 : !stencil.temp<?x?x?xf64>, %arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %24 : !stencil.temp<?x?x?xf64>, %arg17 = %18 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %34 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %35 = stencil.access %arg15 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg17 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg14 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg14 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg17 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg16 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = subf %35, %40 : f64
      %42 = subf %34, %36 : f64
      %43 = subf %37, %38 : f64
      %44 = divf %39, %41 : f64
      %45 = mulf %43, %42 : f64
      %46 = mulf %44, %45 : f64
      %47 = stencil.store_result %46 : (f64) -> !stencil.result<f64>
      stencil.return %47 : !stencil.result<f64>
    }
    %29 = stencil.apply (%arg14 = %20 : !stencil.temp<?x?x?xf64>, %arg15 = %17 : !stencil.temp<?x?x?xf64>, %arg16 = %19 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %34 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %35 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg14 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = subf %34, %35 : f64
      %40 = divf %39, %38 : f64
      %41 = divf %36, %37 : f64
      %42 = subf %40, %41 : f64
      %43 = stencil.store_result %42 : (f64) -> !stencil.result<f64>
      stencil.return %43 : !stencil.result<f64>
    }
    %30 = stencil.apply (%arg14 = %14 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %34 = stencil.access %arg14 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %35 = stencil.access %arg14 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = subf %34, %35 : f64
      %37 = stencil.store_result %36 : (f64) -> !stencil.result<f64>
      stencil.return %37 : !stencil.result<f64>
    }
    %31 = stencil.apply (%arg14 = %30 : !stencil.temp<?x?x?xf64>, %arg15 = %21 : !stencil.temp<?x?x?xf64>, %arg16 = %26 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %34 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %35 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg14 [1, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg15 [1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg16 [0, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg16 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = mulf %34, %35 : f64
      %41 = addf %36, %37 : f64
      %42 = addf %39, %41 : f64
      %43 = mulf %42, %40 : f64
      %44 = subf %42, %40 : f64
      %45 = subf %38, %43 : f64
      %46 = addf %44, %45 : f64
      %47 = stencil.store_result %46 : (f64) -> !stencil.result<f64>
      stencil.return %47 : !stencil.result<f64>
    }
    %32 = stencil.apply (%arg14 = %30 : !stencil.temp<?x?x?xf64>, %arg15 = %16 : !stencil.temp<?x?x?xf64>, %arg16 = %17 : !stencil.temp<?x?x?xf64>, %arg17 = %31 : !stencil.temp<?x?x?xf64>, %arg18 = %27 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %34 = stencil.access %arg14 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %35 = stencil.access %arg16 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg18 [0, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg15 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = stencil.access %arg15 [0, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %39 = stencil.access %arg18 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %40 = stencil.access %arg18 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %41 = stencil.access %arg14 [0, 1, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %42 = stencil.access %arg17 [1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %43 = stencil.access %arg17 [0, 0, -1] : (!stencil.temp<?x?x?xf64>) -> f64
      %44 = stencil.access %arg16 [1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %45 = stencil.access %arg16 [-1, 1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %46 = mulf %34, %35 : f64
      %47 = addf %36, %37 : f64
      %48 = mulf %36, %37 : f64
      %49 = addf %38, %39 : f64
      %50 = addf %41, %43 : f64
      %51 = addf %49, %42 : f64
      %52 = addf %48, %47 : f64
      %53 = mulf %40, %44 : f64
      %54 = mulf %50, %52 : f64
      %55 = addf %50, %52 : f64
      %56 = addf %55, %51 : f64
      %57 = mulf %45, %46 : f64
      %58 = subf %54, %57 : f64
      %59 = divf %56, %53 : f64
      %60 = mulf %59, %58 : f64
      %61 = stencil.store_result %60 : (f64) -> !stencil.result<f64>
      stencil.return %61 : !stencil.result<f64>
    }
    %33 = stencil.apply (%arg14 = %22 : !stencil.temp<?x?x?xf64>, %arg15 = %23 : !stencil.temp<?x?x?xf64>) -> !stencil.temp<?x?x?xf64> {
      %34 = stencil.access %arg14 [-1, 0, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %35 = stencil.access %arg14 [0, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %36 = stencil.access %arg15 [-1, 0, 1] : (!stencil.temp<?x?x?xf64>) -> f64
      %37 = stencil.access %arg15 [-1, -1, 0] : (!stencil.temp<?x?x?xf64>) -> f64
      %38 = addf %34, %35 : f64
      %39 = divf %36, %37 : f64
      %40 = mulf %38, %39 : f64
      %41 = stencil.store_result %40 : (f64) -> !stencil.result<f64>
      stencil.return %41 : !stencil.result<f64>
    }
    stencil.store %28 to %10([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %29 to %11([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %32 to %12([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    stencil.store %33 to %13([0, 0, 0] : [64, 64, 64]) : !stencil.temp<?x?x?xf64> to !stencil.field<72x72x72xf64>
    return
  }
}

