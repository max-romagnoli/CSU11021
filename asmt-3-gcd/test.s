  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Init_Test

  .section  .text
  .type     Init_Test, %function
Init_Test:

  LDR   R2, =27     @ a = 24
  LDR   R3, =27     @ b = 32

  LDR   R1, =1      @ r = 1

  bx    lr

.end