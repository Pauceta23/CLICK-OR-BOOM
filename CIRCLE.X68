;==============================================================================
;CIRCLE MANAGMENT  (AGENT)
;CIRCRAD (W)    (A0)
;CIRCVEC (W)    2(A0)


;==============================================================================

;------------------------------------------------------------------------------
CIRCINIT:
;CIRLCE INITIALIZACION
;INPUT: A0 (POINTER VARIABLES)
;OUTPUT:
;------------------------------------------------------------------------------


        MOVE.B  #80,D0
        MOVE.L  #BLACK,D1
        TRAP    #15             ;COLOR DE BORDE
    
        MOVE.B  #81,D0
        MOVE.L  #RED,D1
        TRAP    #15             ;COLOR DE FONDO

        MOVE.W   #RADINIC,(A0)
        MOVE.W  (CIRCVEC),2(A0)
        
        
        RTS
    
;------------------------------------------------------------------------------        
DRAWCIRC:
;CIRCLE PLOT
;INPUT: A0 (POINTER VARIABLES)
;OUTPUT:
;------------------------------------------------------------------------------

       
;SELECTOR DE COLOR

        MOVE.B  #81,D0
        CLR.L   D1
        MOVE.B  1(A0),D1
        ADD.L   #100,D1
        CMP.B   #1,(LVLNUM)
        BNE     .NOCOL
        SWAP    D1
        BRA     .FINCOL
.NOCOL  CMP.B   #2,(LVLNUM)
        BNE     .FINCOL
        LSL.L   #8,D1
.FINCOL        
        TRAP    #15

;BLANCO
        CMPI.W  #RADFINA-1,(A0)
        BLT     .JUMP1
        MOVE.B  #81,D0
        MOVE.L  #COLFINA,D1
        TRAP    #15

;------------------------------------------------------------------------------          
        
.JUMP1:  
        MOVEM.L D0-D6/A1-A2,-(A7)
        ;DIBUJAMOS EL CIRCULO       
        MOVE.B  #88,D0
        JSR     GETCORD         
        TRAP    #15             
        
        ;RESTABLECEMOS EL COLOREADO POR DEFECTO
        CMP.B   #1,(LVLNUM)
        BNE     .2COL
        MOVE.L  #BLUE,D1
        BRA     FINCOL
.2COL    
        CMP.B   #2,(LVLNUM)
        BNE     .3COL
        MOVE.L  #GREEN,D1
        BRA     FINCOL
.3COL      
        MOVE.L  #RED,D1
FINCOL        
        MOVE.B  #81,D0
        TRAP    #15
        
        MOVEM.L (A7)+,D0-D6/A1-A2

        RTS

GETCORD:
        MOVE.W  D6,-(A7)
        
        CMP.B   #1,(LVLNUM)     ;MIRAMOS EN QUE NIVEL ESTA EL JUEGO     
        BNE     .2LVL
        LEA     LVL1X,A2
        LEA     LVL1Y,A1
        BRA     .FINLVL
.2LVL   CMP.B   #2,(LVLNUM)
        BNE     .3LVL
        LEA     LVL2X,A2
        LEA     LVL2Y,A1
        BRA     .FINLVL
.3LVL   LEA     LVL3X,A2
        LEA     LVL3Y,A1
.FINLVL
        
        MOVE.W  2(A0),D6

    ;LEFT X
        MOVE.W  (A2,D6.W),D1    ;RECORREMOS EL VECTOR ALEATORIO
        SUB.W   (A0),D1         ;SUMAMOS O RESTAMOS RADIO
    
    ;UPPER Y
        MOVE.W  (A1,D6.W),D2
        SUB.W   (A0),D2
    
    ;RIGHT X
        MOVE.W  (A2,D6.W),D3
        ADD.W   (A0),D3
    
    ;LOWER Y
        MOVE.W  (A1,D6.W),D4
        ADD.W   (A0),D4
        
        MOVE.W  (A7)+,D6
        RTS
    
    
CIRCUPD:
        MOVEM.L D0-D1,-(A7)
        MOVEM.L D2-D3,-(A7)
        
        ;COMPROBAR SI HA EXPLOTADO
        CMPI.W  #RADFINA,(A0) 
        BGT     BOOM
        
        ;COMPROBAR SI SE HA CLICADO
        TST.B   (MOUSCLIC)
        BEQ     ALIVE           ;SI HAY UN 0, NO SE HA CLICADO EL CIRCULO SEGURO QUE ESTA VIVO
        
        ;COMENZAMOS A CALCULAR A VER SI SE HA CLICADO DENTRO DEL CIRCULO
        JSR     GETCORD         ;UTILITZAREMOS LOS VALORES DE D1 Y D2 PARA OBTENER EL CENTRO
        ADD.W   (A0),D1
        ADD.W   (A0),D2         ;D1 COORDENADAS X I D2 COORDENADAS Y DEL CENTRO
        
        ;COMENZAMOS LOS CÁLCULOS UTILIZANDO LA FÓRMULA DE LA DISTÁNCIA ELEVADA A 2
        * d = sqrt((x2-x1)^2 + (y2-y1)^2) => d^2 >= (x2-x1)^2 + (y2-y1)^2
        SUB.W   (MOUSCODX),D1   ;CALCULAMOS LAS DIFERENCIAS ENTRE X E Y
        SUB.W   (MOUSCODY),D2
        
        MULS    D1,D1           ;CALCULAMOS EL CUADRADO DE LAS DIFERENCIAS
        MULS    D2,D2
        
        ADD.L   D1,D2           ;LAS SUMAMOS
        
        MOVE.W  (A0),D3         ;OBTENEMOS EL RADIO Y CALCULAMOS SU CUADRADO
        MULU    D3,D3
        
        CMP.L   D3,D2           ;SI LA DISTANCIA ES MENOR AL RADIO
        BLT     KILL            ;SE HA HECHO CLIC DENTRO, SE MATA EL CIRCULO
                    
ALIVE:        
        ADDQ.B  #2,(FRAMCONT)
        CMP.B   #5,(FRAMCONT)
        BGT     WINT
        MOVE.W  (CIRCVEL),D0
        ADD.W   D0,(A0)
        CLR.B   (FRAMCONT)
        BRA     FIN
        
BOOM    SUBQ.B  #1,(SCOLIFE)    ;RESTA UNA VIDA
        JSR     AGLKILL
        JSR     SNDPLAY2
        BRA     FIN
        
        MOVE.B  #72,D0          ;REPRODUCIR SONIDO
        MOVE.B  #1,D1
        TRAP    #15
        
KILL    ADDQ.B  #1,SCONUMB
        JSR     AGLKILL         ;MATA EL AGENT

        JSR     SNDPLAY1          ;REPRODUCIR SONIDO
        
   
     
FIN     MOVEM.L (A7)+,D2-D3
        MOVEM.L (A7)+,D0-D1
   
        RTS
























*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
