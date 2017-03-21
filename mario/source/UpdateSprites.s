.section    .init
.globl     _UpdateSprites

_UpdateSprites:
    b UpdateSprites

.section .text

UpdateSprites:
	push {r4-r10, lr}
	cmp r7, #1                  //checks clock cycle #
    beq B
    cmp r7, #2                  //checks clock cycle #
    beq Y
    cmp r7, #3                  //checks clock cycle #
    beq Sel
    cmp r7, #4                  //checks clock cycle #
    beq St
    cmp r7, #5                  //checks clock cycle #
    beq JPU
    cmp r7, #7                  //checks clock cycle #
    beq JPL
    cmp r7, #8                  //checks clock cycle #
    beq JPR
    cmp r7, #9                  //checks clock cycle #
    beq A
    cmp r7, #10                 //checks clock cycle #
    beq X
    cmp r7, #11                 //checks clock cycle #
    beq LB
    cmp r7, #12                 //checks clock cycle #
    beq RB
    cmp r7, #13                 //checks clock cycle #
    bge GL                      //if we read offset to be an unused button branch back to read again from controller


B:
	cmp r4, #0
	beq BPress
Y:
	cmp r4, #0
	bleq YPress
Sel:
	cmp r4, #0
	beq SelPress
St:
	cmp r4, #0
	bleq STPress
	b GL
JPU:
	cmp r4, #0
	bleq JPUPress
	b GL
JPL:
	cmp r4, #0
	beq JPLPress
JPR:
	cmp r4, #0
	beq JPRPress
A:
	cmp r4, #0
	beq APress
X:
	cmp r4, #0
	beq XPress
LB:
	cmp r4, #0
	beq LBPress
RB:
	cmp r4, #0
	beq RBPress


EnemyUpdate:

  @ldr r5, =screenNumber
  @ldr r5, [r5]
  @
  @mov r6, #1
  @cmp r5, r6
  @bleq updateShell
  @
  @mov r6, #2
  @cmp r5, r6
  @bleq updateDragon
  @
  @mov r6, #3
  @cmp r5, r6
  @bleq updateBowser

	beq blockUpdate

@updateShell:
@    push {r4-r10,lr}
@    ldr r8, =shellEnemy
@    ldr r4, [r5]
@    sub r6, r4, #5
@    cmp r6, #0
@    bgt drawL
@    b donel
@drawL:
@    bl clearShell
@    str r6, [r5]
@    bl drawShell
@donel:
@    pop {r4-r10, lr}
@    bx lr
@
@updateDragon:
@    push {r4-r10,lr}
@    ldr r8, =dragonEnemy
@    ldr r4, [r5]
@    sub r6, r4, #5
@    cmp r6, #0
@    bgt drawL
@    b donel
@drawL:
@    bl clearDragon
@    str r6, [r5]
@    bl drawDragon
@donel:
@    pop {r4-r10, lr}
@    bx lr


blockUpdate:
	pop {r4-r10, lr}
	bx lr
