; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

%struct.ompi_predefined_datatype_t = type opaque
%struct.ompi_predefined_op_t = type opaque
%struct.ompi_predefined_communicator_t = type opaque
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct.ompi_datatype_t = type opaque
%struct.JacobiData = type { i32, i32, i32, i32, i32, double, double, double, double, double, double*, double*, double, double, double, i32, double, i32, i32 }
%struct.ompi_op_t = type opaque
%struct.ompi_communicator_t = type opaque
%struct.ompi_request_t = type opaque
%struct.ompi_status_public_t = type { i32, i32, i32, i32, i64 }

@ompi_mpi_double = external global %struct.ompi_predefined_datatype_t, align 1
@ompi_mpi_op_sum = external global %struct.ompi_predefined_op_t, align 1
@ompi_mpi_comm_world = external global %struct.ompi_predefined_communicator_t, align 1
@__stderrp = external global %struct.__sFILE*, align 8
@.str = private unnamed_addr constant [29 x i8] c"Error: cant allocate memory\0A\00", align 1
@global_rank = global i32 0, align 4
@__const.Init.typelist = private unnamed_addr constant [8 x %struct.ompi_datatype_t*] [%struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_double to %struct.ompi_datatype_t*), %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_double to %struct.ompi_datatype_t*), %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_double to %struct.ompi_datatype_t*)], align 16
@.str.1 = private unnamed_addr constant [41 x i8] c"Abort: MPI_Init_thread unsuccessful: %s\0A\00", align 1
@.str.1.2 = private unnamed_addr constant [52 x i8] c"Warning: MPI_Init_thread only provided level %d<%d\0A\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"ITERATIONS\00", align 1
@.str.3 = private unnamed_addr constant [33 x i8] c"Ignoring invalid ITERATIONS=%s!\0A\00", align 1
@.str.4 = private unnamed_addr constant [62 x i8] c"Jacobi %d MPI-%d.%d#%d process(es) with %d thread(s)/process\0A\00", align 1
@.str.5 = private unnamed_addr constant [87 x i8] c"\0A-> matrix size: %dx%d\0A-> alpha: %f\0A-> relax: %f\0A-> tolerance: %f\0A-> iterations: %d \0A\0A\00", align 1
@ompi_mpi_int = external global %struct.ompi_predefined_datatype_t, align 1
@.str.6 = private unnamed_addr constant [28 x i8] c" Number of iterations : %d\0A\00", align 1
@.str.7 = private unnamed_addr constant [29 x i8] c" Residual             : %le\0A\00", align 1
@.str.8 = private unnamed_addr constant [33 x i8] c" Solution Error       : %1.12lf\0A\00", align 1
@.str.9 = private unnamed_addr constant [32 x i8] c" Elapsed Time         : %5.7lf\0A\00", align 1
@.str.10 = private unnamed_addr constant [32 x i8] c" MFlops               : %6.6lf\0A\00", align 1
@.str.11 = private unnamed_addr constant [31 x i8] c" Memory allocation failed ...\0A\00", align 1

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
  %call = call i8* @malloc(i64 %mul1) #6
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
  call void @exit(i32 1) #7
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

; Function Attrs: noreturn
declare void @exit(i32) #4

declare i32 @MPI_Irecv(i8*, i32, %struct.ompi_datatype_t*, i32, i32, %struct.ompi_communicator_t*, %struct.ompi_request_t**) #2

declare i32 @MPI_Isend(i8*, i32, %struct.ompi_datatype_t*, i32, i32, %struct.ompi_communicator_t*, %struct.ompi_request_t**) #2

