.section        .init

.globl marioFallDown

.section    .text

marioFallDown:
    push {r4-r10, lr}
    ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    add r6, r4, #41
    add r7, r5, #70
    add r10, r4, #20
    ldr r0, =0x262
	cmp r10, r0
	blt mfDone
	ldr r0, =0x28F
	cmp r10, r0
	bgt fallDown2
    ldr r0, =0x14B
    cmp r5, r0
    bgt mfDone
    ldr r8, =state1
    ldr r8, [r8]
    cmp r8, #17
    bne mfDone
    mov r9, r5
fallDown:
    add r9, r9, #12
	bl clearMario
	ldr r0, =mario
	str r9, [r0,#4]
	bl drawMario
	ldr r0, =0x1E7
    bl _ReadSNES
    ldr r0, =buttons
    ldrb r1, [r0, #7]
    cmp r1, #0
    bleq UpRightPress
    ldr r0, =buttons
    ldrb r1, [r0, #6]
    cmp r1, #0
    bleq UpLeftPress
	ldr r0, =0x1E7
	cmp r9, r0
	blt fallDown
    b mfDone
fallDown2:
    ldr r0, =0x28F
    cmp r10, r0
    blt marioFallDown
    ldr r0, =0x2BC
    cmp r10, r0
    bgt fallDown3
    ldr r0, =0x14B
    bgt mfDone
    ldr r8, =state2
    ldr r8, [r8]
    cmp r8, #17
    bne mfDone
    mov r9, r5
f2l:
    add r9, r9, #12
	bl clearMario
	ldr r0, =mario
	str r9, [r0,#4]
	bl drawMario
	ldr r0, =0x1E7
    bl _ReadSNES
    ldr r0, =buttons
    ldrb r1, [r0, #7]
    cmp r1, #0
    bleq UpRightPress
    ldr r0, =buttons
    ldrb r1, [r0, #6]
    cmp r1, #0
    bleq UpLeftPress
	ldr r0, =0x1E7
	cmp r9, r0
	blt f2l    
    b mfDone
fallDown3:
    ldr r0, =0x2BC
    cmp r10, r0
    blt marioFallDown
    ldr r0, =0x2E9
    cmp r10, r0
    bgt fallDown3
    ldr r0, =0x14B
    bgt mfDone
    ldr r8, =state2
    ldr r8, [r8]
    cmp r8, #17
    bne mfDone
    mov r9, r5

f3l:
    add r9, r9, #12
	bl clearMario
	ldr r0, =mario
	str r9, [r0,#4]
	bl drawMario
	ldr r0, =0x1E7
    bl _ReadSNES
    ldr r0, =buttons
    ldrb r1, [r0, #7]
    cmp r1, #0
    bleq UpRightPress
    ldr r0, =buttons
    ldrb r1, [r0, #6]
    cmp r1, #0
    bleq UpLeftPress
	ldr r0, =0x1E7
	cmp r9, r0
	blt f3l   
    b mfDone 


mfDone:
    pop {r4-r10, lr}
    mov pc ,lr
