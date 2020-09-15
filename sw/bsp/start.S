# Initialize sp and jump to main. Loop incase main returns
.global _start
_start:
    addi sp,zero,256
    jal main
here:
     j here
