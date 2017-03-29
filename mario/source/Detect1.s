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
    add r10, r4, #20    
Enemy:
    ldr r0, =shellEnemy
    ldr r0, [r0, #8]
    cmp r0, #1
    beq Block1
	ldr r0, =shellEnemy
	ldr r8, [r0]
	ldr r9, [r0,#4]
    sub r8, r8, #2
	add r9, r9, #2
	add r1, r8, #31
	add r2, r9, #52 
	cmp r6, r8
	blt s1done
	cmp r4, r1
	bgt Block1
	cmp r7, r9
	ble MK
	ldr r1, =lives
	ldr r0, [r1]
	sub r0, r0, #1
	str r0, [r1]
	b restart
MK:
	cmp r7, r9
	blt Block1
    ldr r0, =shellEnemy
    mov r1, #1
    str r1, [r0,#8]
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

Block1:
    ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    add r6, r4, #41
    add r7, r5, #70
    add r10, r4, #20
    ldr r0, =0x262 //Left side of block
    cmp r6, r0      
    blt s1done //
    ldr r0, =0x28F
    cmp r4, r0
    bgt Block2
    ldr r0, =state1
    ldrb r0, [r0]
    cmp r0, #1
    bne s1done
    ldr r0, =0x1B7
    cmp r5, r0
    bge Block1Under
    b Block1Above

Block1Above:
    bl drawMario
    ldr r0, =state1
    ldrb r0, [r0]
    cmp r0, #1
    bne BlockGround
    ldr r0, =0x10F
    cmp r5, r0
    beq BlockBlock
    ldr r0, =0x14B
    cmp r5, r0
    blt s1done
    
B1EQ:
    ldr r0, =js1
    mov r1, #1
    str r1, [r0]
    pop {r4-r10, lr}
    mov r0, #13
    mov pc, lr    
    


Block1Under:

    ldr r10, =state1
    ldrb r0, [r10]
    cmp r0, #0
    beq s1done
    ldr r0, =0x1B7
    cmp r5, r0
    beq undernext
    ldr r0, =js1
    mov r1, #1
    str r1, [r0]
    pop {r4-r10, lr}
    mov r0, #0
    mov pc, lr       

undernext:
    ldr r0, =0x262
    ldr r1, =0x190
    bl clearBox
    ldr r0, =state1
    mov r1, #0
    str r1, [r0]
    ldr r0, =score
    ldr r1, [r0]
    add r1, r1, #50
    str r1, [r0]
    b BlockGround


Block2:
    ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    add r6, r4, #41
    add r7, r5, #70
    add r10, r4, #20
    ldr r0, =0x28F //Left side of block
    cmp r6, r0      
    blt Block1
    ldr r0, =0x2BC
    cmp r4, r0
    //bgt Block3
    ldr r0, =state2
    ldrb r0, [r0]
    cmp r0, #1
    bne s1done
    ldr r0, =0x1B7
    cmp r5, r0
    bge Block2Under
    b Block2Above 

Block2Above:
    ldr r0, =state2
    ldrb r0, [r0]
    cmp r0, #1
    bne BlockGround
    ldr r0, =0x11B
    cmp r5, r0
    beq BlockBlock
B2Al:
    ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    mov r9, r5
B2ALoop:
    add r9, r9, #12
    bl clearMario
    ldr r0, =mario
    str r9, [r0,#4]
    bl drawMario
    bl _ReadSNES
    ldr r0, =buttons
    ldrb r1, [r0, #7]
    cmp r1, #0
    bleq UpRightPress
    ldr r0, =buttons
    ldrb r1, [r0, #6]
    cmp r1, #0
    bleq UpLeftPress
    bl Detect1
    ldr r0, =0x13F
    cmp r9, r0
    blt B2ALoop
    ldr r0, =js1
    mov r1, #1
    str r1, [r0]
    pop {r4-r10, lr}
    mov r0, #13
    mov pc, lr    
    


Block2Under:

    ldr r10, =state2
    ldrb r0, [r10]
    cmp r0, #0
    beq s1done
    ldr r0, =0x1B7
    cmp r5, r0
    beq undernext2
    ldr r0, =js1
    mov r1, #1
    str r1, [r0]
    pop {r4-r10, lr}
    mov r0, #0
    mov pc, lr       

undernext2:
    ldr r0, =0x28F
    ldr r1, =0x190
    bl clearBox
    ldr r0, =state2
    mov r1, #0
    str r1, [r0]
    ldr r0, =score
    ldr r1, [r0]
    add r1, r1, #50
    str r1, [r0]
    b BlockGround   

BlockBlock:
    ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    mov r9, r5
B1BLoop:
    add r9, r9, #24
    bl clearMario
    ldr r0, =mario
    str r9, [r0,#4]
    bl drawMario
    bl _ReadSNES
    ldr r0, =buttons
    ldrb r1, [r0, #7]
    cmp r1, #0
    bleq UpRightPress
    ldr r0, =buttons
    ldrb r1, [r0, #6]
    cmp r1, #0
    bleq UpLeftPress
    bl Detect1
    ldr r0, =0x14B
    cmp r9, r0
    blt B1BLoop
    ldr r0, =js1
    mov r1, #1
    str r1, [r0]
    pop {r4-r10, lr}
    mov r0, #13
    mov pc, lr    


BlockGround:
    ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    mov r9, r5
    ldr r0, =js1
    mov r1, #0
    str r1, [r0]
    pop {r4-r10, lr}
    mov r0, #13
    mov pc, lr





s1done:
    ldr r0, =js1
    mov r1, #0
    str r1, [r0]
    pop {r4-r10, lr}
    mov r0, #0
    mov pc, lr       
.section .data
.align 4

.globl state1
state1: .int 1
.globl state2
state2: .int 1
.globl state3
state3: .int 1
