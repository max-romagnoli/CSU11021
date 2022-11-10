  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Init_Test

  .section  .text
  .type     Init_Test, %function
Init_Test:

  LDR   R1, =20     @ N = 20  // quotient

  bx    lr

.end