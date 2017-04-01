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
  	cmp r0, #0
  	beq gameOverScreen
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
  	add r0, r0, #50
  	str r0, [r1]
  	bl updateScore
  	pop {r4-r10, lr}
  	mov pc, lr



Block1:
    ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    add r6, r4, #41
    add r7, r5, #70
    add r10, r4, #20
    ldr r0, =0x262
    cmp r6, r0
    ble b1c
    ldr r0, =state1
    ldrb r0, [r0]
    cmp r0, #0
    beq B2Head
    ldr r0, =0x2BD
    cmp r4, r0
    bge B1Head

B1Head:
    ldr r0, =0x1BD
    cmp r5, r0
    bge b1c
B1Feet:
    ldr r0, =0x190
    cmp r7, r0
    ble b1c
B1SideL:
    ldr r0, =0x14B
    cmp r5, r0
    beq b1c
    ldr r0, =0x280
    cmp r4, r0
    bge B1SideR

    ldr r0, =mario
    ldr r1, =0x238
    str r1, [r0]
    ldr r1, =0x262
    ldr r2, =0x190
    bl drawBlock
    b b1c
B1SideR:
    ldr r0, =state1
    ldrb r0, [r0]
    cmp r0, #0
    beq Block1down
    ldr r0, =0x28F
    cmp r4, r0
    bgt b1c
    ldr r0, =0x14B
    cmp r5, r0
    ble b1c
    ldr r0, =mario
    ldr r1, =0x290
    str r1, [r0]
    ldr r1, =0x262
    ldr r2, =0x190
    bl drawBlock
    b s1done
b1c:
    ldr r0, =0x262
    cmp r6, r0
    blt Block1down
    ldr r0, =0x28F
    cmp r10, r0
    bge Block2
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
    add r10, r4, #22
    ldr r0, =0x28F //Left side of block
    cmp r6, r0
    blt Block1
    ldr r0, =0x2B7
    cmp r10, r0
    bge Block3
    ldr r0, =state2
    ldrb r0, [r0]
    cmp r0, #0
    beq Block2down
    ldr r0, =0x290
    cmp r4, r0
    bge B2Head

B2Head:
    ldr r0, =0x2B7
    cmp r10, r0
    bge Block3
    ldr r0, =0x1BD
    cmp r5, r0
    bge b2c
B2Feet:
    ldr r0, =0x190
    cmp r7, r0
    ble b2c
B2SideL:
    ldr r0, =state2
    ldrb r0, [r0]
    cmp r0, #0
    beq Block2down
    ldr r0, =0x292
    cmp r6, r0
    blt Block2down
    ldr r0, =0x2BC
    cmp r4, r0
    bgt Block2down
    ldr r0, =0x14B
    cmp r5, r0
    beq Block2Above
    ldr r0, =0x290
    cmp r4, r0
    bge B2SideR

    ldr r0, =mario
    ldr r1, =0x267
    str r1, [r0]
    ldr r1, =0x28F
    ldr r2, =0x190
    ldr r0, =state2
    ldr r0, [r0]
    cmp r0, #2
    ldreq r0, =0x28F
    ldreq r1, =0x190
    bleq drawCoinBlock
    ldr r0, =state2
    ldr r0, [r0]
    cmp r0, #1
    ldreq r0, =0x28F
    ldreq r1, =0x190
    bleq drawBlock
    b b2c
B2SideR:
    ldr r0, =state2
    ldrb r0, [r0]
    cmp r0, #0
    beq Block2down
    ldr r0, =0x2BC
    cmp r4, r0
    bgt Block2down
    ldr r0, =0x14B
    cmp r5, r0
    ble Block3
    ldr r0, =mario
    ldr r1, =0x2BE
    str r1, [r0]
    ldr r0, =state2
    ldr r0, [r0]
    cmp r0, #2
    ldreq r0, =0x28F
    ldreq r1, =0x190
    bleq drawCoinBlock
    ldr r0, =state2
    ldr r0, [r0]
    cmp r0, #1
    ldreq r0, =0x28F
    ldreq r1, =0x190
    bleq drawBlock
    b s1done

b2c:
    ldr r0, =0x28F
    cmp r6, r0
    blt Block2down
    ldr r0, =0x2BC
    cmp r10, r0
    bge Block3
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
    bl updateScore
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
    cmp r6, r0
    blt Block2
    ldr r0, =0x2E9
    cmp r4, r0
    bgt Block3down
    ldr r0, =state3
    ldrb r0, [r0]
    cmp r0, #1
    bne Block3down
    ldr r0, =0x2BD
    cmp r6, r0
    bge B3Head

B3Head:
    ldr r0, =0x1BD
    cmp r5, r0
    bge b3c
B3Feet:
    ldr r0, =0x190
    cmp r7, r0
    ble b3c
B3SideL:
    ldr r0, =0x14B
    cmp r5, r0
    beq b3c
    ldr r0, =0x2D5
    cmp r4, r0
    bge B3SideR

    ldr r0, =mario
    ldr r1, =0x290
    str r1, [r0]
    ldr r0, =0x2BC
    ldr r1, =0x190
    bl drawBlock
    b b3c
B3SideR:
    ldr r0, =state3
    ldrb r0, [r0]
    cmp r0, #0
    beq Block3down
    ldr r0, =0x2E9
    cmp r4, r0
    bgt b3c
    ldr r0, =0x14B
    cmp r5, r0
    ble b3c
    ldr r0, =mario
    ldr r1, =0x2EA
    str r1, [r0]
    ldr r0, =0x2BC
    ldr r1, =0x190
    bl drawBlock
    b s1done

b3c:
    ldr r0, =0x2BC
    cmp r6, r0
    blt Block3down
    ldr r0, =0x2E9
    cmp r10, r0
    bge Block3down
    ldr r0, =state3
    ldrb r0, [r0]
    cmp r0, #0
    beq Block3down
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
.globl state4
state4: .int 1
.globl state5
state5: .int 1
.globl floor
floor:  .int 487
