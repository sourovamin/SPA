; ModuleID = 'f3.c'
source_filename = "f3.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.17.0"

@.str = private unnamed_addr constant [9 x i8] c"Loop: %d\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %sum = alloca i32, align 4
  %add = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %d = alloca i32, align 4
  %i = alloca i32, align 4
  %i5 = alloca i32, align 4
  %i12 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 0, i32* %sum, align 4
  store i32 6, i32* %add, align 4
  %0 = load i32, i32* %sum, align 4
  %add1 = add nsw i32 %0, 100
  store i32 %add1, i32* %a, align 4
  store i32 2, i32* %b, align 4
  %1 = load i32, i32* %a, align 4
  %2 = load i32, i32* %b, align 4
  %add2 = add nsw i32 %1, %2
  store i32 %add2, i32* %d, align 4
  %3 = load i32, i32* %sum, align 4
  %4 = load i32, i32* %b, align 4
  %add3 = add nsw i32 %3, %4
  store i32 %add3, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc10, %entry
  %5 = load i32, i32* %i, align 4
  %6 = load i32, i32* %d, align 4
  %7 = load i32, i32* %b, align 4
  %add4 = add nsw i32 %6, %7
  %cmp = icmp sgt i32 %5, %add4
  br i1 %cmp, label %for.body, label %for.end11

for.body:                                         ; preds = %for.cond
  store i32 2, i32* %i5, align 4
  br label %for.cond6

for.cond6:                                        ; preds = %for.inc, %for.body
  %8 = load i32, i32* %i5, align 4
  %cmp7 = icmp slt i32 %8, 10
  br i1 %cmp7, label %for.body8, label %for.end

for.body8:                                        ; preds = %for.cond6
  %9 = load i32, i32* %sum, align 4
  %add9 = add nsw i32 %9, 1
  store i32 %add9, i32* %sum, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body8
  %10 = load i32, i32* %i5, align 4
  %11 = load i32, i32* %i5, align 4
  %mul = mul nsw i32 %10, %11
  store i32 %mul, i32* %i5, align 4
  br label %for.cond6

for.end:                                          ; preds = %for.cond6
  br label %for.inc10

for.inc10:                                        ; preds = %for.end
  %12 = load i32, i32* %i, align 4
  %dec = add nsw i32 %12, -1
  store i32 %dec, i32* %i, align 4
  br label %for.cond

for.end11:                                        ; preds = %for.cond
  store i32 0, i32* %i12, align 4
  br label %for.cond13

for.cond13:                                       ; preds = %if.end, %for.end11
  %13 = load i32, i32* %i12, align 4
  %cmp14 = icmp slt i32 %13, 5
  br i1 %cmp14, label %for.body15, label %for.end19

for.body15:                                       ; preds = %for.cond13
  %14 = load i32, i32* %i12, align 4
  %cmp16 = icmp eq i32 %14, 2
  br i1 %cmp16, label %if.then, label %if.else

if.then:                                          ; preds = %for.body15
  %15 = load i32, i32* %sum, align 4
  %add17 = add nsw i32 %15, 1
  store i32 %add17, i32* %sum, align 4
  br label %if.end

if.else:                                          ; preds = %for.body15
  %16 = load i32, i32* %sum, align 4
  %add18 = add nsw i32 %16, 2
  store i32 %add18, i32* %sum, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %17 = load i32, i32* %i12, align 4
  %inc = add nsw i32 %17, 1
  store i32 %inc, i32* %i12, align 4
  br label %for.cond13

for.end19:                                        ; preds = %for.cond13
  %18 = load i32, i32* %sum, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i32 %18)
  %19 = load i32, i32* %retval, align 4
  ret i32 %19
}

declare i32 @printf(i8*, ...) #1

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 9.0.1 "}