declare i32 @MPI_Waitall(i32, %struct.ompi_request_t**, %struct.ompi_status_public_t*) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @Init(%struct.JacobiData* %data, i32* %argc, i8** %argv) #0 {
entry:
  %data.addr = alloca %struct.JacobiData*, align 8
  %argc.addr = alloca i32*, align 8
  %argv.addr = alloca i8**, align 8
  %i = alloca i32, align 4
  %block_lengths = alloca [8 x i32], align 16
  %MPI_JacobiData = alloca %struct.ompi_datatype_t*, align 8
  %typelist = alloca [8 x %struct.ompi_datatype_t*], align 16
  %displacements = alloca [8 x i64], align 16
  %required = alloca i32, align 4
  %provided = alloca i32, align 4
  %ierr = alloca i32, align 4
  %version = alloca i32, align 4
  %subversion = alloca i32, align 4
  %ITERATIONS = alloca i32, align 4
  %env = alloca i8*, align 8
  %iterations = alloca i32, align 4
  store %struct.JacobiData* %data, %struct.JacobiData** %data.addr, align 8
  store i32* %argc, i32** %argc.addr, align 8
  store i8** %argv, i8*** %argv.addr, align 8
  %0 = bitcast [8 x %struct.ompi_datatype_t*]* %typelist to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 bitcast ([8 x %struct.ompi_datatype_t*]* @__const.Init.typelist to i8*), i64 64, i1 false)
  store i32 1, i32* %required, align 4
  %1 = load i32*, i32** %argc.addr, align 8
  %call = call i32 @MPI_Init_thread(i32* %1, i8*** %argv.addr, i32 1, i32* %provided)
  store i32 %call, i32* %ierr, align 4
  %2 = load i32, i32* %ierr, align 4
  %cmp = icmp ne i32 %2, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %call1 = call i32* @__error()
  %3 = load i32, i32* %call1, align 4
  %call2 = call i8* @"\01_strerror"(i32 %3)
  %call3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.1, i64 0, i64 0), i8* %call2)
  %call4 = call i32 @MPI_Abort(%struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*), i32 78)
  br label %if.end8

if.else:                                          ; preds = %entry
  %4 = load i32, i32* %provided, align 4
  %cmp5 = icmp slt i32 %4, 1
  br i1 %cmp5, label %if.then6, label %if.end

if.then6:                                         ; preds = %if.else
  %5 = load i32, i32* %provided, align 4
  %call7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([52 x i8], [52 x i8]* @.str.1.2, i64 0, i64 0), i32 %5, i32 1)
  br label %if.end

if.end:                                           ; preds = %if.then6, %if.else
  br label %if.end8

if.end8:                                          ; preds = %if.end, %if.then
  %6 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %6, i32 0, i32 17
  %call9 = call i32 @MPI_Comm_rank(%struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*), i32* %iMyRank)
  %7 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iNumProcs = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %7, i32 0, i32 18
  %call10 = call i32 @MPI_Comm_size(%struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*), i32* %iNumProcs)
  %8 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank11 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %8, i32 0, i32 17
  %9 = load i32, i32* %iMyRank11, align 8
  store i32 %9, i32* @global_rank, align 4
  %10 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank12 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %10, i32 0, i32 17
  %11 = load i32, i32* %iMyRank12, align 8
  %cmp13 = icmp eq i32 %11, 0
  br i1 %cmp13, label %if.then14, label %if.end35

if.then14:                                        ; preds = %if.end8
  store i32 100, i32* %ITERATIONS, align 4
  %call15 = call i8* @getenv(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i64 0, i64 0))
  store i8* %call15, i8** %env, align 8
  %12 = load i8*, i8** %env, align 8
  %tobool = icmp ne i8* %12, null
  br i1 %tobool, label %if.then16, label %if.end23

if.then16:                                        ; preds = %if.then14
  %13 = load i8*, i8** %env, align 8
  %call17 = call i32 @atoi(i8* %13)
  store i32 %call17, i32* %iterations, align 4
  %14 = load i32, i32* %iterations, align 4
  %cmp18 = icmp sgt i32 %14, 0
  br i1 %cmp18, label %if.then19, label %if.else20

if.then19:                                        ; preds = %if.then16
  %15 = load i32, i32* %iterations, align 4
  store i32 %15, i32* %ITERATIONS, align 4
  br label %if.end22

if.else20:                                        ; preds = %if.then16
  %16 = load i8*, i8** %env, align 8
  %call21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.3, i64 0, i64 0), i8* %16)
  br label %if.end22

if.end22:                                         ; preds = %if.else20, %if.then19
  br label %if.end23

