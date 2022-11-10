  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  
  @ Follow the instructions in the handout for Assignment 4

LDR   R0, =0                @ numberOfPrimes = 0
SUB   R2, R1, #1            @ quotient = N - 1

If0:                        @ if (N > 0)
  CMP   R1, #0              @ {
  BLS   EndIf0              @
                            @                                                      
  While:                    @   while (quotient > 1)
    CMP   R2, #1            @   {
    BLS   EndWhile          @   
    MOV   R4, #2            @     divisor = 2
    MOV   R5, #1            @     remainder = 1
    MOV   R3, R2            @     tmpQuotient = quotient
                            @ 
    SubWhile:               @     while (divisor < quotient && remainder != 0)
      CMP   R4, R2          @     {
      BHS   EndSub          @   
      CMP   R5, #0          @   
      BEQ   EndSub          @     
      UDIV  R3, R2, R4      @       tmpQuotient = quotient / divisor
      MUL   R10, R3, R4     @       tmp = tmpQuotient * divisor
      SUB   R5, R2, R10     @       remainder = quotient - tmp
      ADD   R4, R4, #1      @       divisor = divisor + 1
      B     SubWhile        @ 
    EndSub:                 @     }
                            @ 
    If:                     @     if (remainder != 0)              
      CMP   R5, #0          @     {
      BEQ   EndIf           @ 
      ADD   R0, #1          @       numberOfPrimes++
    EndIf:                  @     }  
                            @    
    SUB   R2, R2, #1        @     quotient--
    B     While             @ 
  EndWhile:                 @   }
                            @
EndIf0:                     @ }

  @ End of program ... check your result

End_Main:
  BX    lr
