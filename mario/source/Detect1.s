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
    ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    add r6, r4, #41
    add r7, r5, #70
    ldr r0, =0x1F1
	cmp r7, r0
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
    cmp r10, r0      
    blt Block1down
    ldr r0, =0x28F
    cmp r10, r0
    bgt Block2
    ldr r0, =state1
    ldrb r0, [r0]
    cmp r0, #1
    bne Block1down
    ldr r0, =0x1C9
    cmp r5, r0
    bge Block1Under
    b Block1Above
Block1down:
    ldr r0, =floor
    ldr r1, =0x1E7
    str r1, [r0]
    b s1done
Block1Above:
    bl drawMario
    ldr r0, =state1
    ldrb r0, [r0]
    cmp r0, #1
    bne Block1down
    ldr r0, =floor
    ldr r1, =0x14B
    str r1, [r0]
    b s1done
    
Block1Under:

    ldr r10, =state1
    ldrb r0, [r10]
    cmp r0, #0
    beq Block1down
    ldr r0, =0x1C9
    cmp r5, r0
    beq undernext
    pop {r4-r10, lr}
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
    ldr r0, =gravflag
    mov r1, #1
    str r1, [r0]
    b Block1down


Block2:
    ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    add r6, r4, #41
    add r7, r5, #70
    add r10, r4, #20
    ldr r0, =0x28F //Left side of block
    cmp r10, r0      
    blt Block1
    ldr r0, =0x2BC
    cmp r10, r0
    bgt Block3
    ldr r0, =state2
    ldrb r0, [r0]
    cmp r0, #0
    beq Block2down
    ldr r0, =0x1C9
    cmp r5, r0
    bge Block2Under
    b Block2Above
Block2down:
    ldr r0, =floor
    ldr r1, =0x1E7
    str r1, [r0]
    b s1done
Block2Above:
    bl drawMario
    ldr r0, =state2
    ldrb r0, [r0]
    cmp r0, #0
    beq Block2down
    ldr r0, =floor
    ldr r1, =0x14B
    str r1, [r0]
    b s1done
    
Block2Under:

    ldr r10, =state2
    ldrb r0, [r10]
    cmp r0, #0
    beq Block2down
    ldr r0, =0x1C9
    cmp r5, r0
    bne s1done
    ldr r0, =state2
    ldrb r0, [r0]
    cmp r0, #1
    beq undernext2
    cmp r0, #2
    beq undernext22   

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
    ldr r0, =gravflag
    mov r1, #1
    str r1, [r0]
    b Block2down

undernext22:
    ldr r0, =0x28F
    ldr r1, =0x190
    bl drawBlock
    ldr r0, =state2
    mov r1, #1
    str r1, [r0]
    ldr r0, =score
    ldr r1, [r0]
    add r1, r1, #50
    str r1, [r0]
    ldr r0, =gravflag
    mov r1, #1
    str r1, [r0]
    b Block2down


Block3:
    ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    add r6, r4, #41
    add r7, r5, #70
    add r10, r4, #20
    ldr r0, =0x2BC //Left side of block
    cmp r10, r0      
    blt Block2
    ldr r0, =0x2E9
    cmp r10, r0
    bgt Block3down
    ldr r0, =state3
    ldrb r0, [r0]
    cmp r0, #1
    bne Block3down
    ldr r0, =0x1C9
    cmp r5, r0
    bge Block3Under
    b Block3Above
Block3down:
    ldr r0, =floor
    ldr r1, =0x1E7
    str r1, [r0]
    b s1done
Block3Above:
    bl drawMario
    ldr r0, =state3
    ldrb r0, [r0]
    cmp r0, #1
    bne Block3down
    ldr r0, =floor
    ldr r1, =0x14B
    str r1, [r0]
    b s1done
    
Block3Under:

    ldr r10, =state3
    ldrb r0, [r10]
    cmp r0, #0
    beq Block3down
    ldr r0, =0x1C9
    cmp r5, r0
    beq undernext3
    pop {r4-r10, lr}
    mov pc, lr       

undernext3:
    ldr r0, =0x2BC
    ldr r1, =0x190
    bl clearBox
    ldr r0, =state3
    mov r1, #0
    str r1, [r0]
    ldr r0, =score
    ldr r1, [r0]
    add r1, r1, #50
    str r1, [r0]
    ldr r0, =gravflag
    mov r1, #1
    str r1, [r0]
    b Block3down



s1done:
    pop {r4-r10, lr}
    mov pc, lr 


      
.section .data
.align 4

.globl state1
state1: .int 1
.globl state2
state2: .int 2
.globl state3
state3: .int 1
.globl floor
floor:  .int 487
