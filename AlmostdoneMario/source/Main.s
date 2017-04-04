.section    .init
.globl     _start

_start:
    b main

.section .text
main:
    bl	InstallIntTable
    bl  Something
    bl	EnableJTAG          // Enable JTAG

    bl 	_InitAll
    bl 	_StartScreen
.globl nG
nG: bl 	initialscreen

cycle:
    bl 	_GameLoop
    b cycle

Quit:

.globl hang
hang:
	b hang



.section	.data


.globl buttons
buttons:
	.byte 16
	.rept 1
	.endr

.globl mariowidth
mariowidth:
		.int 67
.global marioheight
marioheight:
		.int 117

