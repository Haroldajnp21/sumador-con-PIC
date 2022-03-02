'****************************************************************
'*  Name    : UNTITLED.BAS                                      *
'*  Author  : [select VIEW...EDITOR OPTIONS]                    *
'*  Notice  : Copyright (c) 2021 [select VIEW...EDITOR OPTIONS] *
'*          : All Rights Reserved                               *
'*  Date    : 01/07/2021                                        *
'*  Version : 1.0                                               *
'*  Notes   :                                                   *
'*          :                                                   *
'****************************************************************
Device = 16F886

Config1 FOSC_HS, WDTE_OFF, PWRTE_OFF, MCLRE_OFF, CP_OFF, CPD_OFF, BOREN_OFF, IESO_OFF, FCMEN_OFF, LVP_OFF, DEBUG_OFF
Config2 BOR4V_BOR40V, WRT_OFF

Declare Xtal 20

;*********** LCD******************************************************
Declare LCD_Type 0               ;se selecciona como alfanumerico 
Declare LCD_Interface 4          ;selecciona el puerto C para los pines de datos 
Declare LCD_DTPin PORTC.4 
Declare LCD_ENPin PORTC.1        ;se selecciona el pin RC1 para el pin enable 
Declare LCD_RSPin PORTC.0
Declare LCD_Lines 2

;**variables******************************************************** 
Symbol  A=PORTA.0   ;ENTRADA DE DATOS 
Symbol  B=PORTA.1 
Symbol  C=PORTA.2 

'DIM MI AS BYTE
'DIM MA AS BYTE
'DIM ME AS BYTE
Dim SUMA   As Byte
Dim ABSOLU As Byte
Dim MAXI   As Byte
Dim MULTI  As Word
Dim NA     As Byte
Dim NB     As Byte
'DIM NC AS BYTE
Dim i As Byte

NA=0
NB=0
;NC=0

TRISA=%00000111 : TRISB=0 : TRISC=$08 : ANSEL=0 : ANSELH=0


INICIO:
    GoSub LEER_DIG
    SUMA = NA+NB
    ABSOLU = Abs(NA-NB)
    
    If NA > NB Then
        MAXI = NA
    Else
        MAXI = NB
    EndIf
    
    MULTI = NA * NB
    
    Print At 1,1,"Sum=",Dec3 SUMA
    Print At 1,9,"Abs=",Dec3 ABSOLU
    Print At 2,1,"Max=",Dec3 MAXI
    Print At 2,9,"MUL=",Dec MULTI
    
    GoTo INICIO                                     

LEER_DIG:   ; LEER 151
    NA=0
    NB=0
    ;NC=0
    For i=7 To 0 Step -1
        PORTB=i
        NA=NA+A
        NB=NB+B
        ;NC=NC+C
        If i>0 Then
            NA=NA<<1
            NB=NB<<1
          ;  NC=NC<<1
        EndIf
    Next         
Return
