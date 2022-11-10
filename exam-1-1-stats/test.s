  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Init_Test


  .section  .text

  .type     Init_Test, %function
Init_Test:
  LDR   R2, =sequence     @ set start address of sequence
  bx    lr


@
@ Below is a sample sequence that you can modify to test different
@   features of your program
@
@ Remember: the sequence is stored in memory as the size (number of)
@   elements, followed by the elements themselves. In the example
@   below, the size is 10 and the elememts are
@   {5, 1, 9, 7, 4, 4, 8, 4, 5, 3}
@

  .section  .rodata

sequence:
  .word  10                             @ size
  .word  5, 1, 9, 7, 4, 4, 8, 4, 5, 3   @ values

  @
  @ For the above test sequence, the average is 5 and
  @   the mode is 4.
  @ 

.end