if.end23:                                         ; preds = %if.end22, %if.then14
  %call24 = call i32 @MPI_Get_version(i32* %version, i32* %subversion)
  %17 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iNumProcs25 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %17, i32 0, i32 18
  %18 = load i32, i32* %iNumProcs25, align 4
  %19 = load i32, i32* %version, align 4
  %20 = load i32, i32* %subversion, align 4
  %21 = load i32, i32* %provided, align 4
  %call26 = call i32 @omp_get_max_threads()
  %call27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([62 x i8], [62 x i8]* @.str.4, i64 0, i64 0), i32 %18, i32 %19, i32 %20, i32 %21, i32 %call26)
  %22 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %22, i32 0, i32 1
  store i32 2000, i32* %iCols, align 4
  %23 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRows = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %23, i32 0, i32 0
  store i32 2000, i32* %iRows, align 8
  %24 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fAlpha = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %24, i32 0, i32 5
  store double 8.000000e-01, double* %fAlpha, align 8
  %25 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fRelax = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %25, i32 0, i32 6
  store double 1.000000e+00, double* %fRelax, align 8
  %26 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fTolerance = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %26, i32 0, i32 7
  store double 1.000000e-10, double* %fTolerance, align 8
  %27 = load i32, i32* %ITERATIONS, align 4
  %28 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iIterMax = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %28, i32 0, i32 4
  store i32 %27, i32* %iIterMax, align 8
  %29 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols28 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %29, i32 0, i32 1
  %30 = load i32, i32* %iCols28, align 4
  %31 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRows29 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %31, i32 0, i32 0
  %32 = load i32, i32* %iRows29, align 8
  %33 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fAlpha30 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %33, i32 0, i32 5
  %34 = load double, double* %fAlpha30, align 8
  %35 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fRelax31 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %35, i32 0, i32 6
  %36 = load double, double* %fRelax31, align 8
  %37 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fTolerance32 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %37, i32 0, i32 7
  %38 = load double, double* %fTolerance32, align 8
  %39 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iIterMax33 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %39, i32 0, i32 4
  %40 = load i32, i32* %iIterMax33, align 8
  %call34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([87 x i8], [87 x i8]* @.str.5, i64 0, i64 0), i32 %30, i32 %32, double %34, double %36, double %38, i32 %40)
  br label %if.end35

if.end35:                                         ; preds = %if.end23, %if.end8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end35
  %41 = load i32, i32* %i, align 4
  %cmp36 = icmp slt i32 %41, 8
  br i1 %cmp36, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %42 = load i32, i32* %i, align 4
  %idxprom = sext i32 %42 to i64
  %arrayidx = getelementptr inbounds [8 x i32], [8 x i32]* %block_lengths, i64 0, i64 %idxprom
  store i32 1, i32* %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %43 = load i32, i32* %i, align 4
  %inc = add nsw i32 %43, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %arrayidx37 = getelementptr inbounds [8 x i64], [8 x i64]* %displacements, i64 0, i64 0
  store i64 0, i64* %arrayidx37, align 16
  %arrayidx38 = getelementptr inbounds [8 x i64], [8 x i64]* %displacements, i64 0, i64 1
  store i64 4, i64* %arrayidx38, align 8
  %arrayidx39 = getelementptr inbounds [8 x i64], [8 x i64]* %displacements, i64 0, i64 2
  store i64 8, i64* %arrayidx39, align 16
  %arrayidx40 = getelementptr inbounds [8 x i64], [8 x i64]* %displacements, i64 0, i64 3
  store i64 12, i64* %arrayidx40, align 8
  %arrayidx41 = getelementptr inbounds [8 x i64], [8 x i64]* %displacements, i64 0, i64 4
  store i64 16, i64* %arrayidx41, align 16
  %arrayidx42 = getelementptr inbounds [8 x i64], [8 x i64]* %displacements, i64 0, i64 5
  store i64 24, i64* %arrayidx42, align 8
  %arrayidx43 = getelementptr inbounds [8 x i64], [8 x i64]* %displacements, i64 0, i64 6
  store i64 32, i64* %arrayidx43, align 16
  %arrayidx44 = getelementptr inbounds [8 x i64], [8 x i64]* %displacements, i64 0, i64 7
  store i64 40, i64* %arrayidx44, align 8
  %arraydecay = getelementptr inbounds [8 x i32], [8 x i32]* %block_lengths, i64 0, i64 0
  %arraydecay45 = getelementptr inbounds [8 x i64], [8 x i64]* %displacements, i64 0, i64 0
  %arraydecay46 = getelementptr inbounds [8 x %struct.ompi_datatype_t*], [8 x %struct.ompi_datatype_t*]* %typelist, i64 0, i64 0
  %call47 = call i32 @MPI_Type_create_struct(i32 8, i32* %arraydecay, i64* %arraydecay45, %struct.ompi_datatype_t** %arraydecay46, %struct.ompi_datatype_t** %MPI_JacobiData)
  %call48 = call i32 @MPI_Type_commit(%struct.ompi_datatype_t** %MPI_JacobiData)
  %44 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %45 = bitcast %struct.JacobiData* %44 to i8*
  %46 = load %struct.ompi_datatype_t*, %struct.ompi_datatype_t** %MPI_JacobiData, align 8
  %call49 = call i32 @MPI_Bcast(i8* %45, i32 1, %struct.ompi_datatype_t* %46, i32 0, %struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*))
  %47 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank50 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %47, i32 0, i32 17
  %48 = load i32, i32* %iMyRank50, align 8
  %49 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRows51 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %49, i32 0, i32 0
  %50 = load i32, i32* %iRows51, align 8
  %sub = sub nsw i32 %50, 2
  %mul = mul nsw i32 %48, %sub
  %51 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iNumProcs52 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %51, i32 0, i32 18
  %52 = load i32, i32* %iNumProcs52, align 4
  %div = sdiv i32 %mul, %52
  %53 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %53, i32 0, i32 2
  store i32 %div, i32* %iRowFirst, align 8
  %54 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank53 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %54, i32 0, i32 17
  %55 = load i32, i32* %iMyRank53, align 8
  %56 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iNumProcs54 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %56, i32 0, i32 18
  %57 = load i32, i32* %iNumProcs54, align 4
  %sub55 = sub nsw i32 %57, 1
  %cmp56 = icmp eq i32 %55, %sub55
  br i1 %cmp56, label %if.then57, label %if.else60

