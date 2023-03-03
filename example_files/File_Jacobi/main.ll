; ModuleID = 'File_Jacobi/main.c'
source_filename = "File_Jacobi/main.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

%struct.ompi_predefined_datatype_t = type opaque
%struct.ompi_datatype_t = type opaque
%struct.ompi_predefined_communicator_t = type opaque
%struct.ompi_predefined_op_t = type opaque
%struct.JacobiData = type { i32, i32, i32, i32, i32, double, double, double, double, double, double*, double*, double, double, double, i32, double, i32, i32 }
%struct.ompi_communicator_t = type opaque
%struct.ompi_op_t = type opaque

@ompi_mpi_int = external global %struct.ompi_predefined_datatype_t, align 1
@ompi_mpi_double = external global %struct.ompi_predefined_datatype_t, align 1
@__const.Init.typelist = private unnamed_addr constant [8 x %struct.ompi_datatype_t*] [%struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_double to %struct.ompi_datatype_t*), %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_double to %struct.ompi_datatype_t*), %struct.ompi_datatype_t* bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_double to %struct.ompi_datatype_t*)], align 16
@.str = private unnamed_addr constant [41 x i8] c"Abort: MPI_Init_thread unsuccessful: %s\0A\00", align 1
@ompi_mpi_comm_world = external global %struct.ompi_predefined_communicator_t, align 1
@.str.1 = private unnamed_addr constant [52 x i8] c"Warning: MPI_Init_thread only provided level %d<%d\0A\00", align 1
@global_rank = global i32 0, align 4
@.str.2 = private unnamed_addr constant [11 x i8] c"ITERATIONS\00", align 1
@.str.3 = private unnamed_addr constant [33 x i8] c"Ignoring invalid ITERATIONS=%s!\0A\00", align 1
@.str.4 = private unnamed_addr constant [62 x i8] c"Jacobi %d MPI-%d.%d#%d process(es) with %d thread(s)/process\0A\00", align 1
@.str.5 = private unnamed_addr constant [87 x i8] c"\0A-> matrix size: %dx%d\0A-> alpha: %f\0A-> relax: %f\0A-> tolerance: %f\0A-> iterations: %d \0A\0A\00", align 1
@.str.6 = private unnamed_addr constant [28 x i8] c" Number of iterations : %d\0A\00", align 1
@.str.7 = private unnamed_addr constant [29 x i8] c" Residual             : %le\0A\00", align 1
@.str.8 = private unnamed_addr constant [33 x i8] c" Solution Error       : %1.12lf\0A\00", align 1
@.str.9 = private unnamed_addr constant [32 x i8] c" Elapsed Time         : %5.7lf\0A\00", align 1
@.str.10 = private unnamed_addr constant [32 x i8] c" MFlops               : %6.6lf\0A\00", align 1
@ompi_mpi_op_sum = external global %struct.ompi_predefined_op_t, align 1
@.str.11 = private unnamed_addr constant [31 x i8] c" Memory allocation failed ...\0A\00", align 1

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
  %call3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str, i64 0, i64 0), i8* %call2)
  %call4 = call i32 @MPI_Abort(%struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*), i32 78)
  br label %if.end8

if.else:                                          ; preds = %entry
  %4 = load i32, i32* %provided, align 4
  %cmp5 = icmp slt i32 %4, 1
  br i1 %cmp5, label %if.then6, label %if.end

if.then6:                                         ; preds = %if.else
  %5 = load i32, i32* %provided, align 4
  %call7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([52 x i8], [52 x i8]* @.str.1, i64 0, i64 0), i32 %5, i32 1)
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
  %call77 = call i8* @malloc(i64 %mul76) #5
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
  %call86 = call i8* @malloc(i64 %mul85) #5
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
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

declare i32 @MPI_Init_thread(i32*, i8***, i32, i32*) #2

declare i32 @printf(i8*, ...) #2

declare i8* @"\01_strerror"(i32) #2

declare i32* @__error() #2

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

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #3

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

declare void @free(i8*) #2

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

; Function Attrs: nounwind readnone speculatable willreturn
declare double @llvm.sqrt.f64(double) #4

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

declare void @Jacobi(%struct.JacobiData*) #2

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone speculatable willreturn }
attributes #5 = { allocsize(0) }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"Homebrew clang version 11.1.0"}
