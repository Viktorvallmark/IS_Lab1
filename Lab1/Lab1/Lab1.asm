/*
 * lab1.asm
 *
 * This is a very simple demo program made for the course DA215A at
 * Malmö University. The purpose of this program is:
 *	-	To test if a program can be transferred to the ATmega32U4
 *		microcontroller.
 *	-	To provide a base for further programming in "Laboration 1".
 *
 * After a successful transfer of the program, while the program is
 * running, the embedded LED on the Arduino board should be turned on.
 * The LED is connected to the D13 pin (PORTC, bit 7).
 *
 * Author:	Mathias Beckius, updated by Magnus Krampell
 *
 * Date:	2014-11-05, 2021-11-17
 */
	;==============================================================================
	;    Definitions of registers, etc. ("constants")
	;==============================================================================
	.EQU RESET  = 0x0000
	.EQU PM_START = 0x0056
	.EQU NO_KEY = 0x0F
	.DEF TEMP = R16
	.DEF RVAL = R24

	;==============================================================================
	;    Start of program
	;==============================================================================
	.CSEG
	.ORG RESET
	RJMP init

	.ORG PM_START
	;==============================================================================
	;    Basic initializations of stack pointer, I/O pins, etc.
	;==============================================================================

init:
	;    Set stack pointer to point at the end of RAM.
	LDI  R16, LOW(RAMEND)
	OUT  SPL, R16
	LDI  R16, HIGH(RAMEND)
	OUT  SPH, R16
	;    Initialize pins
	CALL init_pins
	;    Jump to main part of program
	RJMP main

	;==============================================================================
	; Initialize I/O pins
	;==============================================================================

init_pins:
	CBI DDRE, 7
	LDI TEMP, 0xFF
	OUT DDRB, TEMP
	OUT PORTB, TEMP
	OUT DDRF, TEMP
	OUT PORTF, TEMP

	RET

	;==============================================================================
	; Read Keyboard
	;==============================================================================

read_keyboard:
	LDI R18, NO_KEY

scan_key:
	MOV  R19, R18
	LSL  R19
	LSL  R19
	LSL  R19
	LSL  R19
	OUT  PORTB, R19
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	SBIC PINE, 6
	INC  R18
	CPI  R18, 12
	BRNE scan_key
	LDI  R18, NO_KEY

return_key_val:
	MOV RVAL, R18
	RET

	;==============================================================================
	; Main part of program
	;==============================================================================

main:
	CALL read_keyboard
	OUT  PORTF, RVAL
	RJMP main; 2 cycles
