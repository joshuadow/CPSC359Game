.section    .init
.globl     _ButtonFunctions

_ButtonFunctions:
    b ButtonFunctions

.section .text

ButtonFunctions:
.globl BPress
BPress:
    b doneR
.globl YPress
YPress:
    b doneR
.globl SelPress
SelPress:
.globl STPress
STPress:
    push {r4-r10,lr}
    bl PauseMenu
    pop {r4-r10,lr}
    bx lr
upOpt:
    //bl pausemenu1
//upR:
//    bl _ReadSNES
//    ldr r5, =buttons
//    ldrb r4, [r5, #9]
//    cmp r4, #0
//    beq _start
//    ldrb r4, [r5, #6]
//    cmp r4, #0
//    beq downOpt
//    b upR

//downOpt:
//    //bl pausemenu2
//dR:
//    bl _ReadSNES
//    ldr r5, =buttons
//    ldrb r4, [r5, #9]
//    cmp r4, #0
//    //beq clearmenu
//    //beq Quit
//    ldrb r4, [r5, #5]
//    cmp r4, #0
//    beq upOpt
//    b dR

.globl JPUPress
JPUPress:
    push {r4-r10,lr}
    ldr r5, =mario
    ldr r4, [r5]
    ldr r7, [r5,#4]
    mov r6, r7
    sub r8, r7, #180 //max jump height
    ldr r0, =gravflag
    mov r1, #0
    str r1, [r0]
jumpup:
    ldr r0, =gravflag
    ldrb r0, [r0]
    cmp r0, #1
    beq jumpdone
    sub r6, r6, #30  //jump height per frame
    bl clearMario
    str r6, [r5,#4]

    ldr r1, =screenNumber
    ldr r1, [r1]
    cmp r1, #1
    bleq Detect1

    cmp r1, #2
    bleq Detect2
    
    cmp r1, #3
    bleq Detect3
    bl drawMario

    bl _ReadSNES
    ldr r9, =buttons
    ldrb r10, [r9, #7]
    cmp r10, #0
    bleq UpRightPress
    ldr r9, =buttons
    ldrb r10, [r9, #6]
    cmp r10, #0
    bleq UpLeftPress
    cmp r6, r8
    bge jumpup
jumpdone:
    ldr r0, =gravflag
    mov r1, #1
    str r1, [r0]
    pop {r4-r10, lr}
    mov pc, lr
.globl UpRightPress
UpRightPress:
    push {r4-r10, lr}
    ldr r5, =mario
    ldr r4, [r5]

    ldr r7, =0x3D4
    add r6, r4, #15
    cmp r6, r7
    blt UdrawR
    bge UscreenR

    ldr r7, =0x807
    cmp r6, r7
    blt UdrawR
    beq UscreenR
    //add screen 3 check
UdrawR:
    bl clearMario
    str r6, [r5]

    ldr r1, =screenNumber
    ldr r1, [r1]
    cmp r1, #1
    bleq Detect1
    cmp r1, #2
    bleq Detect2
    cmp r1, #3
    bleq Detect3
    bl drawMario
    b UdoneR
UscreenR:
          bl updateScreenRight
          bl clearMario
          ldr r5, =mario
          mov r4, #75
          ldr r6, = 0x1e7
          str r4, [r5]
          str r6, [r5, #4]
          bl drawMario
UdoneR:
    pop {r4-r10,lr}
    mov pc, lr
.globl UpLeftPress
UpLeftPress:
    push {r4-r10,lr}
    ldr r5, =mario
    ldr r4, [r5]

    ldr r7, =0x4B
    sub r6, r4, #15
    cmp r6, #0
    bgt UdrawL
    ble UscreenL
UdrawL:
    bl clearMario
    str r6, [r5]
    ldr r1, =screenNumber
    ldr r1, [r1]
    cmp r1, #1
    bleq Detect1
    cmp r1, #2
    bleq Detect2
    cmp r1, #3
    bleq Detect3
    bl drawMario
    b Udonel
UscreenL:
        bl updateScreenLeft
        bl clearMario
        ldr r5, =mario
        ldr r4, = 0x3B5 //#949
        ldr r6, = 0x1e7
        str r4, [r5]
        str r6, [r5, #4]
        bl drawMario
Udonel:
    pop {r4-r10, lr}
    mov pc, lr

.globl JPLPress
JPLPress:
    push {r4-r10,lr}
    ldr r5, =mario
    ldr r4, [r5]

    ldr r7, =0x4B
    sub r6, r4, #15
    cmp r6, #0
    bgt drawL
    ble screenL
drawL:
    bl clearMario
    str r6, [r5]
    ldr r1, =screenNumber
    ldr r1, [r1]
    cmp r1, #1
    bleq Detect1
    cmp r1, #2
    bleq Detect2
    cmp r1, #3		
    bleq Detect3
    bl drawMario
    b donel
screenL:
    bl updateScreenLeft
    bl clearMario
    ldr r5, =mario
    ldr r4, = 0x3B5 //#949
    ldr r6, = 0x1e7
    str r4, [r5]
    str r6, [r5, #4]
    bl drawMario
donel:
    pop {r4-r10, lr}
    bx lr
.globl JPRPress
JPRPress:
    push {r4-r10, lr}
    ldr r5, =mario
    ldr r4, [r5]

    ldr r7, =0x3D4
    add r6, r4, #15
    cmp r6, r7
    blt drawR
    bge screenR

    ldr r7, =0x807
    cmp r6, r7
    blt drawR
    beq screenR
    //add screen 3 check
drawR:
    bl clearMario
    str r6, [r5]
    ldr r1, =screenNumber
    ldr r1, [r1]
    cmp r1, #1
    bleq Detect1
    cmp r1, #2
    bleq Detect2
    cmp r1, #3		
    bleq Detect3
    bl drawMario
    b doneR
screenR:
    bl updateScreenRight
    bl clearMario
    ldr r5, =mario
    mov r4, #75
    ldr r6, = 0x1e7
    str r4, [r5]
    str r6, [r5, #4]
    bl drawMario
doneR:
    pop {r4-r10,lr}
    bx lr
.globl APress
APress:
.globl XPress
XPress:
 b doneR
.globl LBPress
LBPress:
 b doneR
.globl RBPress
RBPress:
 b doneR