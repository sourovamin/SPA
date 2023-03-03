; ModuleID = 'File_Jacobi/jacobi.c'
source_filename = "File_Jacobi/jacobi.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

%struct.ompi_predefined_datatype_t = type opaque
%struct.ompi_predefined_op_t = type opaque
%struct.ompi_predefined_communicator_t = type opaque
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct.JacobiData = type { i32, i32, i32, i32, i32, double, double, double, double, double, double*, double*, double, double, double, i32, double, i32, i32 }
%struct.ompi_datatype_t = type opaque
%struct.ompi_op_t = type opaque
%struct.ompi_communicator_t = type opaque
%struct.ompi_request_t = type opaque
%struct.ompi_status_public_t = type { i32, i32, i32, i32, i64 }

@ompi_mpi_double = external global %struct.ompi_predefined_datatype_t, align 1
@ompi_mpi_op_sum = external global %struct.ompi_predefined_op_t, align 1
@ompi_mpi_comm_world = external global %struct.ompi_predefined_communicator_t, align 1
@__stderrp = external global %struct.__sFILE*, align 8
@.str = private unnamed_addr constant [29 x i8] c"Error: cant allocate memory\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @Jacobi(%struct.JacobiData* %data) #0 {
entry:
  %data.addr = alloca %struct.JacobiData*, align 8
  %afU = alloca double*, align 8
  %afF = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %fLRes = alloca double, align 8
  %ax = alloca double, align 8
  %ay = alloca double, align 8
  %b = alloca double, align 8
  %residual = alloca double, align 8
  %tmpResd = alloca double, align 8
  %uold = alloca double*, align 8
  store %struct.JacobiData* %data, %struct.JacobiData** %data.addr, align 8
  %0 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %0, i32 0, i32 1
  %1 = load i32, i32* %iCols, align 4
  %2 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowLast = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %2, i32 0, i32 3
  %3 = load i32, i32* %iRowLast, align 4
  %4 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %4, i32 0, i32 2
  %5 = load i32, i32* %iRowFirst, align 8
  %sub = sub nsw i32 %3, %5
  %add = add nsw i32 %sub, 1
  %mul = mul nsw i32 %1, %add
  %conv = sext i32 %mul to i64
  %mul1 = mul i64 %conv, 8
  %call = call i8* @malloc(i64 %mul1) #5
  %6 = bitcast i8* %call to double*
  store double* %6, double** %uold, align 8
  %7 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %afU2 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %7, i32 0, i32 10
  %8 = load double*, double** %afU2, align 8
  store double* %8, double** %afU, align 8
  %9 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %afF3 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %9, i32 0, i32 11
  %10 = load double*, double** %afF3, align 8
  store double* %10, double** %afF, align 8
  %11 = load double*, double** %uold, align 8
  %tobool = icmp ne double* %11, null
  br i1 %tobool, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %12 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fDx = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %12, i32 0, i32 8
  %13 = load double, double* %fDx, align 8
  %14 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fDx4 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %14, i32 0, i32 8
  %15 = load double, double* %fDx4, align 8
  %mul5 = fmul double %13, %15
  %div = fdiv double 1.000000e+00, %mul5
  store double %div, double* %ax, align 8
  %16 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fDy = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %16, i32 0, i32 9
  %17 = load double, double* %fDy, align 8
  %18 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fDy6 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %18, i32 0, i32 9
  %19 = load double, double* %fDy6, align 8
  %mul7 = fmul double %17, %19
  %div8 = fdiv double 1.000000e+00, %mul7
  store double %div8, double* %ay, align 8
  %20 = load double, double* %ax, align 8
  %21 = load double, double* %ay, align 8
  %add9 = fadd double %20, %21
  %mul10 = fmul double -2.000000e+00, %add9
  %22 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fAlpha = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %22, i32 0, i32 5
  %23 = load double, double* %fAlpha, align 8
  %sub11 = fsub double %mul10, %23
  store double %sub11, double* %b, align 8
  %24 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fTolerance = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %24, i32 0, i32 7
  %25 = load double, double* %fTolerance, align 8
  %mul12 = fmul double 1.000000e+01, %25
  store double %mul12, double* %residual, align 8
  br label %while.cond

