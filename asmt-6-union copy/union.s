  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  
  @ Follow the instructions in the handout for Assignment 6

  LDR    R5, =0       @ size = 0
  LDR    R6, =0       @ isEqual = FALSE

  MOV    R10, R0      @ tmpC = addressC
  ADD    R0, R0, #4   @ addressC = addressC + 4
  MOV    R11, R1      @ tmpA = addressA
  MOV    R12, R2      @ tmpB = addressB

  LDR    R3, [R1]     @ entryA = word[addressA]
While1:               @ while (entryA != 0)
  CMP    R3, #0       @ {
  BEQ    EndWh1       @
  LDR    R4, [R2]     @   entryB = word[addressB] 
SubWhile1:            @   while (entryB != 0 && !isEqual)
  CMP    R4, #0       @   {
  BEQ    EndSub1      @
  CMP    R6, #0       @
  BNE    EndSub1      @
IfEqual1:             @     if (entryA == entryB)
  CMP    R3, R4       @     {
  BNE    EndEqual1    @
  MOV    R6, #1       @       isEqual = TRUE
EndEqual1:            @     }
  ADD    R2, R2, #4   @     addressB = addressB + 4
  LDR    R4, [R2]     @     entryB = word[addressB]
  B      SubWhile1    @   
EndSub1:              @   }
IfUnique1:            @   if (!isEqual)
  CMP    R6, #0       @   {
  BNE    EndUnique1   @
  STR    R3, [R0]     @     word[addressC] = entryA
  ADD    R0, R0, #4   @     addressC = addressC + 4
  ADD    R5, R5, #1   @     size = size + 1
EndUnique1:           @   }
  ADD    R1, R1, #4   @   addressA = addressA + 4
  LDR    R3, [R1]     @   entryA = word[addressA]
  MOV    R2, R12      @   addressB = tmpB
  B      While1       @
EndWh1:               @ }
                      
  LDR    R6, =0       @ isEqual = FALSE 
  MOV    R1, R11      @ addressA = tmpA
 
                      
  LDR    R4, [R2]     @ entryB = word[addressB]
While2:               @ while (entryB != 0)
  CMP    R4, #0       @ {
  BEQ    EndWh2       @
  LDR    R3, [R1]     @   entryA = word[addressA]
SubWhile2:            @   while (entryA != 0 && !isEqual)
  CMP    R3, #0       @   {
  BEQ    EndSub2      @
  CMP    R6, #0       @
  BNE    EndSub2      @
IfEqual2:             @     if (entryB == entryA)
  CMP    R4, R3       @     {
  BNE    EndEqual2    @
  MOV    R6, #1       @       isEqual = TRUE
EndEqual2:            @     }
  ADD    R1, R1, #4   @     addressA = addressA + 4
  LDR    R3, [R1]     @     entryA = word[addressA]
  B      SubWhile2    @   
EndSub2:              @   }
IfUnique2:            @   if (!isEqual)
  CMP    R6, #0       @   {
  BNE    EndUnique2   @
  STR    R4, [R0]     @     word[addressC] = entryB
  ADD    R5, R5, #1   @     size = size + 1
EndUnique2:           @   }
  ADD    R2, R2, #4   @   addressB = addressB + 4
  LDR    R4, [R2]     @   entryB = word[addressB]
  MOV    R1, R11      @   addressA = tmpA 
  B      While2       @
EndWh2:               @ }

  MOV    R0, R10      @ addressC = tmpC
  STR    R5, [R0]     @ word[addressC] = size

  @ End of program ... check your result


End_Main:
  BX    lr
