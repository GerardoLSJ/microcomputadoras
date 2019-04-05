	processor 16f877A
	include <p16f877A.inc>

entrada equ 0x30

contador equ 0x20
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'

flag equ 0x31
aux equ 0x32

cte1 equ 50h
cte2 equ 51h
cte3 equ 52h
	
	org 0
	goto inicio
	org 5


inicio
	;condiciones iniciales
	bsf STATUS, 5
	;PUERTO E COMO ENTRADA XXXXX111
	movlw 0x07
	movwf TRISE
	;PUERTO B COMO SALIDA 00000000
	movlw 0x00
	movwf TRISB
	movlw 0x07
	movwf ADCON1
	movlw 0x00
	movwf flag

lecturaEntrada
	bcf STATUS,5
	movf PORTE,0
	movwf entrada
	movlw 0x07
	andwf entrada,1
	movlw 0x01
	xorwf entrada,0
	btfsc STATUS,Z
	goto corrimientoD
	movlw 0x02
	xorwf entrada,0
	btfsc STATUS,Z
	goto corrimientoI
	movlw 0x03
	xorwf entrada,0
	btfsc STATUS,Z
	goto centro
	call parpadeo

corrimientoD
	bcf STATUS,C
	movlw 0x80
	;;
	btfss flag, 0
	movf aux, 0	
	;;

	movwf PORTB ;PORTB es salida
	call retardo
	rrf PORTB,1
	call retardo
	
	;;
	movf PORTB, 0
	movwf aux
	;;
	movlw 0x00
	movwf flag


	btfss PORTB,0 ;; YA ACABO SU CORRIMIENTO
	goto changeFlagOn

	;goto corrimientoD

	goto lecturaEntrada	
	
corrimientoI
	bcf STATUS,C
	movlw 0x01
	movwf PORTB ;PORTB
	call retardo
loop2	
	rlf PORTB,1
	call retardo
	btfss PORTB,7 ; YA ACABO SU CORRIMIENTO VE A LEER
	goto loop2
	goto lecturaEntrada

;;;;;;;;;;

centro
	movlw 0x01
	movwf flag

	clrf 0x20
loop3
	movf 0x20,0
	call tablaValores
	incf 0x20,1
	movwf PORTB
	call retardo
	btfss PORTB,4
	goto loop3
	goto lecturaEntrada 

parpadeo
	movlw 0x01
	movwf flag

	movlw 0xFF
	movwf PORTB
	call retardo
	movlw 0x00
	movwf PORTB
	call retardo
	goto lecturaEntrada


tablaValores
	addwf PCL,1
	retlw 0x81
	retlw 0x42
	retlw 0x24
	retlw 0x18

retardo 
	movlw cte1 
	movwf valor1 
tres  
	movlw cte2 
	movwf valor2 
dos  
	movlw cte3 
	movwf valor3 
uno      
	decfsz valor3 
	goto uno 
	decfsz valor2 
	goto dos 
	decfsz valor1 
	goto tres 
	return
	

changeFlagOn
	movlw 0x01
	movwf flag 
	goto lecturaEntrada	

END