while.cond:                                       ; preds = %for.end102, %if.then
  %26 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iIterCount = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %26, i32 0, i32 15
  %27 = load i32, i32* %iIterCount, align 8
  %28 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iIterMax = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %28, i32 0, i32 4
  %29 = load i32, i32* %iIterMax, align 8
  %cmp = icmp slt i32 %27, %29
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %while.cond
  %30 = load double, double* %residual, align 8
  %31 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fTolerance14 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %31, i32 0, i32 7
  %32 = load double, double* %fTolerance14, align 8
  %cmp15 = fcmp ogt double %30, %32
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %33 = phi i1 [ false, %while.cond ], [ %cmp15, %land.rhs ]
  br i1 %33, label %while.body, label %while.end

while.body:                                       ; preds = %land.end
  store double 0.000000e+00, double* %residual, align 8
  %34 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %35 = load double*, double** %uold, align 8
  call void @ExchangeJacobiMpiData(%struct.JacobiData* %34, double* %35)
  %36 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst17 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %36, i32 0, i32 2
  %37 = load i32, i32* %iRowFirst17, align 8
  %add18 = add nsw i32 %37, 1
  store i32 %add18, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc100, %while.body
  %38 = load i32, i32* %j, align 4
  %39 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowLast19 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %39, i32 0, i32 3
  %40 = load i32, i32* %iRowLast19, align 4
  %sub20 = sub nsw i32 %40, 1
  %cmp21 = icmp sle i32 %38, %sub20
  br i1 %cmp21, label %for.body, label %for.end102

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %i, align 4
  br label %for.cond23

for.cond23:                                       ; preds = %for.inc, %for.body
  %41 = load i32, i32* %i, align 4
  %42 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols24 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %42, i32 0, i32 1
  %43 = load i32, i32* %iCols24, align 4
  %sub25 = sub nsw i32 %43, 2
  %cmp26 = icmp sle i32 %41, %sub25
  br i1 %cmp26, label %for.body28, label %for.end

