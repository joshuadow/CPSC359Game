.section	.init
.globl	_WriteClock

.section	.text
_WriteClock:
	push {r4-r10, lr}
	mov r4, r1
	b WriteClock


WriteClock:
	mov r0, #11                 //we are dealing with pin 11
    ldr r2, =0x3F200000         //the base GPIO address to use
    mov r3, #1                  //write a bit
    lsl r3, r0                  //align bit to pin #11
    teq r4, #0                  //test what bit we want to write
    streq r3, [r2, #40]         //write 1 to GPCLR0
    strne r3, [r2, #28]         //write 1 to GPSET0
    pop {r4-r10, lr}
    bx lr