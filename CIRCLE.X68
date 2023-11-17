
;==============================================================================
;CIRLCE INITIALIZATION
;==============================================================================
CIRCINIT:

        MOVE.B  #80,D0
        MOVE.L  #$000000FF,D1
        TRAP    #15             ;SET PEN COLOR
    
        MOVE.B  #81,D0
        MOVE.L  #$000000FF,D1
        TRAP    #15             ;SET FILL COLOR

        ADD.W   #RADINIC,(CIRCRAD)
        CLR.W  (CIRCVEC)
        ADDQ.W   #2,(CIRCVEC)
        RTS
    
        
    
DRAWCIRC:
       
        MOVEM.L D0-D6/A0-A1,-(A7)
        MOVE.B  #88,D0
        JSR     .GETCORD
        TRAP    #15             ;DRAW CIRCLE
        MOVEM.L (A7)+,D0-D6/A0-A1
        RTS


.GETCORD:

        LEA RANDX,A0
        LEA RANDY,A1
        
        MOVE.W  (CIRCVEC),D6

    ;LEFT X
        MOVE.W  (A0,D6.W),D1
        SUB.W   (CIRCRAD),D1
    
    ;UPPER Y
        MOVE.W  (A1,D6.W),D2
        SUB.W   (CIRCRAD),D2
    
    ;RIGHT X
        MOVE.W  (A0,D6.W),D3
        ADD.W   (CIRCRAD),D3
    
    ;LOWER Y
        MOVE.W  (A1,D6.W),D4
        ADD.W   (CIRCRAD),D4
        RTS
    













*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~



*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