for.body28:                                       ; preds = %for.cond23
  %44 = load double, double* %ax, align 8
  %45 = load double*, double** %uold, align 8
  %46 = load i32, i32* %j, align 4
  %47 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst29 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %47, i32 0, i32 2
  %48 = load i32, i32* %iRowFirst29, align 8
  %sub30 = sub nsw i32 %46, %48
  %49 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols31 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %49, i32 0, i32 1
  %50 = load i32, i32* %iCols31, align 4
  %mul32 = mul nsw i32 %sub30, %50
  %51 = load i32, i32* %i, align 4
  %sub33 = sub nsw i32 %51, 1
  %add34 = add nsw i32 %mul32, %sub33
  %idxprom = sext i32 %add34 to i64
  %arrayidx = getelementptr inbounds double, double* %45, i64 %idxprom
  %52 = load double, double* %arrayidx, align 8
  %53 = load double*, double** %uold, align 8
  %54 = load i32, i32* %j, align 4
  %55 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst35 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %55, i32 0, i32 2
  %56 = load i32, i32* %iRowFirst35, align 8
  %sub36 = sub nsw i32 %54, %56
  %57 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols37 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %57, i32 0, i32 1
  %58 = load i32, i32* %iCols37, align 4
  %mul38 = mul nsw i32 %sub36, %58
  %59 = load i32, i32* %i, align 4
  %add39 = add nsw i32 %59, 1
  %add40 = add nsw i32 %mul38, %add39
  %idxprom41 = sext i32 %add40 to i64
  %arrayidx42 = getelementptr inbounds double, double* %53, i64 %idxprom41
  %60 = load double, double* %arrayidx42, align 8
  %add43 = fadd double %52, %60
  %mul44 = fmul double %44, %add43
  %61 = load double, double* %ay, align 8
  %62 = load double*, double** %uold, align 8
  %63 = load i32, i32* %j, align 4
  %sub45 = sub nsw i32 %63, 1
  %64 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst46 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %64, i32 0, i32 2
  %65 = load i32, i32* %iRowFirst46, align 8
  %sub47 = sub nsw i32 %sub45, %65
  %66 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols48 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %66, i32 0, i32 1
  %67 = load i32, i32* %iCols48, align 4
  %mul49 = mul nsw i32 %sub47, %67
  %68 = load i32, i32* %i, align 4
  %add50 = add nsw i32 %mul49, %68
  %idxprom51 = sext i32 %add50 to i64
  %arrayidx52 = getelementptr inbounds double, double* %62, i64 %idxprom51
  %69 = load double, double* %arrayidx52, align 8
  %70 = load double*, double** %uold, align 8
  %71 = load i32, i32* %j, align 4
  %add53 = add nsw i32 %71, 1
  %72 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst54 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %72, i32 0, i32 2
  %73 = load i32, i32* %iRowFirst54, align 8
  %sub55 = sub nsw i32 %add53, %73
  %74 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols56 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %74, i32 0, i32 1
  %75 = load i32, i32* %iCols56, align 4
  %mul57 = mul nsw i32 %sub55, %75
  %76 = load i32, i32* %i, align 4
  %add58 = add nsw i32 %mul57, %76
  %idxprom59 = sext i32 %add58 to i64
  %arrayidx60 = getelementptr inbounds double, double* %70, i64 %idxprom59
  %77 = load double, double* %arrayidx60, align 8
  %add61 = fadd double %69, %77
  %mul62 = fmul double %61, %add61
  %add63 = fadd double %mul44, %mul62
  %78 = load double, double* %b, align 8
  %79 = load double*, double** %uold, align 8
  %80 = load i32, i32* %j, align 4
  %81 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst64 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %81, i32 0, i32 2
  %82 = load i32, i32* %iRowFirst64, align 8
  %sub65 = sub nsw i32 %80, %82
  %83 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols66 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %83, i32 0, i32 1
  %84 = load i32, i32* %iCols66, align 4
  %mul67 = mul nsw i32 %sub65, %84
  %85 = load i32, i32* %i, align 4
  %add68 = add nsw i32 %mul67, %85
  %idxprom69 = sext i32 %add68 to i64
  %arrayidx70 = getelementptr inbounds double, double* %79, i64 %idxprom69
  %86 = load double, double* %arrayidx70, align 8
  %mul71 = fmul double %78, %86
  %add72 = fadd double %add63, %mul71
  %87 = load double*, double** %afF, align 8
  %88 = load i32, i32* %j, align 4
  %89 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst73 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %89, i32 0, i32 2
  %90 = load i32, i32* %iRowFirst73, align 8
  %sub74 = sub nsw i32 %88, %90
  %91 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols75 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %91, i32 0, i32 1
  %92 = load i32, i32* %iCols75, align 4
  %mul76 = mul nsw i32 %sub74, %92
  %93 = load i32, i32* %i, align 4
  %add77 = add nsw i32 %mul76, %93
  %idxprom78 = sext i32 %add77 to i64
  %arrayidx79 = getelementptr inbounds double, double* %87, i64 %idxprom78
  %94 = load double, double* %arrayidx79, align 8
  %sub80 = fsub double %add72, %94
  %95 = load double, double* %b, align 8
  %div81 = fdiv double %sub80, %95
  store double %div81, double* %fLRes, align 8
  %96 = load double*, double** %uold, align 8
  %97 = load i32, i32* %j, align 4
  %98 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst82 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %98, i32 0, i32 2
  %99 = load i32, i32* %iRowFirst82, align 8
  %sub83 = sub nsw i32 %97, %99
  %100 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols84 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %100, i32 0, i32 1
  %101 = load i32, i32* %iCols84, align 4
  %mul85 = mul nsw i32 %sub83, %101
  %102 = load i32, i32* %i, align 4
  %add86 = add nsw i32 %mul85, %102
  %idxprom87 = sext i32 %add86 to i64
  %arrayidx88 = getelementptr inbounds double, double* %96, i64 %idxprom87
  %103 = load double, double* %arrayidx88, align 8
  %104 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fRelax = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %104, i32 0, i32 6
  %105 = load double, double* %fRelax, align 8
  %106 = load double, double* %fLRes, align 8
  %mul89 = fmul double %105, %106
  %sub90 = fsub double %103, %mul89
  %107 = load double*, double** %afU, align 8
  %108 = load i32, i32* %j, align 4
  %109 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst91 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %109, i32 0, i32 2
  %110 = load i32, i32* %iRowFirst91, align 8
  %sub92 = sub nsw i32 %108, %110
  %111 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols93 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %111, i32 0, i32 1
  %112 = load i32, i32* %iCols93, align 4
  %mul94 = mul nsw i32 %sub92, %112
  %113 = load i32, i32* %i, align 4
  %add95 = add nsw i32 %mul94, %113
  %idxprom96 = sext i32 %add95 to i64
  %arrayidx97 = getelementptr inbounds double, double* %107, i64 %idxprom96
  store double %sub90, double* %arrayidx97, align 8
  %114 = load double, double* %fLRes, align 8
  %115 = load double, double* %fLRes, align 8
  %mul98 = fmul double %114, %115
  %116 = load double, double* %residual, align 8
  %add99 = fadd double %116, %mul98
  store double %add99, double* %residual, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body28
  %117 = load i32, i32* %i, align 4
  %inc = add nsw i32 %117, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond23

