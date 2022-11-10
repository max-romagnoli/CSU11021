  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  
  @ Follow the instructions in the handout for Assignment 6

  LDR     R11, [R1]           @ sizeA = word[addressA]
  ADD     R1, R1, #4          @ addressA = addressA + 4
  MOV     R8, R1              @ tmpAddressA = addressA
                              @
  LDR     R12, [R2]           @ sizeB = word[addressB]
  ADD     R2, R2, #4          @ addressB = addressB + 4
                              @
  MOV     R9, R0              @ tmpAddressC = addressC
  ADD     R0, R0, #4          @ addressC = addressC + 4
  MOV     R10, #0             @ totalSize = 0
                              @
  MOV     R6, #0              @ counterA = 0
While1:                       @ while (counterA < sizeA)
  CMP     R6, R11             @ {
  BHS     EndWhile1           @
  LDR     R3, [R1]            @   entryA = word[tmpAddressA]
  STR     R3, [R0]            @   word[addressC] = entryA
  ADD     R6, R6, #1          @   counterA ++
  ADD     R10, R10, #1        @   totalSize ++
  ADD     R1, R1, #4          @   tmpAddressA = tmpAddressA + 4 
  ADD     R0, R0, #4          @   addressC = addressC + 4  
  B       While1              @
EndWhile1:                    @ }
                              @
  MOV     R6, #0              @ counterA = 0
  MOV     R1, R8              @ addressA = tmpAddressA           
  MOV     R7, #0              @ counterB = 0
While2:                       @ while (counterB < sizeB)
  CMP     R7, R12             @ {
  BHS     EndWhile2           @
  LDR     R4, [R2]            @   entryB = word[addressB]           
While3:                       @   while (counterA < sizeA)
  CMP     R6, R11             @   {
  BHS     EndWhile3           @      
  LDR     R3, [R1]            @     entryA = word[addressA]
  ADD     R1, R1, #4          @     addressA = addressA + 4   
  ADD     R6, R6, #1          @     counterA ++
If:                           @     if (entryA == entryB)
  CMP     R3, R4              @     {
  BNE     EndIf               @    
  ADD     R2, R2, #4          @       addressB = addressB + 4
  MOV     R6, #0              @       counterA = 0
  MOV     R1, R8              @       addressA = tmpAddressA
  SUB     R12, R12, #1        @       sizeB --
  B       While2              @       
EndIf:                        @     }
  B       While3              @
EndWhile3:                    @   }
  STR     R4, [R0]            @   word[addressC] = entryB
  ADD     R7, R7, #1          @   counterB ++
  ADD     R10, R10, #1        @   totalSize ++
  ADD     R2, R2, #4          @   addressB = addressB + 4
  ADD     R0, R0, #4          @   addressC = addressC + 4
  MOV     R6, #0              @   counterA = 0
  MOV     R1, R8              @   addressA = tmpAddressA
  B       While2              @ 
EndWhile2:                    @ }
                              @
  STR     R10, [R9]           @ word[tmpAddress0] = totalSize

  @ End of program ... check your result


End_Main:
  BX    lr
