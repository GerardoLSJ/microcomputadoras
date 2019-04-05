    processor 16f877
    include <p16f877.inc>

entrada equ 0x30
dato1 equ 0x31
dato2 equ 0x32
resultado equ 0x33

; ;;;;;;;;;;;;;;;;
contador equ 0x20
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'

cte1 equ 50h
cte2 equ 51h
cte3 equ 52h
    ; ;;;;;;;;;;;;;;;;

    org 0
    goto inicio
    org 5

inicio
    ; condiciones iniciales
    bsf STATUS, 5
    ; PUERTO A COMO ENTRADA XXXXX111
    movlw 0x07
    movwf TRISAmovwf dato1
    PUERTO B COMO SALIDA 00000000
    movlw 0x00
    movwf TRISB
    movlw 0x07
    movwf ADCON1

lecturaEntrada
    bcf STATUS, 5
    movf PORTA, 0

    ; MSB
    movwf entrada
    movlw 0xF0
    andwf entrada, 0
    movwf dato1

    ; LSB
    movwf entrada
    movlw 0x0F
    andwf entrada, 0
    movwf dato2

    goto suma

suma
    movf dato1, 0
    addwf dato2, 0
    movwf resultado

    call tablaValores

tablaValores
    addwf PCL,1

    retlw 0x7E       ; 0
    retlw 0x60       ; 1
    retlw 0x5B       ; 2
    retlw 0x73       ; 3
    retlw 0x65       ; 4
    retlw 0x37       ; 5
    retlw 0x3F       ; 6
    retlw 0x63       ; 7
    retlw 0x7F       ; 8
    retlw 0x67       ; 9
    retlw 0x6F       ; A
    retlw 0x3D       ; B
    retlw 0x1E       ; C
    retlw 0x79       ; D
    retlw 0x1F       ; E
    retlw 0x0F       ; F

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

    END