for.end:                                          ; preds = %for.cond23
  br label %for.inc100

for.inc100:                                       ; preds = %for.end
  %118 = load i32, i32* %j, align 4
  %inc101 = add nsw i32 %118, 1
  store i32 %inc101, i32* %j, align 4
  br label %for.cond

for.end102:                                       ; preds = %for.cond
  %119 = load double, double* %residual, align 8
  store double %119, double* %tmpResd, align 8
  %120 = bitcast double* %tmpResd to i8*
  %121 = bitcast double* %residual to i8*
  %call103 = call i32 @MPI_Allreduce(i8* %120, i8* %121, i32 1, %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_double to %struct.ompi_datatype_t*), %struct.ompi_op_t* bitcast (%struct.ompi_predefined_op_t* @ompi_mpi_op_sum to %struct.ompi_op_t*), %struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*))
  %122 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iIterCount104 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %122, i32 0, i32 15
  %123 = load i32, i32* %iIterCount104, align 8
  %inc105 = add nsw i32 %123, 1
  store i32 %inc105, i32* %iIterCount104, align 8
  %124 = load double, double* %residual, align 8
  %125 = call double @llvm.sqrt.f64(double %124)
  %126 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols106 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %126, i32 0, i32 1
  %127 = load i32, i32* %iCols106, align 4
  %128 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRows = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %128, i32 0, i32 0
  %129 = load i32, i32* %iRows, align 8
  %mul107 = mul nsw i32 %127, %129
  %conv108 = sitofp i32 %mul107 to double
  %div109 = fdiv double %125, %conv108
  store double %div109, double* %residual, align 8
  br label %while.cond

while.end:                                        ; preds = %land.end
  %130 = load double, double* %residual, align 8
  %131 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fResidual = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %131, i32 0, i32 14
  store double %130, double* %fResidual, align 8
  %132 = load double*, double** %uold, align 8
  %133 = bitcast double* %132 to i8*
  call void @free(i8* %133)
  br label %if.end

if.else:                                          ; preds = %entry
  %134 = load %struct.__sFILE*, %struct.__sFILE** @__stderrp, align 8
  %call110 = call i32 (%struct.__sFILE*, i8*, ...) @fprintf(%struct.__sFILE* %134, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str, i64 0, i64 0))
  %135 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  call void @Finish(%struct.JacobiData* %135)
  call void @exit(i32 1) #6
  unreachable