if.then57:                                        ; preds = %for.end
  %58 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRows58 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %58, i32 0, i32 0
  %59 = load i32, i32* %iRows58, align 8
  %sub59 = sub nsw i32 %59, 1
  %60 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowLast = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %60, i32 0, i32 3
  store i32 %sub59, i32* %iRowLast, align 4
  br label %if.end69

if.else60:                                        ; preds = %for.end
  %61 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank61 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %61, i32 0, i32 17
  %62 = load i32, i32* %iMyRank61, align 8
  %add = add nsw i32 %62, 1
  %63 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRows62 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %63, i32 0, i32 0
  %64 = load i32, i32* %iRows62, align 8
  %sub63 = sub nsw i32 %64, 2
  %mul64 = mul nsw i32 %add, %sub63
  %65 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iNumProcs65 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %65, i32 0, i32 18
  %66 = load i32, i32* %iNumProcs65, align 4
  %div66 = sdiv i32 %mul64, %66
  %add67 = add nsw i32 %div66, 1
  %67 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowLast68 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %67, i32 0, i32 3
  store i32 %add67, i32* %iRowLast68, align 4
  br label %if.end69

if.end69:                                         ; preds = %if.else60, %if.then57
  %68 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowLast70 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %68, i32 0, i32 3
  %69 = load i32, i32* %iRowLast70, align 4
  %70 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst71 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %70, i32 0, i32 2
  %71 = load i32, i32* %iRowFirst71, align 8
  %sub72 = sub nsw i32 %69, %71
  %add73 = add nsw i32 %sub72, 1
  %72 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols74 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %72, i32 0, i32 1
  %73 = load i32, i32* %iCols74, align 4
  %mul75 = mul nsw i32 %add73, %73
  %conv = sext i32 %mul75 to i64
  %mul76 = mul i64 %conv, 8
  %call77 = call i8* @malloc(i64 %mul76) #6
  %74 = bitcast i8* %call77 to double*
  %75 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %afU = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %75, i32 0, i32 10
  store double* %74, double** %afU, align 8
  %76 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowLast78 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %76, i32 0, i32 3
  %77 = load i32, i32* %iRowLast78, align 4
  %78 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst79 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %78, i32 0, i32 2
  %79 = load i32, i32* %iRowFirst79, align 8
  %sub80 = sub nsw i32 %77, %79
  %add81 = add nsw i32 %sub80, 1
  %80 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols82 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %80, i32 0, i32 1
  %81 = load i32, i32* %iCols82, align 4
  %mul83 = mul nsw i32 %add81, %81
  %conv84 = sext i32 %mul83 to i64
  %mul85 = mul i64 %conv84, 8
  %call86 = call i8* @malloc(i64 %mul85) #6
  %82 = bitcast i8* %call86 to double*
  %83 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %afF = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %83, i32 0, i32 11
  store double* %82, double** %afF, align 8
  %84 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols87 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %84, i32 0, i32 1
  %85 = load i32, i32* %iCols87, align 4
  %sub88 = sub nsw i32 %85, 1
  %conv89 = sitofp i32 %sub88 to double
  %div90 = fdiv double 2.000000e+00, %conv89
  %86 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fDx = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %86, i32 0, i32 8
  store double %div90, double* %fDx, align 8
  %87 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRows91 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %87, i32 0, i32 0
  %88 = load i32, i32* %iRows91, align 8
  %sub92 = sub nsw i32 %88, 1
  %conv93 = sitofp i32 %sub92 to double
  %div94 = fdiv double 2.000000e+00, %conv93
  %89 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fDy = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %89, i32 0, i32 9
  store double %div94, double* %fDy, align 8
  %90 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iIterCount = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %90, i32 0, i32 15
  store i32 0, i32* %iIterCount, align 8
  ret void
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #5

