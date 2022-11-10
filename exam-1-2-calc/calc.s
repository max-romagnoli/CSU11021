  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

@
@ Follow the instructions contained in the examination paper
@
  LDRB    R2, [R1]        @ char = byte[address]
  MOV     R10, #0x2B      @ sign = '+'
  MOV     R0, #0          @ total = 0

While:                    @ while (char != null)
  CMP     R2, #0          @ {
  BEQ     EndWhile        @
  MOV     R3, #10         @   base = 10
  MOV     R4, #0          @   length = 0
GetLength:                @   while (char >= '0' && char <= '9' || char >= 'A' && char <= 'F')
  CMP     R2, #0x30       @   {
  BLO     CmpLetter       @
  CMP     R2, #0x39       @
  BHI     CmpLetter       @
  B       If0             @
CmpLetter:                @
  CMP     R2, #0x41       @
  BLO     EndLength       @
  CMP     R2, #0x46       @
  BHI     EndLength       @
If0:                      @     if (char == '0')
  CMP     R2, #0x30       @     {
  BNE     Else0           @       
  ADD     R1, R1, #1      @       address = address + 1
  LDRB    R2, [R1]        @       char = byte[address]
Ifx:                      @       if (char == 'x')
  CMP     R2, #0x78       @       {
  BNE     Elsex           @
  MOV     R3, #16         @         base = 16
 //                       @         address = address + 1      
  B       EndIfx          @       }
Elsex:                    @       else {
  ADD     R4, R4, #1      @         length = length + 1
EndIfx:                   @       }
  B       EndIf0          @     }
Else0:                    @     else {
  ADD     R4, R4, #1      @       length = length + 1
EndIf0:                   @     }
  ADD     R1, R1, #1      @     address = address + 1
  LDRB    R2, [R1]        @     char = byte[address]
  B       GetLength       @
EndLength:                @   }

  MOV     R11, R1         @   lastAddress = address
  SUB     R1, R1, #1      @   address = address - 1
  LDRB    R2, [R1]        @   char = byte[address]

GetNumber:                @   while (char >= '0' && char <= '9')
  CMP     R2, #0x30       @   {
  BLO     EndNumber       @
  CMP     R2, #0x39       @
  BHI     EndNumber       @
  MOV     R5, #1          @     power = 1
  MOV     R8, #0          @     count = 0
  MOV     R6, #0          @     number = 0
AddDigit:                 @     while (count < length)
  CMP     R8, R4          @     {
  BHS     EndAddDigit     @
  LDRB    R2, [R1]        @       char = byte[address]
IfLetter:                 @       if (char < 'A')
  CMP     R2, #0x41       @       {
  BLO     EndIfLetter     @       
  SUB     R7, R2, #55     @         digit = char - 55
EndIfLetter:              @       }
  SUB     R7, R2, #48     @       digit = char - 48
  MUL     R7, R7, R5      @       digit = digit * power
  MUL     R5, R5, R3      @       power = power * base
  ADD     R6, R6, R7      @       number = number + digit
  SUB     R1, R1, #1      @       address = address - 1
  ADD     R8, R8, #1      @       count = count + 1
  B       AddDigit        @     
EndAddDigit:              @     }
IfPlus:                   @     if (sign == '+')
  CMP     R10, #0x2B      @     {
  BNE     IfMinus         @
  ADD     R0, R0, R6      @       total = total + number
  B       EndNumber       @     }
IfMinus:                  @     else if (sign == '-')
  CMP     R10, #0x2D      @     {
  BNE     IfMul           @
  SUB     R0, R0, R6      @       total = total - number
  B       EndNumber       @     }
IfMul:                    @     else
  MUL     R0, R0, R6      @       total = total * number
EndNumber:                @   }

  MOV     R1, R11         @   address = lastAddress
  LDRB    R2, [R1]        @   char = byte[address]
IfSign:
  CMP     R2, #0          @   if (char != null)
  BEQ     EndSign         @   {
  MOV     R10, R2         @     sign = char
  ADD     R1, R1, #1      @     address = address + 1
  LDRB    R2, [R1]        @     char = byte[address]
EndSign:                  @   }
  B       While           @
EndWhile:                 @ }



@

End_Main:
  BX    lr