if.end:                                           ; preds = %while.end
  ret void
}

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @ExchangeJacobiMpiData(%struct.JacobiData* %data, double* %uold) #0 {
entry:
  %data.addr = alloca %struct.JacobiData*, align 8
  %uold.addr = alloca double*, align 8
  %request = alloca [4 x %struct.ompi_request_t*], align 16
  %status = alloca [4 x %struct.ompi_status_public_t], align 16
  %afU = alloca double*, align 8
  %afF = alloca double*, align 8
  %iReqCnt = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %iTagMoveLeft = alloca i32, align 4
  %iTagMoveRight = alloca i32, align 4
  store %struct.JacobiData* %data, %struct.JacobiData** %data.addr, align 8
  store double* %uold, double** %uold.addr, align 8
  store i32 0, i32* %iReqCnt, align 4
  store i32 10, i32* %iTagMoveLeft, align 4
  store i32 11, i32* %iTagMoveRight, align 4
  %0 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %afU1 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %0, i32 0, i32 10
  %1 = load double*, double** %afU1, align 8
  store double* %1, double** %afU, align 8
  %2 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %afF2 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %2, i32 0, i32 11
  %3 = load double*, double** %afF2, align 8
  store double* %3, double** %afF, align 8
  %4 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %4, i32 0, i32 17
  %5 = load i32, i32* %iMyRank, align 8
  %cmp = icmp ne i32 %5, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %6 = load double*, double** %uold.addr, align 8
  %7 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %7, i32 0, i32 2
  %8 = load i32, i32* %iRowFirst, align 8
  %9 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst3 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %9, i32 0, i32 2
  %10 = load i32, i32* %iRowFirst3, align 8
  %sub = sub nsw i32 %8, %10
  %11 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %11, i32 0, i32 1
  %12 = load i32, i32* %iCols, align 4
  %mul = mul nsw i32 %sub, %12
  %add = add nsw i32 %mul, 0
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds double, double* %6, i64 %idxprom
  %13 = bitcast double* %arrayidx to i8*
  %14 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols4 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %14, i32 0, i32 1
  %15 = load i32, i32* %iCols4, align 4
  %16 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank5 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %16, i32 0, i32 17
  %17 = load i32, i32* %iMyRank5, align 8
  %sub6 = sub nsw i32 %17, 1
  %18 = load i32, i32* %iReqCnt, align 4
  %idxprom7 = sext i32 %18 to i64
  %arrayidx8 = getelementptr inbounds [4 x %struct.ompi_request_t*], [4 x %struct.ompi_request_t*]* %request, i64 0, i64 %idxprom7
  %call = call i32 @MPI_Irecv(i8* %13, i32 %15, %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_double to %struct.ompi_datatype_t*), i32 %sub6, i32 11, %struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*), %struct.ompi_request_t** %arrayidx8)
  %19 = load i32, i32* %iReqCnt, align 4
  %inc = add nsw i32 %19, 1
  store i32 %inc, i32* %iReqCnt, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %20 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank9 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %20, i32 0, i32 17
  %21 = load i32, i32* %iMyRank9, align 8
  %22 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iNumProcs = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %22, i32 0, i32 18
  %23 = load i32, i32* %iNumProcs, align 4
  %sub10 = sub nsw i32 %23, 1
  %cmp11 = icmp ne i32 %21, %sub10
  br i1 %cmp11, label %if.then12, label %if.end27

if.then12:                                        ; preds = %if.end
  %24 = load double*, double** %uold.addr, align 8
  %25 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowLast = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %25, i32 0, i32 3
  %26 = load i32, i32* %iRowLast, align 4
  %27 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst13 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %27, i32 0, i32 2
  %28 = load i32, i32* %iRowFirst13, align 8
  %sub14 = sub nsw i32 %26, %28
  %29 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols15 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %29, i32 0, i32 1
  %30 = load i32, i32* %iCols15, align 4
  %mul16 = mul nsw i32 %sub14, %30
  %add17 = add nsw i32 %mul16, 0
  %idxprom18 = sext i32 %add17 to i64
  %arrayidx19 = getelementptr inbounds double, double* %24, i64 %idxprom18
  %31 = bitcast double* %arrayidx19 to i8*
  %32 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols20 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %32, i32 0, i32 1
  %33 = load i32, i32* %iCols20, align 4
  %34 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank21 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %34, i32 0, i32 17
  %35 = load i32, i32* %iMyRank21, align 8
  %add22 = add nsw i32 %35, 1
  %36 = load i32, i32* %iReqCnt, align 4
  %idxprom23 = sext i32 %36 to i64
  %arrayidx24 = getelementptr inbounds [4 x %struct.ompi_request_t*], [4 x %struct.ompi_request_t*]* %request, i64 0, i64 %idxprom23
  %call25 = call i32 @MPI_Irecv(i8* %31, i32 %33, %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_double to %struct.ompi_datatype_t*), i32 %add22, i32 10, %struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*), %struct.ompi_request_t** %arrayidx24)
  %37 = load i32, i32* %iReqCnt, align 4
  %inc26 = add nsw i32 %37, 1
  store i32 %inc26, i32* %iReqCnt, align 4
  br label %if.end27

if.end27:                                         ; preds = %if.then12, %if.end
  %38 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank28 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %38, i32 0, i32 17
  %39 = load i32, i32* %iMyRank28, align 8
  %40 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iNumProcs29 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %40, i32 0, i32 18
  %41 = load i32, i32* %iNumProcs29, align 4
  %sub30 = sub nsw i32 %41, 1
  %cmp31 = icmp ne i32 %39, %sub30
  br i1 %cmp31, label %if.then32, label %if.end49