declare i32 @MPI_Init_thread(i32*, i8***, i32, i32*) #2

declare i32* @__error() #2

declare i8* @"\01_strerror"(i32) #2

declare i32 @printf(i8*, ...) #2

declare i32 @MPI_Abort(%struct.ompi_communicator_t*, i32) #2

declare i32 @MPI_Comm_rank(%struct.ompi_communicator_t*, i32*) #2

declare i32 @MPI_Comm_size(%struct.ompi_communicator_t*, i32*) #2

declare i8* @getenv(i8*) #2

declare i32 @atoi(i8*) #2

declare i32 @MPI_Get_version(i32*, i32*) #2

declare i32 @omp_get_max_threads() #2

declare i32 @MPI_Type_create_struct(i32, i32*, i64*, %struct.ompi_datatype_t**, %struct.ompi_datatype_t**) #2

declare i32 @MPI_Type_commit(%struct.ompi_datatype_t**) #2

declare i32 @MPI_Bcast(i8*, i32, %struct.ompi_datatype_t*, i32, %struct.ompi_communicator_t*) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @Finish(%struct.JacobiData* %data) #0 {
entry:
  %data.addr = alloca %struct.JacobiData*, align 8
  store %struct.JacobiData* %data, %struct.JacobiData** %data.addr, align 8
  %0 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %afU = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %0, i32 0, i32 10
  %1 = load double*, double** %afU, align 8
  %2 = bitcast double* %1 to i8*
  call void @free(i8* %2)
  %3 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %afF = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %3, i32 0, i32 11
  %4 = load double*, double** %afF, align 8
  %5 = bitcast double* %4 to i8*
  call void @free(i8* %5)
  %call = call i32 @MPI_Finalize()
  ret void
}

