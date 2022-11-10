  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  
  @ Write an ARM Assembly Language program to evaluate
  @   ax^2 + bx + c for given values of a, b, c and x
  
  MUL   R5, R1, R1  @ x^2
  MUL   R5, R2, R5  @ ax^2

  MUL   R6, R3, R1  @ bx

  ADD   R0, R5, R6  @ ax^2 + bx
  ADD   R0, R0, R4  @ ax^2 + bx + c

  @ End of program ... check your result

End_Main:
  BX    lr
