# Initialize sp and jump to main. Loop incase main returns
.global _start
_start:
    li sp,0x008007ff
    jal main
here:
     j here
