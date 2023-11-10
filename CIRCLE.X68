
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
        JSR     .GETCORD
        TRAP    #15             ;DRAW CIRCLE
        RTS


.GETCORD:

    ;LEFT X
        MOVE.W  #SCRWIDTH/2,D1
        SUB.W   #RADINIC,D1
    
    ;UPPER Y
        MOVE.W  #SCRHEIGH/2,D2
        SUB.W   #RADINIC,D2
    
    ;RIGHT X
        MOVE.W  #SCRWIDTH/2,D3
        ADD.W   #RADINIC,D3
    
    ;LOWER Y
        MOVE.W  #SCRHEIGH/2,D4
        ADD.W   #RADINIC,D4
        RTS
    











*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