if.then32:                                        ; preds = %if.end27
  %42 = load double*, double** %afU, align 8
  %43 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowLast33 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %43, i32 0, i32 3
  %44 = load i32, i32* %iRowLast33, align 4
  %sub34 = sub nsw i32 %44, 1
  %45 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst35 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %45, i32 0, i32 2
  %46 = load i32, i32* %iRowFirst35, align 8
  %sub36 = sub nsw i32 %sub34, %46
  %47 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols37 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %47, i32 0, i32 1
  %48 = load i32, i32* %iCols37, align 4
  %mul38 = mul nsw i32 %sub36, %48
  %add39 = add nsw i32 %mul38, 0
  %idxprom40 = sext i32 %add39 to i64
  %arrayidx41 = getelementptr inbounds double, double* %42, i64 %idxprom40
  %49 = bitcast double* %arrayidx41 to i8*
  %50 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols42 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %50, i32 0, i32 1
  %51 = load i32, i32* %iCols42, align 4
  %52 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank43 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %52, i32 0, i32 17
  %53 = load i32, i32* %iMyRank43, align 8
  %add44 = add nsw i32 %53, 1
  %54 = load i32, i32* %iReqCnt, align 4
  %idxprom45 = sext i32 %54 to i64
  %arrayidx46 = getelementptr inbounds [4 x %struct.ompi_request_t*], [4 x %struct.ompi_request_t*]* %request, i64 0, i64 %idxprom45
  %call47 = call i32 @MPI_Isend(i8* %49, i32 %51, %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_double to %struct.ompi_datatype_t*), i32 %add44, i32 11, %struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*), %struct.ompi_request_t** %arrayidx46)
  %55 = load i32, i32* %iReqCnt, align 4
  %inc48 = add nsw i32 %55, 1
  store i32 %inc48, i32* %iReqCnt, align 4
  br label %if.end49

if.end49:                                         ; preds = %if.then32, %if.end27
  %56 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank50 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %56, i32 0, i32 17
  %57 = load i32, i32* %iMyRank50, align 8
  %cmp51 = icmp ne i32 %57, 0
  br i1 %cmp51, label %if.then52, label %if.end69

if.then52:                                        ; preds = %if.end49
  %58 = load double*, double** %afU, align 8
  %59 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst53 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %59, i32 0, i32 2
  %60 = load i32, i32* %iRowFirst53, align 8
  %add54 = add nsw i32 %60, 1
  %61 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst55 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %61, i32 0, i32 2
  %62 = load i32, i32* %iRowFirst55, align 8
  %sub56 = sub nsw i32 %add54, %62
  %63 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols57 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %63, i32 0, i32 1
  %64 = load i32, i32* %iCols57, align 4
  %mul58 = mul nsw i32 %sub56, %64
  %add59 = add nsw i32 %mul58, 0
  %idxprom60 = sext i32 %add59 to i64
  %arrayidx61 = getelementptr inbounds double, double* %58, i64 %idxprom60
  %65 = bitcast double* %arrayidx61 to i8*
  %66 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols62 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %66, i32 0, i32 1
  %67 = load i32, i32* %iCols62, align 4
  %68 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank63 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %68, i32 0, i32 17
  %69 = load i32, i32* %iMyRank63, align 8
  %sub64 = sub nsw i32 %69, 1
  %70 = load i32, i32* %iReqCnt, align 4
  %idxprom65 = sext i32 %70 to i64
  %arrayidx66 = getelementptr inbounds [4 x %struct.ompi_request_t*], [4 x %struct.ompi_request_t*]* %request, i64 0, i64 %idxprom65
  %call67 = call i32 @MPI_Isend(i8* %65, i32 %67, %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_double to %struct.ompi_datatype_t*), i32 %sub64, i32 10, %struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*), %struct.ompi_request_t** %arrayidx66)
  %71 = load i32, i32* %iReqCnt, align 4
  %inc68 = add nsw i32 %71, 1
  store i32 %inc68, i32* %iReqCnt, align 4
  br label %if.end69

if.end69:                                         ; preds = %if.then52, %if.end49
  %72 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst70 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %72, i32 0, i32 2
  %73 = load i32, i32* %iRowFirst70, align 8
  %add71 = add nsw i32 %73, 1
  store i32 %add71, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc94, %if.end69
  %74 = load i32, i32* %j, align 4
  %75 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowLast72 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %75, i32 0, i32 3
  %76 = load i32, i32* %iRowLast72, align 4
  %sub73 = sub nsw i32 %76, 1
  %cmp74 = icmp sle i32 %74, %sub73
  br i1 %cmp74, label %for.body, label %for.end96

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond75

