
;==============================================================================
;CIRLCE INITIALIZATION
;==============================================================================


    
DRAWCIRC:
        
        MOVE.B  #80,D0
        MOVE.L  #COLFINA,D1
        TRAP    #15             ;SET PEN COLOR
    
        MOVE.B  #81,D0
        MOVE.L  #COLFINA,D1
        TRAP    #15             ;SET FILL COLOR

        MOVE.B  #88,D0
        CLR.L   D1
        CLR.L   D2
        CLR.L   D3
        CLR.L   D4
        JSR     .GETCORD
        TRAP    #15             ;DRAW CIRCLE
        RTS


.GETCORD:

    ;LEFT X
        MOVE.W  #SCRWIDTH/2,D1
        SUB.W   #RADINIC,D1
    
    ;UPPER Y
        MOVE.W  #SCRHEIGH/2,D3
        SUB.W   #RADINIC,D3
    
    ;RIGHT X
        MOVE.W  #SCRWIDTH/2,D2
        ADD.W   #RADINIC,D2
    
    ;LOWER Y
        MOVE.W  #SCRHEIGH,D4
        SUB.W   #RADINIC,D4
        RTS
    

*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
