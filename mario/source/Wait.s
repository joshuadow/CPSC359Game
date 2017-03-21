.section    .init
.globl  _Wait

.section    .text
_Wait:
    push {r4-r10,lr}
    mov r4, r0
    b Wait

Wait:
    ldr r0, =0x3F003004         //CLO
    ldr r1, [r0]                //get value of CLO in r1
    add r1, r4                  //add a certain time in microseconds (passed as param)
LoopInWait:
    ldr r0, =0x3F003004         //CLO
    ldr r2, [r0]                //get value of CLO in r1
    cmp r2, r1                  //when CLO is equal to r1 we break
    blt LoopInWait
    pop {r4-r10,lr}
    bx lr                       //if equal then return to calling code

.globl WaitLong
WaitLong:
    push {r4-r10,lr}
    mov r4, r0
    mov r5, #60
    mul r4, r4, r5
    ldr r0, =0x3F003004
    ldr r1, [r0]
    add r1, r4
LoopInWaitL:
    ldr r0, =0x3F003004         //CLO
    ldr r2, [r0]                //get value of CLO in r1
    cmp r2, r1                  //when CLO is equal to r1 we break
    blt LoopInWaitL
    pop {r4-r10,lr}
    bx lr                       //if equal then return to calling code
