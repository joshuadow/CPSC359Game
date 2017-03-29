.section        .init

.globl  Detect1

.section        .text

Detect1:

    push {r4-r10, lr}
    ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    add r6, r4, #41
    add r7, r5, #70
                                        //THIS IS JUST A NOTE THIS SAVE IS GOOD FOR NOW
                                        //MARIO DISAPPEARS ON TOP OF BLOCKS, MUST FIX

Enemy:
	ldr r0, =shellEnemy
	ldr r8, [r0]
	ldr r9, [r0,#4]
	add r9, r9, #2
	add r1, r8, #31
	add r2, r9, #50 
	cmp r6, r8
	ble Above
	cmp r4, r1
	bge Above
	cmp r7, r9
	ble MK
	ldr r1, =lives
	ldr r0, [r1]
	sub r0, r0, #1
	str r0, [r1]
	b restart

MK:
	cmp r7, r9
	blt Above
    ldr r0, =shelllife
    mov r1, #1
    str r1, [r0]
	ldr r0, =shellEnemy
	ldr r1, [r0, #4]
	ldr r0, [r0]
	bl clearShell
	ldr r1, =score
	ldr r0, [r1]
	add r0, r0, #100
	str r0, [r1]
	pop {r4-r10, lr}
	mov pc, lr

Above:
	ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    add r6, r4, #41
    add r7, r5, #70
    ldr r0, =0x14B
	cmp r5, r0
	bgt Under
	ldr r0, =0x253 //Was 262
	cmp r6, r0
	blt Under
	ldr r0, =0x2F8 //was 2E9
	cmp r4, r0
	bgt Under
	ldr r0, =0x10F
    mov r9, r5
	cmp r5, r0
	beq AboveDown
    ldr r0, =0x14B
    cmp r5, r0
    bl drawMario
    ldr r0, =js1
    mov r1, #1
    str r1, [r0]
    pop {r4-r10, lr}
    mov r0, #13
    mov pc, lr
	

AboveDown:

	add r9, r9, #12
	bl clearMario
	ldr r0, =mario
	str r9, [r0,#4]
	bl drawMario
	ldr r0, =0x14B
	cmp r9, r0
	blt AboveDown
    ldr r0, =js1
    mov r1, #1
    str r1, [r0]
    pop {r4-r10, lr}
    mov r0, #13
    mov pc, lr

AboveDone:
	ldr r0, =js1
	ldr r1, [r0]
	mov r1, #1
	str r1, [r0]
	pop {r4-r10, lr}
	mov r0, #13
	mov pc, lr
	
Under:
	ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    add r6, r4, #41
    add r7, r5, #70
    ldr r0, =0x14B
	cmp r5, r0
	bgt UnderBlock1
    mov r9, r5
UnderDown:
	add r9, r9, #12
	bl clearMario
	ldr r0, =mario
	str r9, [r0,#4]
	bl drawMario
	ldr r0, =0x1E7
	cmp r9, r0
	blt UnderDown
    ldr r0, =js1
    mov r1, #1
    str r1, [r0]
    pop {r4-r10, lr}
    mov r0, #13
    mov pc, lr
UnderBlock1:
	ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    add r6, r4, #41
    add r7, r5, #70
    add r10, r4, #20
    ldr r0, =0x262
	cmp r10, r0 //middlex = marioleft + marioright / 2
	blt UnderDone
	ldr r0, =0x28F
	cmp r10, r0
	bgt UnderBlock2
	ldr r0, =0x1C3
	cmp r5, r0
	bgt UnderDone
    ldr r0, =block1state
    ldr r0, [r0]
    cmp r0, #1
    beq UnderDone
	ldr r0, =0x262
	ldr r1, =0x190
	bl clearBox
BP123:
    ldr r0, =block1state
    mov r1, #1
    str r1, [r0]
	ldr r0, =score
	ldr r1, [r0]
	add r1, r1, #50
	str r1, [r0]
    mov r9, r5
Block1Loop:
	add r9, r9, #12
	bl clearMario
	ldr r0, =mario
	str r9, [r0,#4]
	bl drawMario
	ldr r0, =0x1E7
	cmp r9, r0
	blt Block1Loop
    ldr r0, =js1
    mov r1, #1
    str r1, [r0]
    pop {r4-r10, lr}
    mov r0, #13
    mov pc, lr

UnderBlock2:
	ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    add r6, r4, #41
    add r7, r5, #70
    add r10, r4, #20
    ldr r0, =0x28F
	cmp r10, r0 //middlex = marioleft + marioright / 2
	blt UnderBlock1
	ldr r0, =0x2BC
	cmp r10, r0
	bgt UnderBlock3
	ldr r0, =0x1C3 //was 1B7
	cmp r5, r0
	bne UnderDone
	ldr r0, =0x28F
	ldr r1, =0x190
	bl drawBlock
	ldr r0, =score
	ldr r1, [r0]
	add r1, r1, #50
	str r1, [r0]
    mov r9, r5
Block2Loop:
	add r9, r9, #12
	bl clearMario
	ldr r0, =mario
	str r9, [r0,#4]
	bl drawMario
	ldr r0, =0x1E7
	cmp r9, r0
	blt Block2Loop
    ldr r0, =js1
    mov r1, #1
    str r1, [r0]
    pop {r4-r10, lr}
    mov r0, #13
    mov pc, lr

UnderBlock3:
	ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    add r6, r4, #41
    add r7, r5, #70
    add r10, r4, #20
    ldr r0, =0x2BC
	cmp r10, r0 //middlex = marioleft + marioright / 2
	blt UnderBlock2
	ldr r0, =0x2E9
	cmp r10, r0
	bgt UnderDone
	ldr r0, =0x1C3
	cmp r5, r0
	bne UnderDone
	ldr r0, =0x2BC
	ldr r1, =0x190
	bl clearBox
	ldr r0, =score
	ldr r1, [r0]
	add r1, r1, #50
	str r1, [r0]
    mov r9, r5
Block3Loop:
	add r9, r9, #12
	bl clearMario
	ldr r0, =mario
	str r9, [r0,#4]
	bl drawMario
	ldr r0, =0x1E7
	cmp r9, r0
	blt Block3Loop
    ldr r0, =js1
    mov r1, #1
    str r1, [r0]
    pop {r4-r10, lr}
    mov r0, #13
    mov pc, lr
	
UnderDone:
	pop {r4-r10, lr}
	ldr r0, =js1
	ldr r1, [r0]
	mov r1, #0
	str r1, [r0]
	mov r0, #0
	mov pc, lr

.section .data
.align 2


block1state:    .int 0

block2state:    .int 0
