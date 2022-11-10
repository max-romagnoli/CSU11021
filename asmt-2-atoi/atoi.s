  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  
  @ Follow the instructions in the handout for Assignment 2

Hex1:  
  CMP   R1, #0x40
  BHI   Letter1
  SUB   R1, R1, #0x30
  B     End1
Letter1:
  SUB   R1, R1, #55
End1:

Hex2:  
  CMP   R2, #0x40
  BHI   Letter2
  SUB   R2, R2, #0x30
  B     End2
Letter2:
  SUB   R2, R2, #55
End2:

Hex3:  
  CMP   R3, #0x40
  BHI   Letter3
  SUB   R3, R3, #0x30
  B     End3
Letter3:
  SUB   R3, R3, #55
End3:

Hex4:  
  CMP   R4, #0x40
  BHI   Letter4
  SUB   R4, R4, #0x30
  B     End4
Letter4:
  SUB   R4, R4, #55
End4:

If:                     
  CMP   R12, #0        
  BNE   ElseIf1         
  LDR   R6, =1         
  ADD   R12, R12, #1
  MUL   R1, R1, R6
  B     If
ElseIf1: 
  CMP   R12, #1
  BNE   ElseIf2
  MUL   R6, R6, R5
  ADD   R12, R12, #1
  MUL   R2, R2, R6
  B     ElseIf1
ElseIf2: 
  CMP   R12, #2
  BNE   ElseIf3
  MUL   R6, R6, R5
  ADD   R12, R12, #1
  MUL   R3, R3, R6
  B     ElseIf2
ElseIf3: 
  CMP   R12, #3
  BNE   EndIf
  MUL   R6, R6, R5
  ADD   R12, R12, #1
  MUL   R4, R4, R6
  B     ElseIf3
EndIf: 
  
  MOV   R0, R1
  ADD   R0, R0, R2
  ADD   R0, R0, R3
  ADD   R0, R0, R4
  
  @ End of program ... check your result

End_Main:
  BX    lr
