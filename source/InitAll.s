.section    .init
.globl _InitAll

.section	.text
_InitAll:
    b InitClock

InitClock:
    ldr r0, =0x3F200004         //address for GPFSEL1
    ldr r1, [r0]                //loads the contents of address into r1
    mov r2, #7                  //creates bitmask
    lsl r2, #3                  //align for 1st index of pin 11
    bic r1, r2                  //clear bit at pin 11
    mov r3, #1                  //output function code
    lsl r3, #3                  //r3 = 0 001 000
    orr r1, r3                  //sets the pin 11 function in r1
    str r1, [r0]                //stores it back into GPFSEL1

InitLatch:
    ldr r0, =0x3F200000         //address for GPFSEL0
    ldr r1, [r0]                //loads the contents of address into r1
    mov r2, #7                  //creates bitmask
    lsl r2, #27                 //align for 1st index of pin 9
    bic r1, r2                  //clear bit at pin 9
    mov r3, #1                  //output function code
    lsl r3, #27                 //r3 = 001 000 000 000 000 000 000 000 000
    orr r1, r3                  //sets the pin 9 function in r1
    str r1, [r0]                //stores it back into GPFSEL0

InitData:
    ldr r0, =0x3F200004         //address for GPFSEL1
    ldr r1, [r0]                //loads the contents of address into r1
    mov r2, #7                  //creates a bitmask
    bic r1, r2                  //clears bit at pin 10
    mov r3, #1                  //r3 = 0 001
    add r3, r1                  //sets the pin 10 function into GPFSEL1
    str r1, [r0]                //stores it back into GPFSEL0


    bx lr