declare i32 @MPI_Finalize() #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @PrintResults(%struct.JacobiData* %data) #0 {
entry:
  %data.addr = alloca %struct.JacobiData*, align 8
  store %struct.JacobiData* %data, %struct.JacobiData** %data.addr, align 8
  %0 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %0, i32 0, i32 17
  %1 = load i32, i32* %iMyRank, align 8
  %cmp = icmp eq i32 %1, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %2 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iIterCount = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %2, i32 0, i32 15
  %3 = load i32, i32* %iIterCount, align 8
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.6, i64 0, i64 0), i32 %3)
  %4 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fResidual = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %4, i32 0, i32 14
  %5 = load double, double* %fResidual, align 8
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.7, i64 0, i64 0), double %5)
  %6 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fError = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %6, i32 0, i32 16
  %7 = load double, double* %fError, align 8
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.8, i64 0, i64 0), double %7)
  %8 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fTimeStop = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %8, i32 0, i32 13
  %9 = load double, double* %fTimeStop, align 8
  %10 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fTimeStart = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %10, i32 0, i32 12
  %11 = load double, double* %fTimeStart, align 8
  %sub = fsub double %9, %11
  %call3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.9, i64 0, i64 0), double %sub)
  %12 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iIterCount4 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %12, i32 0, i32 15
  %13 = load i32, i32* %iIterCount4, align 8
  %conv = sitofp i32 %13 to double
  %mul = fmul double 1.300000e-05, %conv
  %14 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %14, i32 0, i32 1
  %15 = load i32, i32* %iCols, align 4
  %sub5 = sub nsw i32 %15, 2
  %conv6 = sitofp i32 %sub5 to double
  %mul7 = fmul double %mul, %conv6
  %16 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRows = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %16, i32 0, i32 0
  %17 = load i32, i32* %iRows, align 8
  %sub8 = sub nsw i32 %17, 2
  %conv9 = sitofp i32 %sub8 to double
  %mul10 = fmul double %mul7, %conv9
  %18 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fTimeStop11 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %18, i32 0, i32 13
  %19 = load double, double* %fTimeStop11, align 8
  %20 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fTimeStart12 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %20, i32 0, i32 12
  %21 = load double, double* %fTimeStart12, align 8
  %sub13 = fsub double %19, %21
  %div = fdiv double %mul10, %sub13
  %call14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.10, i64 0, i64 0), double %div)
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @InitializeMatrix(%struct.JacobiData* %data) #0 {
entry:
  %data.addr = alloca %struct.JacobiData*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %xx = alloca double, align 8
  %yy = alloca double, align 8
  %xx2 = alloca double, align 8
  %yy2 = alloca double, align 8
  store %struct.JacobiData* %data, %struct.JacobiData** %data.addr, align 8
  %0 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %0, i32 0, i32 2
  %1 = load i32, i32* %iRowFirst, align 8
  store i32 %1, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc28, %entry
  %2 = load i32, i32* %j, align 4
  %3 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowLast = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %3, i32 0, i32 3
  %4 = load i32, i32* %iRowLast, align 4
  %cmp = icmp sle i32 %2, %4
  br i1 %cmp, label %for.body, label %for.end30

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %5 = load i32, i32* %i, align 4
  %6 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %6, i32 0, i32 1
  %7 = load i32, i32* %iCols, align 4
  %cmp2 = icmp slt i32 %5, %7
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %8 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fDx = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %8, i32 0, i32 8
  %9 = load double, double* %fDx, align 8
  %10 = load i32, i32* %i, align 4
  %conv = sitofp i32 %10 to double
  %mul = fmul double %9, %conv
  %add = fadd double -1.000000e+00, %mul
  store double %add, double* %xx, align 8
  %11 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fDy = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %11, i32 0, i32 9
  %12 = load double, double* %fDy, align 8
  %13 = load i32, i32* %j, align 4
  %conv4 = sitofp i32 %13 to double
  %mul5 = fmul double %12, %conv4
  %add6 = fadd double -1.000000e+00, %mul5
  store double %add6, double* %yy, align 8
  %14 = load double, double* %xx, align 8
  %15 = load double, double* %xx, align 8
  %mul7 = fmul double %14, %15
  store double %mul7, double* %xx2, align 8
  %16 = load double, double* %yy, align 8
  %17 = load double, double* %yy, align 8
  %mul8 = fmul double %16, %17
  store double %mul8, double* %yy2, align 8
  %18 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %afU = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %18, i32 0, i32 10
  %19 = load double*, double** %afU, align 8
  %20 = load i32, i32* %j, align 4
  %21 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst9 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %21, i32 0, i32 2
  %22 = load i32, i32* %iRowFirst9, align 8
  %sub = sub nsw i32 %20, %22
  %23 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols10 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %23, i32 0, i32 1
  %24 = load i32, i32* %iCols10, align 4
  %mul11 = mul nsw i32 %sub, %24
  %25 = load i32, i32* %i, align 4
  %add12 = add nsw i32 %mul11, %25
  %idxprom = sext i32 %add12 to i64
  %arrayidx = getelementptr inbounds double, double* %19, i64 %idxprom
  store double 0.000000e+00, double* %arrayidx, align 8
  %26 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fAlpha = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %26, i32 0, i32 5
  %27 = load double, double* %fAlpha, align 8
  %fneg = fneg double %27
  %28 = load double, double* %xx2, align 8
  %sub13 = fsub double 1.000000e+00, %28
  %mul14 = fmul double %fneg, %sub13
  %29 = load double, double* %yy2, align 8
  %sub15 = fsub double 1.000000e+00, %29
  %mul16 = fmul double %mul14, %sub15
  %30 = load double, double* %xx2, align 8
  %add17 = fadd double -2.000000e+00, %30
  %31 = load double, double* %yy2, align 8
  %add18 = fadd double %add17, %31
  %mul19 = fmul double 2.000000e+00, %add18
  %add20 = fadd double %mul16, %mul19
  %32 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %afF = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %32, i32 0, i32 11
  %33 = load double*, double** %afF, align 8
  %34 = load i32, i32* %j, align 4
  %35 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst21 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %35, i32 0, i32 2
  %36 = load i32, i32* %iRowFirst21, align 8
  %sub22 = sub nsw i32 %34, %36
  %37 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols23 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %37, i32 0, i32 1
  %38 = load i32, i32* %iCols23, align 4
  %mul24 = mul nsw i32 %sub22, %38
  %39 = load i32, i32* %i, align 4
  %add25 = add nsw i32 %mul24, %39
  %idxprom26 = sext i32 %add25 to i64
  %arrayidx27 = getelementptr inbounds double, double* %33, i64 %idxprom26
  store double %add20, double* %arrayidx27, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %40 = load i32, i32* %i, align 4
  %inc = add nsw i32 %40, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  br label %for.inc28

for.inc28:                                        ; preds = %for.end
  %41 = load i32, i32* %j, align 4
  %inc29 = add nsw i32 %41, 1
  store i32 %inc29, i32* %j, align 4
  br label %for.cond

