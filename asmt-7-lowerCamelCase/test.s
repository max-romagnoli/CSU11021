  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test
  .global originalString
  .global newString

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Set R1 to the start address of the test string
  LDR   R0, =newString
  LDR   R1, =originalString
  BX    LR


  .section  .rodata

originalString:
  .asciz  "     TRINITY      COLLEGE      DUBLIN...  "


  .section  .data

newString:
  .space  256


.end