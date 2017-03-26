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


LS1:
        ldr r0, =block1
        ldr r8, [r0]
        ldr r9, [r0,#4]
        add r1, r8, #45
        add r2, r9, #45
        cmp r6, r8
        bne RS1
        cmp r5, r2
        bgt RS1
        cmp r7, r9
        blt RS1
        pop {r4-r10, lr}
        mov r0, #13
        mov pc, lr
 
RS1:  
        ldr r0, =block2
        ldr r8, [r0]
        ldr r9, [r0,#4]
        add r1, r8, #45
        add r2, r9, #45
        cmp r4, r1
        bne JU1
        cmp r5, r2
        bgt JU1
        cmp r7, r9
        blt JU1
        pop {r4-r10, lr}
        mov r0, #13
        mov pc, lr

JU1:
        ldr r0, =0x262
        cmp r6, r0
        blt JD1
        ldr r0, =0x2E9
        cmp r4, r0
        bgt JD1
        ldr r0, =0x14B
        cmp r5, r0
        blt D1D
        ldr r0, =0x14B
        cmp r5, r0
        bgt BD1
        ldr r0, =mario
        ldr r1, =0x14B
        bl clearMario
        str r1, [r0,#4]
        bl drawMario
        ldr r0, =js1
        mov r1, #1
        str r1, [r0]
JD1:
        ldr r0, =0x262
        cmp r6, r0
        bge JD11
        ldr r0, =0x2E9
        cmp r4, r0
        ble JD11
        ldr r0, =0x1E7
        mov r10, r0
        cmp r5, r0
        beq BD1
        bl clearMario
        ldr r0, =mario
        ldr r2, =0x1E7
        mov r5, r2
        str r5, [r0,#4]
        bl drawMario
JD11:
        pop {r4-r10, lr}
        mov r0, #0
        mov pc, lr
BD1:
        bl clearMario
        bl drawMario
        ldr r0, =block1
        ldr r8, [r0]
        ldr r9, [r0,#4]
        add r1, r8, #45
        add r2, r9, #45
        add r10, r4, #21
        ldr r1, =0x14B
        cmp r5, r1
        ble D1D
        cmp r10, r8
        blt EK1
        cmp r10, r1
        bgt CD1
        ldr r0, =0x1C3
        cmp r5, r0
        bgt EK1
        ldr r0, =block1
        ldr r0, [r0]
        ldr r1, =block1
        ldr r1, [r1, #4]
        bl clearBox
        pop {r4-r10, lr}
        mov r0, #13
        mov pc, lr

CD1:
        ldr r0, =cblock
        ldr r8, [r0]
        ldr r9, [r0,#4]
        add r1, r8, #45
        add r2, r9, #45
        add r10, r4, #21
        cmp r10, r8
        blt BD1
        cmp r10, r1
        bgt BD2
        ldr r0, =0x1C3
        cmp r5, r0
        bgt EK1
        ldr r0, =cblock
        ldr r0, [r0]
        ldr r1, =cblock
        ldr r1, [r1, #4]
        bl drawBlock
        ldr r0, =coins
        ldr r1, [r0]
        add r1, r1, #1
        str r1, [r0]
        ldr r0, =score
        ldr r1, [r0]
        add r1, r1, #50
        str r1, [r0]
        pop {r4-r10, lr}
        mov r0, #13
        mov pc, lr
BD2:
        ldr r0, =block2
        ldr r8, [r0]
        ldr r9, [r0,#4]
        add r1, r8, #45
        add r2, r9, #45
        add r10, r4, #21
        cmp r10, r8
        blt CD1
        cmp r10, r1
        bgt D1D
        ldr r0, =0x1C3
        cmp r5, r0
        bgt EK1
        ldr r0, =block2
        ldr r0, [r0]
        ldr r1, =block2
        ldr r1, [r1, #4]
        bl clearBox
        pop {r4-r10, lr}
        mov r0, #13
        mov pc, lr
EK1:
        ldr r0, =shellEnemy
        ldr r8, [r0]
        ldr r9, [r0, #4]
        add r1, r8, #31
        add r2, r9, #50
        cmp r4, r1
        bgt D1D
        cmp r6, r8
        blt D1D
        ldr r1, =0x1FD
        cmp r7, r9
        ble MK1
        ldr r0, =mario
        ldr r1, [r0, #8]
        sub r1, r1, #1
        str r1, [r0, #8]
        //do check for game over, then display main screen 
        b restart

MK1:
        ldr r1, =0x1FD
        cmp r7, r1
        bne D1D
        ldr r8, =shellEnemy
        ldr r0, [r8]
        ldr r1, [r8, #4]
        bl clearShell
        ldr r0, =score
        ldr r1, [r0]
        add r1, r1, #100       
        str r1, [r0]

D1D:
        ldr r0, =js1
        mov r1, #0
        str r1, [r0]
        pop {r4-r10, lr}
        mov pc, lr


















