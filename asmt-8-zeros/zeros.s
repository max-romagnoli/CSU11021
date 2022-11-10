  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  
  @ Follow the instructions in the handout for Assignment 8
  MOV     R0, #0              @ longestSequence = 0
  MOV     R3, #0              @ i = 0
  MOV     R4, #0              @ zeroCounter = 0
                              @
While:                        @ while (i < 32)
  CMP     R3, #32             @ {
  BHS     EndWh               @
  MOVS    R1, R1, LSL #1      @   shift left[1] and set C
  BCS     ElseIf              @   if (C == 0) {
  ADD     R4, R4, #1          @     zeroCounter ++  
  B       EndIf               @   }
ElseIf:                       @   else if (zeroCounter > longestSequence)
  CMP     R4, R0              @   {
  BLS     Else                @   
  MOV     R0, R4              @     longestSequence = zeroCounter
  MOV     R4, #0              @     zeroCounter = 0                     
  B       EndIf               @   }
Else:                         @   else {
  MOV     R4, #0              @     zeroCounter = 0
EndIf:                        @   }
  ADD     R3, R3, #1          @   i++
  B       While               @ 
EndWh:                        @ }
                              @
  CMP     R4, R0              @ if (zeroCounter > longestSequence)
  BLS     End                 @ {
  MOV     R0, R4              @   longestSequence = zeroCounter
End:                          @ }

  
  
  @ End of program ... check your result

End_Main:
  BX    lr