for.end30:                                        ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @CheckError(%struct.JacobiData* %data) #0 {
entry:
  %data.addr = alloca %struct.JacobiData*, align 8
  %error = alloca double, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %xx = alloca double, align 8
  %yy = alloca double, align 8
  %temp = alloca double, align 8
  store %struct.JacobiData* %data, %struct.JacobiData** %data.addr, align 8
  store double 0.000000e+00, double* %error, align 8
  %0 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %0, i32 0, i32 2
  %1 = load i32, i32* %iRowFirst, align 8
  store i32 %1, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc28, %entry
  %2 = load i32, i32* %j, align 4
  %3 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowLast = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %3, i32 0, i32 3
  %4 = load i32, i32* %iRowLast, align 4
  %cmp = icmp sle i32 %2, %4
  br i1 %cmp, label %for.body, label %for.end30

for.body:                                         ; preds = %for.cond
  %5 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %5, i32 0, i32 17
  %6 = load i32, i32* %iMyRank, align 8
  %cmp1 = icmp ne i32 %6, 0
  br i1 %cmp1, label %land.lhs.true, label %lor.lhs.false

land.lhs.true:                                    ; preds = %for.body
  %7 = load i32, i32* %j, align 4
  %8 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst2 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %8, i32 0, i32 2
  %9 = load i32, i32* %iRowFirst2, align 8
  %cmp3 = icmp eq i32 %7, %9
  br i1 %cmp3, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %land.lhs.true, %for.body
  %10 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iMyRank4 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %10, i32 0, i32 17
  %11 = load i32, i32* %iMyRank4, align 8
  %12 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iNumProcs = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %12, i32 0, i32 18
  %13 = load i32, i32* %iNumProcs, align 4
  %sub = sub nsw i32 %13, 1
  %cmp5 = icmp ne i32 %11, %sub
  br i1 %cmp5, label %land.lhs.true6, label %if.end

land.lhs.true6:                                   ; preds = %lor.lhs.false
  %14 = load i32, i32* %j, align 4
  %15 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowLast7 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %15, i32 0, i32 3
  %16 = load i32, i32* %iRowLast7, align 4
  %cmp8 = icmp eq i32 %14, %16
  br i1 %cmp8, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true6, %land.lhs.true
  br label %for.inc28

if.end:                                           ; preds = %land.lhs.true6, %lor.lhs.false
  store i32 0, i32* %i, align 4
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc, %if.end
  %17 = load i32, i32* %i, align 4
  %18 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %18, i32 0, i32 1
  %19 = load i32, i32* %iCols, align 4
  %cmp10 = icmp slt i32 %17, %19
  br i1 %cmp10, label %for.body11, label %for.end

for.body11:                                       ; preds = %for.cond9
  %20 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fDx = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %20, i32 0, i32 8
  %21 = load double, double* %fDx, align 8
  %22 = load i32, i32* %i, align 4
  %conv = sitofp i32 %22 to double
  %mul = fmul double %21, %conv
  %add = fadd double -1.000000e+00, %mul
  store double %add, double* %xx, align 8
  %23 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fDy = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %23, i32 0, i32 9
  %24 = load double, double* %fDy, align 8
  %25 = load i32, i32* %j, align 4
  %conv12 = sitofp i32 %25 to double
  %mul13 = fmul double %24, %conv12
  %add14 = fadd double -1.000000e+00, %mul13
  store double %add14, double* %yy, align 8
  %26 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %afU = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %26, i32 0, i32 10
  %27 = load double*, double** %afU, align 8
  %28 = load i32, i32* %j, align 4
  %29 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRowFirst15 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %29, i32 0, i32 2
  %30 = load i32, i32* %iRowFirst15, align 8
  %sub16 = sub nsw i32 %28, %30
  %31 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols17 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %31, i32 0, i32 1
  %32 = load i32, i32* %iCols17, align 4
  %mul18 = mul nsw i32 %sub16, %32
  %33 = load i32, i32* %i, align 4
  %add19 = add nsw i32 %mul18, %33
  %idxprom = sext i32 %add19 to i64
  %arrayidx = getelementptr inbounds double, double* %27, i64 %idxprom
  %34 = load double, double* %arrayidx, align 8
  %35 = load double, double* %xx, align 8
  %36 = load double, double* %xx, align 8
  %mul20 = fmul double %35, %36
  %sub21 = fsub double 1.000000e+00, %mul20
  %37 = load double, double* %yy, align 8
  %38 = load double, double* %yy, align 8
  %mul22 = fmul double %37, %38
  %sub23 = fsub double 1.000000e+00, %mul22
  %mul24 = fmul double %sub21, %sub23
  %sub25 = fsub double %34, %mul24
  store double %sub25, double* %temp, align 8
  %39 = load double, double* %temp, align 8
  %40 = load double, double* %temp, align 8
  %mul26 = fmul double %39, %40
  %41 = load double, double* %error, align 8
  %add27 = fadd double %41, %mul26
  store double %add27, double* %error, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body11
  %42 = load i32, i32* %i, align 4
  %inc = add nsw i32 %42, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond9

