.section    .init
.globl     _start

_start:
    b main

.section .text
main:
    mov	sp, #0x8000         // Initializing the stack pointer
    bl	EnableJTAG          // Enable JTAG
    //bl	InstallIntTable
	ldr	r0, =0x2000B218
	ldr	r1, [r0]
	orr	r1, #1
	str	r1, [r0]
	ldr		r0, =0x20003000	// clear bit in the event detect register
	mov		r1, #0x002
	str		r1, [r0]
	ldr	r0, =0x2000B210		//Enable clock IRQ interupts
	ldr	r1, [r0]			//The contents into r1
	orr	r1, #2				//Enable bit 1 for c1 interupts
	str	r1, [r0]			//And store it back
	mrs	r0, cpsr 			//Enable IRQ interupts
	bic	r0, #0x80
	msr	cpsr_c, r0
    bl 	_InitAll
    bl 	_StartScreen
.globl nG
nG: bl 	initialscreen

cycle:
    bl 	_GameLoop
    b cycle


Quit:



//InstallIntTable:
//	ldr		r0, =IntTable
//	mov		r1, #0x00000000
//	ldmia	r0!, {r2-r9}	// load the first 8 words and store at the 0 address
//	stmia	r1!, {r2-r9}
//	ldmia	r0!, {r2-r9}	// load the second 8 words and store at the next address
//	stmia	r1!, {r2-r9}
//	mov		r0, #0xD2		// switch to IRQ mode and set stack pointer
//	msr		cpsr_c, r0
//	mov		sp, #0x8000
//	mov		r0, #0xD3		// switch back to Supervisor mode, set the stack pointer
//	msr		cpsr_c, r0
//	mov		sp, #0x8000000
//	bx		lr

.globl hang
hang:
	b hang



.section	.data

.globl buttons
buttons:
	.byte 16
	.rept 1
	.endr





.globl mariowidth
mariowidth:
		.int 67
.global marioheight
marioheight:
		.int 117
//IntTable:
//	ldr		pc, reset_handler
//	ldr		pc, undefined_handler
//	ldr		pc, swi_handler
//	ldr		pc, prefetch_handler
//	ldr		pc, data_handler
//	ldr		pc, unused_handler
//	ldr		pc, irq_handler
//	ldr		pc, fiq_handler

//reset_handler:		.word InstallIntTable
//undefined_handler:	.word hang
//swi_handler:		.word hang
//prefetch_handler:	.word hang
//data_handler:		.word hang
//unused_handler:		.word hang
//irq_handler:		.word irq
//fiq_handler:		.word hang
