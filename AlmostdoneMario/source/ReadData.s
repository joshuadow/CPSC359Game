.section	.init
.globl	_ReadData

.section	.text
_ReadData:
	push {r4-r10, lr}
	b ReadData

ReadData:
    mov r0, #10                 //we are dealing with pin 10
    ldr r2, =0x3F200000         //move the base GPIO address into r2
    ldr r1, [r2, #52]           //load GPLEV0 into r1
    mov r3, #1                  //move 1 into r3
    lsl r3, r0                  //allight value to the position of bit 10
    and r1, r3                  //apply bitmask to others bits
    teq r1, #0                  //test if the value of pin 10 is 0
    moveq r0, #0                //return that value read was 0
    movne r0, #1                //return that value read was 1
    pop {r4-r10, lr}
    bx lr
