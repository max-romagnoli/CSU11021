  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Init_Test


  .section  .text

  .type     Init_Test, %function
Init_Test:
  LDR   R1, =expression     @ set start address of expression
  bx    lr

@
@ Below is a sample expression that you can modify to test different
@   features of your program
@

  .section  .rodata

expression:
  .asciz    "0xA5+0xB5"         @ expression


.end