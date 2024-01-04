;==============================================================================
;CIRCLE MANAGMENT  (AGENT)
;CIRCRAD (W)    (A0)
;CIRCVEC (W)    2(A0)


;==============================================================================

;------------------------------------------------------------------------------
CIRCINIT:
;CIRLCE INITIALIZATION
;INPUT: A0 (POINTER VARIABLES)
;OUTPUT:
;------------------------------------------------------------------------------


        MOVE.B  #80,D0
        MOVE.L  #BLACK,D1
        TRAP    #15             ;SET PEN COLOR
    
        MOVE.B  #81,D0
        MOVE.L  #RED,D1
        TRAP    #15             ;SET FILL COLOR

        MOVE.W   #RADINIC,(A0)
        MOVE.W  (CIRCVEC),2(A0)
        
        
        RTS
    
;------------------------------------------------------------------------------        
DRAWCIRC:
;CIRCLE PLOT
;INPUT: A0 (POINTER VARIABLES)
;OUTPUT:
;------------------------------------------------------------------------------

       
;COLOR SELECTOR

        MOVE.B  #81,D0
        CLR.L   D1
        MOVE.B  1(A0),D1
        ADD.B   #100,D1
        
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
        ;DIBUIXAM EL CERCLE       
        MOVE.B  #88,D0
        JSR     GETCORD         
        TRAP    #15             
        
        ;RESTABLIM EL COLORETJAT PER DEFECTE
        MOVE.B  #81,D0          
        MOVE.L  #RED,D1
        TRAP    #15
        
        MOVEM.L (A7)+,D0-D6/A1-A2

        RTS

GETCORD:
        MOVE.W  D6,-(A7)
        
        LEA     LVL1X,A2
        LEA     LVL1Y,A1
        
        MOVE.W  2(A0),D6

    ;LEFT X
        MOVE.W  (A2,D6.W),D1
        SUB.W   (A0),D1
    
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
        
        ;COMPROVAR SI HA EXPLOTAT
        CMPI.W  #RADFINA,(A0) 
        BGT     BOOM
        
        ;COMPROVAR SI S'HA CLICAT
        TST.B   (MOUSCLIC)
        BEQ     ALIVE           ;SI HI HA UN 0, NO S'HA CLICAT EL CERCLE SEGUR QUE ES VIU
        
        ;COMENÇAM A CALCULAR A VEURE SI S'HA CLICAT DINS DEL CERCLE
        JSR     GETCORD         ;UTILITZAREM ELS VALORS DE D1 I D2 PER OBTENIR EL CENTRE
        ADD.W   (A0),D1
        ADD.W   (A0),D2         ;D1 COORDENADES X I D2 COORDENADES Y DEL CENTRE
        
        ;COMENÇAM ELS CÀLCULS UTILITZANT LA FÓRMULA DE LA DISTÀNCIA ELEVADA A 2
        * d = sqrt((x2-x1)^2 + (y2-y1)^2) => d^2 >= (x2-x1)^2 + (y2-y1)^2
        SUB.W   (MOUSCODX),D1   ;CALCULAM LES DIFERENCIES ENTRE X I Y
        SUB.W   (MOUSCODY),D2
        
        MULS    D1,D1           ;CALCULAM EL QUADRAT DE LES DIFERENCIES
        MULS    D2,D2
        
        ADD.L   D1,D2           ;LES SUMAM
        
        MOVE.W  (A0),D3         ;OBTENIM EL RADI I CALCULAM EL SEU QUADRAT
        MULU    D3,D3
        
        CMP.L   D3,D2           ;SI LA DISTANCIA ES MENOR AL RADI
        BLT     KILL            ;S'HA FET CLICK ENDINS, ES MATA EL CERCLE
                    
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
        BRA     FIN
        
KILL    ADDQ.B  #1,SCONUMB
        JSR     AGLKILL         ;MATA L'AGENT
   
     
FIN     MOVEM.L (A7)+,D2-D3
        MOVEM.L (A7)+,D0-D1
   
        RTS



















*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
