; ModuleID = 'example3.cpp'
source_filename = "example3.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

@globalInt = global i32 42, align 4
@globalFloat = global float 0x40091EB860000000, align 4
@globalChar = global i8 65, align 1
@anotherGlob = global i32 0, align 4

; Function Attrs: noinline norecurse nounwind optnone ssp uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %sum = alloca i32, align 4
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 0, i32* %sum, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %1 = load i32, i32* @globalInt, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %sum, align 4
  %add = add nsw i32 %2, 1
  store i32 %add, i32* %sum, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4
  %inc = add nsw i32 %3, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i32 24, i32* @globalInt, align 4
  store float 0x4005AE1480000000, float* @globalFloat, align 4
  store i8 66, i8* @globalChar, align 1
  store i32 50, i32* @anotherGlob, align 4
  store i32 0, i32* %i1, align 4
  br label %for.cond2

for.cond2:                                        ; preds = %for.inc6, %for.end
  %4 = load i32, i32* %i1, align 4
  %5 = load i32, i32* @anotherGlob, align 4
  %cmp3 = icmp slt i32 %4, %5
  br i1 %cmp3, label %for.body4, label %for.end8

for.body4:                                        ; preds = %for.cond2
  %6 = load i32, i32* %sum, align 4
  %add5 = add nsw i32 %6, 1
  store i32 %add5, i32* %sum, align 4
  br label %for.inc6

for.inc6:                                         ; preds = %for.body4
  %7 = load i32, i32* %i1, align 4
  %inc7 = add nsw i32 %7, 1
  store i32 %inc7, i32* %i1, align 4
  br label %for.cond2

for.end8:                                         ; preds = %for.cond2
  ret i32 0
}

attributes #0 = { noinline norecurse nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"Homebrew clang version 11.1.0"}
