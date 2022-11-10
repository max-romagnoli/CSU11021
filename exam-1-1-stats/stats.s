  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:


  LDR     R0, =0        @ average = 0
  LDR     R1, =0        @ currentMean = 0
  LDR     R6, =0        @ currentAppearances = 0
  LDR     R7, =0        @ sum = 0
  LDR     R8, [R2]      @ count = word[address]
  ADD     R2, R2, #4    @ address = address + 4
  MOV     R11, R2       @ cmpAddress = address
  MOV     R12, R2       @ initialAddress = address
IfZero:                 @
  CMP     R8, #0        @ if (count != 0)
  BEQ     EndProgram    @ {
  MOV     R10, R8       @   tmpCount = count
While:                  @   while (count > 0)
  CMP     R8, #0        @   {
  BLS     EndWhile      @
  MOV     R9, R10       @     innerCount = tmpCount     
  LDR     R3, [R2]      @     value = word[address]
IfMean:                 @     if (value != currentMean)
  CMP     R3, R1        @     {
  BEQ     EndIfMean     @    
  MOV     R11, R12      @       cmpAddress = initialAddress   
  MOV     R5, #1        @       appearances = 1
WhileCmp:               @       while (innerCount > 0)
  CMP     R9, #0        @       {
  BLS     EndCmp        @       
  LDR     R4, [R11]     @         cmpValue = word[cmpAddress]
IfEq:                   @         if (value = cmpValue)
  CMP     R3, R4        @         {
  BNE     EndEq         @
  ADD     R5, R5, #1    @           appearances = appearances + 1  
EndEq:                  @         }
  ADD     R11, R11, #4  @         cmpAddress = cmpAddress + 4
  SUB     R9, R9, #1    @         innerCount = innerCount - 1
  B       WhileCmp      @
EndCmp:                 @       }
SetMean:                @       if (apperances > currentAppearances)
  CMP     R5, R6        @       {
  BLS     EndSetMean    @         
  MOV     R1, R3        @         currentMean = value
  MOV     R6, R5        @         appearances = currentAppearances
EndSetMean:             @       }
EndIfMean:              @     }
  ADD     R7, R7, R3    @       sum = sum + value
  SUB     R8, R8, #1    @     count = count - 1
  ADD     R2, R2, #4    @     address = address + 4
  B       While         @
EndWhile:               @   }
  UDIV    R0, R7, R10   @   average = sum / tmpCount
EndProgram:             @ }



End_Main:
  BX    lr
