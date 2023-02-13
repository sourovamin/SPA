; ModuleID = 'example.c'
source_filename = "example.c"
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
  %i4 = alloca i32, align 4
  %i11 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 0, i32* %sum, align 4
  store i32 6, i32* %add, align 4
  %0 = load i32, i32* %sum, align 4
  %add1 = add nsw i32 %0, 5
  store i32 %add1, i32* %a, align 4
  %1 = load i32, i32* %add, align 4
  %add2 = add nsw i32 4, %1
  store i32 %add2, i32* %b, align 4
  %2 = load i32, i32* %a, align 4
  %3 = load i32, i32* %b, align 4
  %add3 = add nsw i32 %2, %3
  store i32 %add3, i32* %d, align 4
  store i32 100, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc9, %entry
  %4 = load i32, i32* %i, align 4
  %5 = load i32, i32* %b, align 4
  %cmp = icmp sgt i32 %4, %5
  br i1 %cmp, label %for.body, label %for.end10

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %i4, align 4
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc, %for.body
  %6 = load i32, i32* %i4, align 4
  %7 = load i32, i32* %d, align 4
  %cmp6 = icmp slt i32 %6, %7
  br i1 %cmp6, label %for.body7, label %for.end

for.body7:                                        ; preds = %for.cond5
  %8 = load i32, i32* %sum, align 4
  %add8 = add nsw i32 %8, 1
  store i32 %add8, i32* %sum, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body7
  %9 = load i32, i32* %i4, align 4
  %inc = add nsw i32 %9, 1
  store i32 %inc, i32* %i4, align 4
  br label %for.cond5

for.end:                                          ; preds = %for.cond5
  br label %for.inc9

for.inc9:                                         ; preds = %for.end
  %10 = load i32, i32* %i, align 4
  %dec = add nsw i32 %10, -1
  store i32 %dec, i32* %i, align 4
  br label %for.cond

for.end10:                                        ; preds = %for.cond
  store i32 0, i32* %i11, align 4
  br label %for.cond12

for.cond12:                                       ; preds = %for.inc18, %for.end10
  %11 = load i32, i32* %i11, align 4
  %cmp13 = icmp slt i32 %11, 5
  br i1 %cmp13, label %for.body14, label %for.end20

for.body14:                                       ; preds = %for.cond12
  %12 = load i32, i32* %i11, align 4
  %cmp15 = icmp eq i32 %12, 2
  br i1 %cmp15, label %if.then, label %if.else

if.then:                                          ; preds = %for.body14
  %13 = load i32, i32* %sum, align 4
  %add16 = add nsw i32 %13, 1
  store i32 %add16, i32* %sum, align 4
  br label %if.end

if.else:                                          ; preds = %for.body14
  %14 = load i32, i32* %sum, align 4
  %add17 = add nsw i32 %14, 2
  store i32 %add17, i32* %sum, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc18

for.inc18:                                        ; preds = %if.end
  %15 = load i32, i32* %i11, align 4
  %inc19 = add nsw i32 %15, 1
  store i32 %inc19, i32* %i11, align 4
  br label %for.cond12

for.end20:                                        ; preds = %for.cond12
  %16 = load i32, i32* %sum, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i32 %16)
  %17 = load i32, i32* %retval, align 4
  ret i32 %17
}

declare i32 @printf(i8*, ...) #1

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 9.0.1 "}
