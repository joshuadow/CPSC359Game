.section        .init

.globl  Detect2

.section        .text

Detect2:
        push {r4-r10, lr}
        ldr r0, =mario
        ldr r4, [r0]
        ldr r5, [r0,#4]
        add r6, r4, #41
        add r7, r5, #70

testPipe1:
              cmp r6, #250 //compare mario far right to the pipe left
              blt noCollidePipe1
              ldr r5, =0x14D //load right hand side of pipe (250 +83)
              cmp r4, r5 //compare mario left hand side to pipe right hand side
              bgt noCollidePipe1
              ldr r8, =0x1D8
              cmp r7, r8 //compare mario feet value to highest pipe value
              blt collideTop
              bgt SideCollision //mario is in collision area, but not above. He is going to collide with side walls of pipe


SideCollision: //compare mario x value with the halfway point of the pipe
              ldr r10, =0x123
              cmp r4, r10
              blt comeFromLeft       //if less than halfway, he collided from left hand side (draw on left)

              //else, he collided from right
              ldr r0, =mario
              ldr r9, =0x123
              str r9, [r0]   //update mario's x value, so that he doesn't collide with side
              ldr r9, =0x1E7
              str r9, [r0,#4]
              b testPipe2

comeFromLeft:
              ldr r0, =mario
              ldr r9, =0xD1
              str r9, [r0]  //update mario's x value, so that he doesnt collide with side
              ldr r9, =0x1E7
              str r9, [r0,#4]
              b testPipe2

collideTop:
            ldr r0, =mario
            ldr r5, [r0,#4]
            add r7, r5, #70
            ldr r1, =0x1DB
            cmp r7, r1
            strge r1, [r0, #4]


            ldr r0, =floor
            ldr r1, =0x1D8
            str r1, [r0]
            b testPipe2

noCollidePipe1:
                ldr r0, =floor
                ldr r1, =0x1E7
                str r1, [r0]
                b testPipe2

testPipe2:
          pop {r4-r10, lr}
          mov pc, lr
