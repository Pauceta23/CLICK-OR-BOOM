


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
        MOVE.L  #$000000FF,D1
        TRAP    #15             ;SET PEN COLOR
    
        MOVE.B  #81,D0
        MOVE.L  #$000000FF,D1
        TRAP    #15             ;SET FILL COLOR

        MOVE.W   #RADINIC,(A0)
        CLR.W  2(A0)
        ADDQ.W   #2,2(A0)
        RTS
    
;------------------------------------------------------------------------------        
    
DRAWCIRC:
;CIRCLE PLOT
;INPUT: A0 (POINTER VARIABLES)
;OUTPUT:
;------------------------------------------------------------------------------

       
        MOVEM.L D0-D6/A1-A2,-(A7)
        MOVE.B  #88,D0
        JSR     GETCORD
        TRAP    #15             ;DRAW CIRCLE
        MOVEM.L (A7)+,D0-D6/A1-A2
        CMPI.W  #RADFINA,(A0)
        BEQ     SUBLIFE
BACK:            

        RTS
SUBLIFE:
        SUBQ.W  #1,(SCOLIFE)
        BRA BACK

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

        MOVE.W  D0,-(A7)
        ADDQ.B  #2,(FRAMCONT)
        CMP.B   #5,(FRAMCONT)
        BGT     WINT
        MOVE.W  (CIRCVEL),D0
        ADD.W   D0,(A0)
        CLR.B   (FRAMCONT)
        MOVE.W  (A7)+,D0
        
        RTS












*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~








*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
