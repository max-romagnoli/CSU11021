  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  
  @ Follow the instructions in the handout for Assignment 5

If:                       @ if (number > 0)
  CMP     R1, #0          @ {
  BEQ     IfZero          @   
  BLT     IfNegative      @
  MOV     R10, #0x2B      @   tmp = 0x2B
  STRB    R10, [R0]       @   byte[address] = tmp
  ADD     R0, R0, #1      @   address = address + 1  
  B       EndIf           @ }
IfNegative:               @ else if (number < 0) {
  MOV     R10, #0x2D      @   tmp = 0x2D
  STRB    R10, [R0]       @   byte[address] = tmp    
  MOV     R10, #-1        @   tmp = -1
  MUL     R1, R1, R10     @   number = number * tmp
  ADD     R0, R0, #1      @   address = address + 1
  B       EndIf           @ }
IfZero:                   @ else {
  MOV     R10, #0x30      @   tmp = 0x30
  STRB    R10, [R0]       @   byte[address] = tmp
  ADD     R0, R0, #1      @
  B       EndWh           @ } 
EndIf:                    @ 
                          @
  MOV     R12, #0         @ count = 0
  MOV     R5, #1          @ power = 1
  MOV     R11, #10        @ n = 10
                          @
Power:                    @ while (power <= number[unsigned])
  CMP     R5, R1          @ {
  BHI     EndPow          @   
  CMP     R12, #9         @   if (count != 9)
  BEQ     IfOverflow      @   {
  MUL     R5, R5, R11     @     power = power * 10
  ADD     R12, #1         @     count = count + 1
  B       Power           @   }
EndPow:                   @ }  
  UDIV    R5, R5, R11     @ power = power / 10
  B       Start           @
IfOverflow:               @ 
  ADD     R12, #1         @ address = address + 1
                          @
Start:                    @
  MOV     R8, R0          @ tmpAddress = address
                          @
Length:                   @ while (count != 0)
  CMP     R12, #0         @ {
  BEQ     EndLeng         @
  STRB    R11, [R0]       @   byte[address] = n
  SUB     R12, R12, #1    @   count = count - 1   
  ADD     R0, R0, #1      @   address = address + 1
  B       Length          @ 
EndLeng:                  @ }
  MOV     R10, #0         @ tmp = NULL
  STRB    R10, [R0]       @ byte[address] = tmp       
                          @
  MOV     R0, R8          @ address = tmpAddress
                          @
While:                    @ while (char != 0)
                          @ { 
  LDRB    R2, [R0]        @   char = byte[address] 
  CMP     R2, #0          @
  BEQ     EndWh           @
  MOV     R6, R1          @   quotient = number
  UDIV    R6, R1, R5      @   quotient = number / power
  MUL     R10, R6, R5     @   tmp = quotient * power
  SUB     R7, R1, R10     @   remainder = number - tmp
  UDIV    R5, R5, R11     @   power = power / 10
  ADD     R3, R6, #0x30   @   ascii = quotient + 0x30
  STRB    R3, [R0]        @   byte[address] = ascii
  ADD     R0, R0, #1      @   address = address + 1
  MOV     R1, R7          @   number = remainder
  B       While           @
EndWh:                    @ }

  @ End of program ... check your result


End_Main:
  BX    lr
