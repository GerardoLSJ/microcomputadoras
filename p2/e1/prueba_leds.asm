	processor 16f877
	include <p16f877.inc>

	org 0
	goto inicio
	org 5
	
contador EQU 0x22
entrada EQU 0x21
	
inicio:
	bsf STATUS, 5
	movlw 0x07
	movwf TRISD
	movlw 0
	movwf TRISB
	movlw 0x07
	movwf ADCON1
	
lecturaEntrada:
	bcf STATUS, 5
	movwf PORTD 
	movwf entrada
	movlw 0x07
	andwf entrada, 1 
	
	movlw 0x01
	xorwf entrada, 0
	btfsc STATUS, Z
	goto corrimientoD
	
	movlw 0x02
	xorwf entrada, 0
	btfsc STATUS, Z
	goto corrimientoI
	
	movlw 0x03
	xorwf entrada, 0
	btfsc STATUS, Z
	goto centro
	
	call parpadeo
	goto lecturaEntrada
	
corrimientoD:
	bsf STATUS, C
	movlw 0x80
	movwf PORTB	
	call retardo
loop:
	rrf 0x06, 1 ; 0x06 es PORTB
	call retardo
	btfss PORTB, 0
	goto loop
	
	goto lecturaEntrada
	
corrimientoI:
	bsf STATUS, C
	movlw 0x01
	movwf PORTB
	call retardo
loop1:
	rlf 0x06, 1
	call retardo
	btfss PORTB, 7
	goto loop1
	
	goto lecturaEntrada	
	
tablaValores:
	addwf PCL, 1
	retlw 0x81
	retlw 0x42
	retlw 0x24
	retlw 0x18
	
centro:
	clrf 0x20
loop2:
	movf 0x20,0
	call tablaValores
	incf 0x20,1
	movwf PORTB 
	call retardo
	btfss PORTB, 4
	goto loop2
	
	goto lecturaEntrada

parpadeo:
	movlw 0xff
	movwf 0x06
	call retardo
	movlw 0x00
	movwf 0x06
	call retardo
	goto lecturaEntrada
	

retardo:
	movlw 0x00
	movwf contador 
ciclo:
	decfsz contador, 1
	goto ciclo
	return 

	end