@.section    .init
@.globl     _DetectCollisions
@
@_DetectCollisions:
@    b DetetectCollision
@
@
@DetetectCollision:
@	push	{r4-r10,lr}
@	ldr r0, =mario
@	ldr r4, [r0]
@	ldr r5, [r0 + 4]
@	ldr r9, =mariowidth
@	ldr r9, [r9]
@	ldr r10, =marioheight
@	ldr r10, [r10]
@	mov r9, #4
@	mov r7, #0
@	bl checkUp
@	bl checkDown
@	bl checkLeft
@	bl checkRight
@	pop		{r4-r10,lr}
@	bx lr
@
@
@checkUp:
@	ldr r0, =block
@	ldr r1, [r0, lsl r7]
@	ldr r2, [r0 , r9, lsl r7]
@	add r9, r5, r9
@	add r7, r4, r10
@	cmp r4, r1
@	blt up1
@	add r8, r1, blockWidth
@ck:
@	cmp r9, r2
@	blt checkDown
@ck1:
@	cmp r5, r1
@	blge _DestoryBlock
@	movge r0, #1
@ck2:
@	cmp r5, r8
@	blle _DestoryBlock
@ck3:
@	cmp r7, r1
@	blge _DestoryBlock
@ck4:
@	cmp r7, r8
@	blle _DestoryBlock
@	add r7, r7, #3
@	cmp r7, #number of blocks
@	blt checkUp
@	mov r9, #0
@	mov r7, #0
@checkDown:
@	ldr r0, =enemy
@	ldr r1, [r0, lsl r7]
@	ldr r2, [r0, r9, lsl r7]
@
@checkLeft:
@
@
@checkRight:
