  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Init_Test

  .section  .text
  .type     Init_Test, %function
Init_Test:
  @ R0 will contain decimal
  @ 2034 (base 10 / decimal)
  @ subtract hex 30 from each of the four SCII codes
  @ but it has to flexible based on the base !! in R5
  @ write if statement

  LDR   R1, ='4'    @ '4' = 0x34
  LDR   R2, ='A'    @ '3' = 0x33
  LDR   R3, ='1'    @ '0' = 0x30
  LDR   R4, ='0'    @ '2' = 0x32

  LDR   R5, =16     @ x

  /* LDR   R6, =1000
  LDR   R7, =100
  LDR   R8, =10 */

  bx    lr

.end