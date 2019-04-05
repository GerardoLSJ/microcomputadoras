	processor 16f877
	include <p16f877.inc>

	org 0
	goto inicio
	org 5
	
entrada EQU 0x21
	
inicio:
	bsf STATUS, 5
	movlw 0xFF
	movwf TRISE
	movlw 0
	movwf TRISB
	movlw 0x07
	movwf ADCON1

lecturaEntrada:
	bcf STATUS, 5
	movwf PORTE
	movwf entrada
	movlw 0x07
	andwf entrada, 1 

	movf PORTE, 0
	movwf PORTB
	goto lecturaEntrada

	end