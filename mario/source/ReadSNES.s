.section    .init
.globl	_ReadSNES

.section    .text
_ReadSNES:
    b ReadSNES

ReadSNES:
	push {r4-r10,lr}            //stores contents of registers
    ldr r10, =playingstatus
    ldr r10, [r10]
    mov r9, #0
    cmp r10, r9
    bne skipUpdate
    bl updateMonsters
skipUpdate:
    mov r1, #1                  //load bit to write to clock
    bl _WriteClock
    mov r1, #1                  //load bit to write to latch
    bl _WriteLatch
    mov r0, #12
    bl _Wait                    //wait 12 microseconds
    mov r1, #0                  //load bit to write to latch
    bl _WriteLatch
    mov r7, #0                  //set offset to 0
    mov r0, #2000
    bl WaitLong
pulseLoop:
    mov r0, #6
    bl _Wait                    //wait 6 microseconds
    mov r1, #0                  //load bit to write to clock
    bl _WriteClock
    mov r0, #6
    bl _Wait                     //wait 6 microseconds
    bl _ReadData                //read a bit from the data pin
    ldr r5, =buttons            //loads address of buffer into r5
    strb r0, [r5, r7]           //stores the bit returned from Read_Data into buffer with offset
    add r7, r7, #1              //increment offset
    mov r1, #1                  //load bit to write to clock
    bl _WriteClock
    cmp r7, #16                 //checks if offset is 16
    blt pulseLoop               //if it is less, then branch back to read another bit
    pop {r4-r10, lr}            //restores registers
    bx lr                       //return to calling code
