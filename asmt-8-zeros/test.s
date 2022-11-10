  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Init_Test

  .section  .text
  .type     Init_Test, %function
Init_Test:

  @ Test value
  LDR   R1, =0xD4202363

  bx    lr

.end