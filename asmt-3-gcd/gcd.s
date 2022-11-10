  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  
  @ Follow the instructions in the handout for Assignment 3

If:                   @ if 
  CMP   R3, R2        @ (a ≥ b)
  BLO   EndIf         @ {
  MOV   R13, R3       @ tmp = a
  MOV   R3, R2        @ a = b
  MOV   R2, R13       @ b = tmp
EndIf:                @ }


While:                @ while
  CMP   R3, #0        @ (b != 0)
  BEQ   EndWh         @ {
  Modulus:            @   while
    CMP   R2, R3      @   (a > b)  
    BLO   EndMod      @   {
    SUB   R2, R2, R3  @   a = a - b
    B     Modulus     @   }
EndMod:              
  MOV   R12, R3       @ tmp = b
  MOV   R3, R2        @ b = a
  MOV   R2, R12       @ a = tmp 
  B     While         @ 
EndWh:                @ }

  MOV   R0, R2        @ gdc = a

  @ End of program ... check your result

End_Main:
  BX    lr
