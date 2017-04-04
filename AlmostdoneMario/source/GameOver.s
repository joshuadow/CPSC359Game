.section .init
.globl _GameOver

_GameOver:
        b gameOverScreen

.globl gameOverScreen
gameOverScreen:

                ldr r9, =playingstatus
                mov r10, #1
                str r10, [r9]


                bl drawgameOver

GameOverScreenLoop:
                bl _ReadSNES

                ldr r9, =buttons
                ldrb r10, [r9, #1]
                cmp r10, #0
                beq gameOverRestart

                ldr r9, =buttons
                ldrb r10, [r9, #2]
                cmp r10, #0
                beq gameOverRestart


                ldr r9, =buttons
                ldrb r10, [r9, #3]
                cmp r10, #0
                beq gameOverRestart


                ldr r9, =buttons
                ldrb r10, [r9, #4]
                cmp r10, #0
                beq gameOverRestart


                ldr r9, =buttons
                ldrb r10, [r9, #5]
                cmp r10, #0
                beq gameOverRestart


                ldr r9, =buttons
                ldrb r10, [r9, #6]
                cmp r10, #0
                beq gameOverRestart


                ldr r9, =buttons
                ldrb r10, [r9, #7]
                cmp r10, #0
                beq gameOverRestart


                ldr r9, =buttons
                ldrb r10, [r9, #8]
                cmp r10, #0
                beq gameOverRestart


                ldr r9, =buttons
                ldrb r10, [r9, #9]
                cmp r10, #0
                beq gameOverRestart


                ldr r9, =buttons
                ldrb r10, [r9, #10]
                cmp r10, #0
                beq gameOverRestart


                ldr r9, =buttons
                ldrb r10, [r9, #11]
                cmp r10, #0
                beq gameOverRestart


                ldr r9, =buttons
                ldrb r10, [r9, #12]
                cmp r10, #0
                beq gameOverRestart


                b GameOverScreenLoop


.globl gameOverRestart
gameOverRestart:
      //reset all variables
      ldr r1, =mario
      mov r2, #0
      str r2, [r1]
      ldr r2, =0x1e7
      str r2, [r1, #4]

      ldr r1, =dragonEnemy
      mov r2, #500
      str r2, [r1]
      ldr r2, =0x1f1
      str r2, [r1, #4]
      mov r2, #0
      str r2, [r1, #8]
      mov r2, #0
      str r2, [r1, #12]

      ldr r1, =shellEnemy
      ldr r2, =0x25d
      str r2, [r1]
      ldr r2, =0x1fb
      str r2, [r1, #4]
      mov r3, #0
      str r3, [r1,#8]

      ldr r1, =screenNumber
      mov r2, #1
      str r2, [r1]

      ldr r1, =block1
      ldr r2, =0x262
      str r2, [r1]
      mov r2, #400
      str r2, [r1, #4]

      ldr r1, =block2
      mov r2, #700
      str r2, [r1]
      mov r2, #400
      str r2, [r1, #4]

      ldr r1, =block3
      mov r2, #190
      str r2, [r1]
      mov r2, #440
      str r2, [r1, #4]

      ldr r1, =block4
      mov r2, #260
      str r2, [r1]
      ldr r2, =0x186
      str r2, [r1, #4]

      ldr r1, =cblock
      ldr r2, =0x28f
      str r2, [r1]
      mov r2, #400
      str r2, [r1, #4]

      ldr r1, =cblock2
      ldr r2, =0x10E
      str r2, [r1]
      ldr r2, =0x96
      str r2, [r1, #4]

      ldr r1, =cblock3
      ldr r2, =0x302
      str r2, [r1]
      ldr r2, =0x96
      str r2, [r1, #4]

      ldr r1, =pipe1
      mov r2, #250
      str r2, [r1]
      mov r2, #472
      str r2, [r1, #4]

      ldr r1, =pipe2
      ldr r2, =0x2ee
      str r2, [r1]
      mov r2, #472
      str r2, [r1, #4]

      ldr r1, =castle
      ldr r2, =0x29a
      str r2, [r1]
      mov r2, #199
      str r2, [r1, #4]

      ldr r1, =bowser
      mov r2, #400
      str r2, [r1]
      ldr r2, =0x1a9
      str r2, [r1, #4]

      ldr r1, =pit
      mov r2, #200
      str r2, [r1]
      ldr r2, =0x22d
      str r2, [r1, #4]


      ldr r1, =lives
      mov r2, #3
      str r2, [r1]

      ldr r1, =score
      mov r2, #0
      str r2, [r1]

      ldr r1, =state1
      mov r2, #1
      str r2, [r1]
      ldr r1, =state2
      mov r2, #2
      str r2, [r1]
      ldr r1, =state3
      mov r2, #1
      str r2, [r1]
      ldr r1, =coin1State
      mov r2, #2
      str r2, [r1]
      ldr r1, =coin2State
      mov r2, #2
      str r2, [r1]
      ldr r1, =topFlag
      mov r2, #0
      str r2, [r1]
      ldr r1, =state4
      mov r2, #1
      str r2, [r1]
      ldr r1, =state5
      mov r2, #1
      str r2, [r1]
      ldr r1, =floor
      ldr r2, =0x1E7
      str r2, [r1]

      b _start
