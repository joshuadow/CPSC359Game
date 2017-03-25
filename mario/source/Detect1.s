.section        .init
.globl  Detect1


.section        .text

Detect1:
        push {r4-r10, lr}
        ldr r0, =mario
        ldr r4, [r0]
        ldr r5, [r0,#4]
        
box1up:
        ldr r2, =0x262 //610
        add r8, r4, #41
        cmp r8, r2  
        ble enddt
        ldr r9, =0x2E9
        cmp r4, r9
        bgt enddt
        bl clearMario
        ldr r6, =0x14A  //400
        ldr r0, =mario
        str r6, [r0, #4]
        bl drawMario
        mov r0, #0
        b enddt      
enemy1:
        ldr r0, =shellEnemy
        ldr r2, [r0]
        cmp r5, r2
        blt blockunder1
        cmp r5, r2
        beq mkill1
        b else1
mkill1:
        ldr r0, =shellEnemy
        ldr r2, [r0]
        add r3, r2, #31
        add r8, r4, #41
        cmp r4, r3
        bgt else1
        cmp r8, r2
        blt else1
        //bl clearShell
        ldr r0, =score
        ldr r1, [r0]
        add r1, r1, #50
        str r1, [r0]
        b enddt        
else1:
        mov r8, #0
        add r8, r4, #41
        cmp r8, r2
        beq ekill1
        cmp r4, r3
        beq ekill1
        b blockunder1
ekill1:
        ldr r0, =lives
        ldr r1, [r0]
        sub r1, r1, #1
        str r1, [r0]
        b _start


blockunder1:
        ldr r0, =mario
        ldr r4, [r0]
        ldr r5, [r0,#4]
        mov r8, #0
        add r8, r4, #41
        ldr r2, =0x262
        cmp r8, r2
        blt enddt
        ldr r2, =0x2BC
        cmp r4, r2
        bgt enddt
        ldr r2, =0x1BD
        cmp r5, r2
        beq oneofthree
        b enddt
oneofthree:
        ldr r0, =block1
        ldr r2, [r0]
        cmp r4, r2
        bgt twoofthree
        ldr r0, =block1
        ldr r0, [r0]
        ldr r1, =block1
        ldr r1, [r1, #4]
        bl clearBox
        b donedt
twoofthree:
        ldr r0, =mario
        ldr r4, [r0]
        ldr r0, =cblock
        ldr r2, [r0]
        cmp r4, r2
        bgt threeofthree
        ldr r0, =cblock
        ldr r0, [r0]
        ldr r1, =cblock
        ldr r1, [r1, #4]
        bl clearBox
        b donedt
threeofthree:
        ldr r0, =mario
        ldr r4, [r0]
        ldr r0, =block2
        ldr r2, [r0]
        cmp r4, r2
        bgt enddt
        ldr r0, =0x2BC
        ldr r1, =0x190
        bl clearBox
        b donedt
enddt:
        ldr r0, =mario
        ldr r4, [r0]
        ldr r2, =0x2E9
        cmp r4, r2
        blt donedt
        ldr r2, =0x14A
        cmp r5, r2
        bne donedt
        bl clearMario
        ldr r0, =mario
        ldr r2, =0x1E7
        mov r5, r2
        str r5, [r0,#4]
        bl drawMario
        b donedt       
donedt:
        pop {r4-r10, lr}
        mov pc, lr
