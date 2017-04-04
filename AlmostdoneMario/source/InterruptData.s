.section    .text
.globl InstallIntTable


InstallIntTable:
	ldr		r0, =IntTable
	mov		r1, #0x00000000
	ldmia	r0!, {r2-r9}	// load the first 8 words and store at the 0 address
	stmia	r1!, {r2-r9}
	ldmia	r0!, {r2-r9}	// load the second 8 words and store at the next address
	stmia	r1!, {r2-r9}
	mov		r0, #0xD2		// switch to IRQ mode and set stack pointer
	msr		cpsr_c, r0
	mov		sp, #0x8000
	mov		r0, #0xD3		// switch back to Supervisor mode, set the stack pointer
	msr		cpsr_c, r0
	mov		sp, #0x8000000
	bx		lr
.globl Something
Something:
    push {r4-r10,lr}
    ldr r0, =0x3F003010
    ldr r4, =0x1F78A40  
    ldr r2, =0x3F003004
    ldr r3, [r2]
    add r1, r3, r4
    str r1, [r0]

	ldr	r0, =0x3F00B210		//Enable clock IRQ interupts
	ldr r1, =0x2			//Enable bit 1 for c1 interupts
	str	r1, [r0]			//And store it back
    ldr r0, =0x3F00B214
    mov r1, #0
    str r1, [r0]
	mrs	r0, cpsr 			//Enable IRQ interupts
	bic	r0, #0x80
	msr	cpsr_c, r0
    pop {r4-r10,lr}
    bx lr



.globl irq
irq:
    push {r0-r12,lr}
    ldr r0, =valuePack
    ldr r0, [r0,#8]
    cmp r0, #0
    beq irqEnd
    ldr r0, =0x3F00B204
    ldr r1, [r0]
    and r2, r1, #2
    cmp r2, #0
    beq irqEnd
    ldr r0, =pauseState
    ldr r4, [r0]
    cmp r4, #1
    beq irqEnd
    ldr r0, =playingstatus
    ldr r0, [r0]
    cmp r0, #1
    beq irqEnd
    bl drawValuePack

irqEnd:
    ldr r0, =valuePack
    mov r1, #1
    str r1, [r0,#8]
    ldr r0, =0x3F003000
    mov r1, #2
    str r1, [r0]
    bl Something
    pop {r0-r12, lr}
    subs pc, lr, #4

noInt1:
    subs pc, lr, #0
noInt2:
    subs pc, lr, #0
noInt3:
    subs pc, lr, #4
noInt4:
    subs pc, lr, #8
noInt5:
    subs pc, lr, #0


.section    .data
.align
.globl IntTable
IntTable:
	ldr		pc, reset_handler
	ldr		pc, undefined_handler
	ldr		pc, swi_handler
	ldr		pc, prefetch_handler
	ldr		pc, data_handler
	ldr		pc, unused_handler
	ldr		pc, irq_handler
	ldr		pc, fiq_handler

reset_handler:		.word InstallIntTable
undefined_handler:	.word noInt1
swi_handler:		.word noInt2
prefetch_handler:	.word noInt3
data_handler:		.word noInt4
unused_handler:		.word noInt5
irq_handler:		.word irq
fiq_handler:		.word 
.align
