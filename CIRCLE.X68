


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
        MOVE.L  #NEGRO,D1
        TRAP    #15             ;SET PEN COLOR
    
        MOVE.B  #81,D0
        MOVE.L  #ROJO,D1
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

        *CMPI.W  #RADFINA-50,(A0)
        *BLT     JUMP1
        MOVE.B  #81,D0
        CLR.L   D1
        MOVE.B  1(A0),D1
        ADD.B   #100,D1
        
        TRAP    #15


        
        


;BLANCO
        CMPI.W  #RADFINA-1,(A0)
        BLT     JUMP1
        MOVE.B  #81,D0
        MOVE.L  #COLFINA,D1
        TRAP    #15

;------------------------------------------------------------------------------          
        
JUMP1:  
        MOVEM.L D0-D6/A1-A2,-(A7)
        MOVE.B  #88,D0
        JSR     GETCORD
        TRAP    #15             ;DRAW CIRCLE
        
        
        MOVE.B  #81,D0
        MOVE.L  #ROJO,D1
        TRAP    #15
        

        MOVEM.L (A7)+,D0-D6/A1-A2
        *CMPI.W  #RADFINA,(A0)
        *BEQ     SUBLIFE
BACK:            

        RTS
SUBLIFE:
        *SUBQ.W  #1,(SCOLIFE)
        *BRA BACK

GETCORD:

        LEA RANDX,A2
        LEA RANDY,A1
        
        ;ADDQ.W   #2,(CIRCVEC)
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
        RTS
    
    
CIRCUPD:
        MOVEM.L D0-D1,-(A7)
        MOVEM.L D2-D3,-(A7)
        
        ;COMPROVAR SI HA EXPLOTAT
        CMPI.W  #RADFINA,(A0) 
        BGT     EXPLOTE
        
        ;COMPROVAR SI S'HA CLICAT
        MOVE.W  MOUSCODX,D1
        SUB.W   #RANDX,D1
        
        MOVE.W  MOUSCODY,D2
        SUB.W   #RANDY,D2
        
        MULS    D1,D1
        MULS    D2,D2
        
        ADD.W   D1,D2
        
        MULU    D2,D2
        MOVE.W  (A0),D3
        MULU    D3,D3
        
        CMP.W   D2,D3
        BGT     ALIVE
        JSR     AGLKILL
                    
ALIVE:        
        ADDQ.B  #2,(FRAMCONT)
        CMP.B   #5,(FRAMCONT)
        BGT     WINT
        MOVE.W  (CIRCVEL),D0
        ADD.W   D0,(A0)
        CLR.B   (FRAMCONT)
        BRA     FIN
EXPLOTE:
        SUBQ.B  #1,(SCOLIFE)
        JSR     AGLKILL
   
     
FIN     MOVEM.L (A7)+,D2-D3
        MOVEM.L (A7)+,D0-D1
   
        RTS

DISTX   DS.L    1
DISTY   DS.L    1














*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
