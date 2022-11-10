  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Init_Test


  .section  .text

  .type     Init_Test, %function
Init_Test:
  LDR   R0, =strA     @ address of space for ASCII string
  LDR   R1, =-578     @ test value
  BX    LR


  .section  .data

strA:
  .space  256         @ reserve space for ASCII string

.end