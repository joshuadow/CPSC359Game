.section    .init

.globl Grav

.section    .text


Grav:
    push {r4-r10, lr}
    ldr r0, =gravflag
    ldrb r0, [r0]
    cmp r0, #0
    beq gravdone
    ldr r0, =mario
    ldr r5, [r0,#4]
    mov r6, r5
gravityloop:
    add r6, r6, #30
    mov r0, #2000
    bl WaitLong
    bl clearMario
    ldr r0, =floor
    ldr r0, [r0]
    cmp r6, r0
    bgt gravfloor1
    ldr r0, =mario
    str r6, [r0,#4]
    bl drawMario
    ldr r1, =screenNumber
    ldr r1, [r1]
    cmp r1, #1
    bl Detect1
    //cmp r1, #2
    //bl Detect2
    //cmp r1, #3
    //bl Detect3
    ldr r9, =buttons
    ldrb r10, [r9, #7]
    cmp r10, #0
    bleq UpRightPress
    ldr r9, =buttons
    ldrb r10, [r9, #6]
    cmp r10, #0
    bleq UpLeftPress
    ldr r0, =floor
    ldr r0, [r0]
    cmp r6, r0
    blt gravityloop
    b gravdone
gravfloor1:
    ldr r0, =mario
    ldr r1, =floor
    ldr r1, [r1]
    str r1, [r0,#4]
    bl drawMario
gravdone:
    pop {r4-r10, lr}
    mov pc, lr
.section    .data

.globl gravflag
gravflag:   .int 1