for.end:                                          ; preds = %for.cond9
  br label %for.inc28

for.inc28:                                        ; preds = %for.end, %if.then
  %43 = load i32, i32* %j, align 4
  %inc29 = add nsw i32 %43, 1
  store i32 %inc29, i32* %j, align 4
  br label %for.cond

for.end30:                                        ; preds = %for.cond
  %44 = load double, double* %error, align 8
  %45 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fError = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %45, i32 0, i32 16
  store double %44, double* %fError, align 8
  %46 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fError31 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %46, i32 0, i32 16
  %47 = bitcast double* %fError31 to i8*
  %48 = bitcast double* %error to i8*
  %call = call i32 @MPI_Reduce(i8* %47, i8* %48, i32 1, %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_double to %struct.ompi_datatype_t*), %struct.ompi_op_t* bitcast (%struct.ompi_predefined_op_t* @ompi_mpi_op_sum to %struct.ompi_op_t*), i32 0, %struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*))
  %49 = load double, double* %error, align 8
  %50 = call double @llvm.sqrt.f64(double %49)
  %51 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iCols32 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %51, i32 0, i32 1
  %52 = load i32, i32* %iCols32, align 4
  %53 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %iRows = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %53, i32 0, i32 0
  %54 = load i32, i32* %iRows, align 8
  %mul33 = mul nsw i32 %52, %54
  %conv34 = sitofp i32 %mul33 to double
  %div = fdiv double %50, %conv34
  %55 = load %struct.JacobiData*, %struct.JacobiData** %data.addr, align 8
  %fError35 = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %55, i32 0, i32 16
  store double %div, double* %fError35, align 8
  ret void
}

declare i32 @MPI_Reduce(i8*, i8*, i32, %struct.ompi_datatype_t*, %struct.ompi_op_t*, i32, %struct.ompi_communicator_t*) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %retVal = alloca i32, align 4
  %myData = alloca %struct.JacobiData, align 8
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  store i32 0, i32* %retVal, align 4
  %0 = load i8**, i8*** %argv.addr, align 8
  call void @Init(%struct.JacobiData* %myData, i32* %argc.addr, i8** %0)
  %afU = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %myData, i32 0, i32 10
  %1 = load double*, double** %afU, align 8
  %tobool = icmp ne double* %1, null
  br i1 %tobool, label %land.lhs.true, label %if.else

land.lhs.true:                                    ; preds = %entry
  %afF = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %myData, i32 0, i32 11
  %2 = load double*, double** %afF, align 8
  %tobool1 = icmp ne double* %2, null
  br i1 %tobool1, label %if.then, label %if.else

if.then:                                          ; preds = %land.lhs.true
  call void @InitializeMatrix(%struct.JacobiData* %myData)
  %call = call double @MPI_Wtime()
  %fTimeStart = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %myData, i32 0, i32 12
  store double %call, double* %fTimeStart, align 8
  call void @Jacobi(%struct.JacobiData* %myData)
  %call2 = call double @MPI_Wtime()
  %fTimeStop = getelementptr inbounds %struct.JacobiData, %struct.JacobiData* %myData, i32 0, i32 13
  store double %call2, double* %fTimeStop, align 8
  call void @CheckError(%struct.JacobiData* %myData)
  call void @PrintResults(%struct.JacobiData* %myData)
  br label %if.end

if.else:                                          ; preds = %land.lhs.true, %entry
  %call3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.11, i64 0, i64 0))
  store i32 -1, i32* %retVal, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  call void @Finish(%struct.JacobiData* %myData)
  %3 = load i32, i32* %retVal, align 4
  ret i32 %3
}

declare double @MPI_Wtime() #2

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone speculatable willreturn }
attributes #4 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { argmemonly nounwind willreturn }
attributes #6 = { allocsize(0) }
attributes #7 = { noreturn }

!llvm.ident = !{!0, !0}
!llvm.module.flags = !{!1, !2}

!0 = !{!"Homebrew clang version 11.1.0"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
