.section    .init
.globl     _ButtonFunctions

_ButtonFunctions:
    b ButtonFunctions

.section .text

ButtonFunctions:
.globl BPress
BPress:
    ldr r0, =mario
    ldr r4, [r0]
    ldr r5, [r0,#4]
    //Could do a power-pack ability here
.globl YPress
YPress:
    //NOthing yet
.globl SelPress
SelPress:
.globl STPress
STPress:
    push {r4-r10,lr}
    mov r8, #0
    mov r7, #0
    //bl _gameMenu
stread:
    bl _ReadSNES
stloop:
    cmp r5, #15
    bgt stread
    ldr r5, =buttons            //load the address of the buffer into r5
    ldrb r4, [r5, #4]           //load a byte from the buffer
    cmp r4, #0
    beq stdone
    ldrb r4, [r5, #5]           //load a byte from the buffer
    cmp r4, #0
    beq upOpt
    ldrb r4, [r5, #6]           //load a byte from the buffer
    cmp r4, #0
    beq downOpt
    ldrb r4, [r5, #9]
    cmp r4, #0
    //beq restart
    b stread

stdone:
    //bl clearmenu
    pop {r4-r10,lr}
    bx lr
upOpt:
    //bl pausemenu1
upR:
    bl _ReadSNES
    ldr r5, =buttons
    ldrb r4, [r5, #9]
    cmp r4, #0
    beq _start
    ldrb r4, [r5, #6]
    cmp r4, #0
    beq downOpt
    b upR

downOpt:
    //bl pausemenu2
dR:
    bl _ReadSNES
    ldr r5, =buttons
    ldrb r4, [r5, #9]
    cmp r4, #0
    //beq clearmenu
    //beq Quit
    ldrb r4, [r5, #5]
    cmp r4, #0
    beq upOpt
    b dR

.globl JPUPress
JPUPress:
    push {r4-r10,lr}
    ldr r5, =mario
    ldr r4, [r5]
    ldr r7, [r5,#4]
    mov r6, r7
    sub r8, r7, #180 //max jump height
jumpup:
    sub r6, r6, #15  //jump height per frame
    bl clearMario
    str r6, [r5,#4]
    bl drawMario
    ldr r1, =screenNumber
    ldr r1, [r1]
    cmp r1, #1
    bl Detect1
    cmp r0, #0
    beq downex
    //cmp r1, #2
    //bl Detect2
    //cmp r1, #3
    //bl Detect3
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
jumpdown:
    add r6, r6, #15
    bl clearMario
    str r6, [r5,#4]
    bl drawMario
    cmp r1, #1
    bl Detect1
    //cmp r1, #2
    //bl Detect2
    //cmp r1, #3
    //bl Detect3
    cmp r6, r7
    blt jumpdown
    b downex
    bl Detect1
    //cmp r1, #2
    //bl Detect2
    //cmp r1, #3
    //bl Detect3
.globl downex
 downex:
    pop {r4-r10,lr}
    bx lr

UpRightPress:
    push {r4-r10, lr}
    ldr r5, =mario
    ldr r4, [r5]
    
    ldr r7, =0x40b
    add r6, r4, #8
    cmp r6, r7
    blt UdrawR
    beq UscreenR

    ldr r7, =0x807
    cmp r6, r7
    blt UdrawR
    beq UscreenR
    //add screen 3 check
UdrawR:
    bl clearMario
    str r6, [r5]
    bl Detect1
    //cmp r1, #2
    //bl Detect2
    //cmp r1, #3
    //bl Detect3
    bl drawMario
    b UdoneR
UscreenR:
    bl updateScreen
    bl clearMario
    str r6, [r5]

    //bl updateScreen
    bl drawMario
UdoneR:
    pop {r4-r10,lr}
    mov pc, lr

UpLeftPress:
    push {r4-r10,lr}
    ldr r5, =mario
    ldr r4, [r5]
    sub r6, r4, #8
    cmp r6, #0
    bgt UdrawL
    b Udonel
UdrawL:
    bl clearMario
    str r6, [r5]
    bl Detect1
    //cmp r1, #2
    //bl Detect2
    //cmp r1, #3
    //bl Detect3
    bl drawMario
    b Udonel
Udonel:
    pop {r4-r10, lr}
    mov pc, lr

.globl JPLPress
JPLPress:
    push {r4-r10,lr}
    ldr r5, =mario
    ldr r4, [r5]
    sub r6, r4, #15
    cmp r6, #0
    bgt drawL
    b donel
drawL:
    bl clearMario
    str r6, [r5]
    //bl _DetectCollisions
    //cmp r0, #1
    //beq donel
    //cmp r0, #2
    //beq lifelost

    bl drawMario
donel:
    pop {r4-r10, lr}
    bx lr
.globl JPRPress
JPRPress:
    push {r4-r10, lr}
    ldr r5, =mario
    ldr r4, [r5]
    
    ldr r7, =0x40b
    add r6, r4, #15
    cmp r6, r7
    blt drawR
    beq screenR

    ldr r7, =0x807
    cmp r6, r7
    blt drawR
    beq screenR
    //add screen 3 check
drawR:
    bl clearMario
    str r6, [r5]
    //bl _DetectCollisions
    //cmp r0, #1
    //beq doneR
    //cmp r0, #2
    //beq lifelost
    bl drawMario
    cmp r1, #1
    bl Detect1
    //cmp r1, #2
    //bl Detect2
    //cmp r1, #3
    //bl Detect3
    b doneR
screenR:
    bl updateScreen
    bl clearMario
    str r6, [r5]

    //bl updateScreen
    bl drawMario
doneR:
    pop {r4-r10,lr}
    bx lr
.globl APress
APress:
.globl XPress
XPress:
.globl LBPress
LBPress:
.globl RBPress
RBPress:
