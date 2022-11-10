  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  
  @ Follow the instructions in the handout for Assignment 7

  MOV     R3, #0            @ counter = 1
  MOV     R5, #0            @ isFirstWord = FALSE
  LDRB    R2, [R1]          @ char = byte[address]
While:                      @ while (char != 0)
  CMP     R2, #0            @ {
  BEQ     EndWhile          @
Lower1:                     @   if (char >= a && char <= z)  
  CMP     R2, #'a'          @   {
  BLO     Upper1            @
  CMP     R2, #'z'          @
  BHI     Upper1            @
  STRB    R2, [R0]          @     byte[address] = char
  MOV     R5, #1            @     isFirstWord = TRUE
  B       EndSubWh          @   }
Upper1:                     @   else if (char >= A && char <= Z)
  CMP     R2, #'A'          @   {
  BLO     FirstWord         @
  CMP     R2, #'Z'          @
  BHI     FirstWord         @
  ADD     R2, R2, #0x20     @     char = char - 0x30
  STRB    R2, [R0]          @     byte[newAddress] = char
  MOV     R5, #1            @     isFirstWord = TRUE
  B       EndSubWh          @   }
FirstWord:                  @
  CMP     R5, #0            @   else if (isFirstWord == FALSE)
  BNE     Else1             @   {
  SUB     R0, R0, #1        @     newAddress = newAddress - 1
  B       EndSubWh          @   }
Else1:                      @   else
  MOV     R4, #0            @   {
SubWhile:                   @     while (char != 0 || isNewWord == FALSE)  
                            @     {
  ADD     R1, R1, #1        @       address = address + 1  
  ADD     R3, R3, #1        @       counter = counter + 1
  LDRB    R2, [R1]          @       char = byte[address]
Ending:                     @      
  CMP     R2, #0            @       
  BEQ     EndWhile          @ 
  CMP     R4, #0            @ 
  BNE     EndSubWh          @ 
If:                         @       if (counter > 0)
  CMP     R3, #0            @       {
  BLS     SubWhile          @       
Lower2:                     @         if (char >= a && char <= z)
  CMP     R2, #'a'          @         {
  BLO     Upper2            @ 
  CMP     R2, #'z'          @ 
  BHI     Upper2            @ 
  SUB     R2, R2, #0x20     @           char = char - 0x20     
  STRB    R2, [R0]          @           byte[newAddress] = char
  MOV     R4, #1            @           isNewWord = TRUE
  B       EndSubWh          @         }
Upper2:                     @         else if (char >= A && char <= Z)
  CMP     R2, #'A'          @         {
  BLO     Else2             @             
  CMP     R2, #'Z'          @ 
  BHI     Else2             @ 
  STRB    R2, [R0]          @           byte[newAddress] = char
  MOV     R4, #1            @           isNewWord = TRUE
  B       EndSubWh          @         }
Else2:                      @         
  B       SubWhile          @        
EndSubWh:                   @       }
  ADD     R1, R1, #1        @       address = address + 1
  LDRB    R2, [R1]          @       char = byte[newAddress]
  ADD     R0, R0, #1        @       newAddress = newAddress + 1
  B       While             @     }   
                            @   }  
EndWhile:                   @ }
  MOV     R1, #0            @ address = 0
  STRB    R1, [R0]          @ byte[newAddress] = address

  @ End of program ... check your result


End_Main:
  BX    lr
