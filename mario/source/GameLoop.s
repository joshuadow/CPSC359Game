.section    .init
.globl     _GameLoop

_GameLoop:
    b GameLoop

.section .text

GameLoop:
	push {r4-r10,lr}
restart:
	//reste all game object values to what they were initially, then call the initialize function in drawing functions
.globl GL
GL:	mov r7, #0                  //move 0 into register r7
    bl _ReadSNES                //call to subroutine which reads info from controller
loop:
    cmp r7, #15                 //check to see if we have read all the bits in the buffer
    bge GL                      //if true then reset and look for more info from the controller
    ldr r5, =buttons            //load the address of the buffer into r5
    ldrb r4, [r5, r7]           //load a byte from the buffer
    add r7, r7, #1              //increment the offset
    cmp r4, #1                  //if a 1 is ever read (button not pressed) skip over it
    beq loop                    //if true branch to loop
    bl _UpdateSprites
    //bl _updateScore
    //ldr r5, =score
    //ldrb r4, [r5]
    //cmp r4, #0
    //beq loseScreen
    //cmp r4, #7
    //beq winscreen
    //cmp r4, #0
    //bgt GL
    pop {r4-r10,lr}
    bx lr