for.cond75:                                       ; preds = %for.inc, %for.body
  %77 = load i32, i32* %i, align 4
  %78 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols76 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %78, i32 0, i32 1
  %79 = load i32, i32* %iCols76, align 4
  %cmp77 = icmp slt i32 %77, %79
  br i1 %cmp77, label %for.body78, label %for.end

for.body78:                                       ; preds = %for.cond75
  %80 = load double*, double** %afU, align 8
  %81 = load i32, i32* %j, align 4
  %82 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst79 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %82, i32 0, i32 2
  %83 = load i32, i32* %iRowFirst79, align 8
  %sub80 = sub nsw i32 %81, %83
  %84 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols81 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %84, i32 0, i32 1
  %85 = load i32, i32* %iCols81, align 4
  %mul82 = mul nsw i32 %sub80, %85
  %86 = load i32, i32* %i, align 4
  %add83 = add nsw i32 %mul82, %86
  %idxprom84 = sext i32 %add83 to i64
  %arrayidx85 = getelementptr inbounds double, double* %80, i64 %idxprom84
  %87 = load double, double* %arrayidx85, align 8
  %88 = load double*, double** %uold.addr, align 8
  %89 = load i32, i32* %j, align 4
  %90 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst86 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %90, i32 0, i32 2
  %91 = load i32, i32* %iRowFirst86, align 8
  %sub87 = sub nsw i32 %89, %91
  %92 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols88 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %92, i32 0, i32 1
  %93 = load i32, i32* %iCols88, align 4
  %mul89 = mul nsw i32 %sub87, %93
  %94 = load i32, i32* %i, align 4
  %add90 = add nsw i32 %mul89, %94
  %idxprom91 = sext i32 %add90 to i64
  %arrayidx92 = getelementptr inbounds double, double* %88, i64 %idxprom91
  store double %87, double* %arrayidx92, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body78
  %95 = load i32, i32* %i, align 4
  %inc93 = add nsw i32 %95, 1
  store i32 %inc93, i32* %i, align 4
  br label %for.cond75

for.end:                                          ; preds = %for.cond75
  br label %for.inc94

for.inc94:                                        ; preds = %for.end
  %96 = load i32, i32* %j, align 4
  %inc95 = add nsw i32 %96, 1
  store i32 %inc95, i32* %j, align 4
  br label %for.cond

for.end96:                                        ; preds = %for.cond
  %97 = load i32, i32* %iReqCnt, align 4
  %arraydecay = getelementptr inbounds [4 x %struct.ompi_request_t*], [4 x %struct.ompi_request_t*]* %request, i64 0, i64 0
  %arraydecay97 = getelementptr inbounds [4 x %struct.ompi_status_public_t], [4 x %struct.ompi_status_public_t]* %status, i64 0, i64 0
  %call98 = call i32 @MPI_Waitall(i32 %97, %struct.ompi_request_t** %arraydecay, %struct.ompi_status_public_t* %arraydecay97)
  ret void
}

declare i32 @MPI_Allreduce(i8*, i8*, i32, %struct.ompi_datatype_t*, %struct.ompi_op_t*, %struct.ompi_communicator_t*) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare double @llvm.sqrt.f64(double) #3

declare void @free(i8*) #2

declare i32 @fprintf(%struct.__sFILE*, i8*, ...) #2

declare void @Finish(%struct.JacobiData*) #2

; Function Attrs: noreturn
declare void @exit(i32) #4

declare i32 @MPI_Irecv(i8*, i32, %struct.ompi_datatype_t*, i32, i32, %struct.ompi_communicator_t*, %struct.ompi_request_t**) #2

declare i32 @MPI_Isend(i8*, i32, %struct.ompi_datatype_t*, i32, i32, %struct.ompi_communicator_t*, %struct.ompi_request_t**) #2

declare i32 @MPI_Waitall(i32, %struct.ompi_request_t**, %struct.ompi_status_public_t*) #2

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone speculatable willreturn }
attributes #4 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { allocsize(0) }
attributes #6 = { noreturn }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"Homebrew clang version 11.1.0"}
