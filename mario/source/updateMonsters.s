
.globl updateMonsters
updateMonsters:
  push {r4-r10, lr}

  ldr r5, =screenNumber
  ldr r5, [r5]

  mov r6, #1
  cmp r5, r6
  bleq updateShell

  mov r6, #2
  cmp r5, r6
  bleq updateDragon
  @
  @mov r6, #3
  @cmp r5, r6
  @bleq updateBowser

  doneMonsters:
      pop {r4-r10, lr}
      bx lr


updateShell:
    push {r4-r10,lr}
    ldr r8, =shellEnemy
    ldr r4, [r8]
    ldr r5, [r8, #8]
    cmp r5, #1
    beq donel
    sub r6, r4, #5
    cmp r6, #20
    ble destroy
drawL:
    cmp r6, #0
    ldr r0, =shellEnemy
    ldr r0, [r0]
    ldr r1, =shellEnemy
    ldr r1, [r1,#4]
    bl clearShell
    ldr r7, =mario
    ldr r3, [r7,#4]
    ldr r7, [r7]
    ldr r0, =shellEnemy
    ldr r0, [r0]
    ldr r1, =shellEnemy
    ldr r1, [r1,#4]

    add r3, r3, #70
    cmp r3, r1
    blt drawLc

    add r7, r7, #41
    cmp r7, r0
    blt drawLc

    add r0, r0, #50
    sub r7, r7, #41
    cmp r7, r0
    bgt drawLc

    ldr r1, =lives
	ldr r0, [r1]
	sub r0, r0, #1
	str r0, [r1]
	b restart    

drawLc:
    ldr r0, =shellEnemy
    ldr r0, [r0]
    ldr r1, =shellEnemy
    ldr r1, [r1,#4]
    str r6, [r8]
    ldr r0, =shellEnemy
    ldr r0, [r0]
    ldr r1, =shellEnemy
    ldr r1, [r1,#4]
    ldr r2, =shellEnemy
    ldr r2, [r2,#8]
    cmp r2, #1
    beq donel
    bl drawShell
    b donel
destroy:
        ldr r0, =shellEnemy
        ldr r0, [r0]
        ldr r1, =shellEnemy
        ldr r1, [r1,#4]
        bl clearShell
        mov r10, #1
        str r10, [r8, #8]
donel:
    pop {r4-r10, lr}
    bx lr

updateDragon:
    push {r4-r10,lr}
    ldr r8, =dragonEnemy
    ldr r4, [r8]
    ldr r9, [r8, #8]
    cmp r9, #0
    beq increase
    cmp r9, #1
    beq decrease

decrease:
          sub r6, r4, #5
          mov r10, #0
          cmp r6, #340
          strle r10, [r8, #8]
          b drawL2
increase:
          add r6, r4, #5
          mov r10, #1
          ldr r5, = 0x2BC
          cmp r6, r5
          strge r10, [r8, #8]
          b drawL2
drawL2:
    cmp r6, #0
    ldr r0, =dragonEnemy
    ldr r0, [r0]
    ldr r1, =dragonEnemy
    ldr r1, [r1,#4]
    bl clearDragon
    str r6, [r8]

    ldr r0, =dragonEnemy
    ldr r0, [r0]
    ldr r1, =dragonEnemy
    ldr r1, [r1,#4]
    ldr r2, =dragonEnemy
    ldr r2, [r2,#8]
    cmp r2, #1
    beq donel2
    bl drawDragon
donel2:
    pop {r4-r10, lr}
    bx lr
