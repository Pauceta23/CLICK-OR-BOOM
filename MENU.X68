*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
*    ORG    $1000
*START:                  ; first instruction of program
*            MOVE.L  #1600<<16|800,D1 ; SET RESOLUTION
*            MOVE.B  #33,D0
*            TRAP    #15
*            MOVE.L  #1,D1                     ; SET WINDOWED MODE
*            TRAP    #15
MENUINIT:            
            JSR     CHANBLUE

            
            MOVE.B  #87,D0
            MOVE.W  #220,D1                     ;LEFT
            MOVE.W  #540,D2                     ;UP
            MOVE.W  #380,D3                     ;RIGHT
            MOVE.W  #620,D4                     ;DOWN
            TRAP    #15
            
            JSR     CHANGREE
            
            MOVE.B  #87,D0
            MOVE.W  #570,D1                     ;LEFT
            MOVE.W  #540,D2                     ;UP
            MOVE.W  #730,D3                     ;RIGHT
            MOVE.W  #620,D4                     ;DOWN
            TRAP    #15
            
            JSR     CHANRED
            
            MOVE.B  #87,D0
            MOVE.W  #920,D1                     ;LEFT
            MOVE.W  #540,D2                     ;UP
            MOVE.W  #1080,D3                     ;RIGHT
            MOVE.W  #620,D4                     ;DOWN
            TRAP    #15

            MOVE.B  #11,D0
            MOVE.W  #$7A26,D1
            TRAP    #15
            
            LEA     LVL3T,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            JSR     CHANGREE
            
            MOVE.B  #11,D0
            MOVE.W  #$4E26,D1
            TRAP    #15
            
            LEA     LVL2T,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            JSR     CHANBLUE
            
            MOVE.B  #11,D0
            MOVE.W  #$2226,D1
            TRAP    #15
            
            LEA     LVL1T,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            
            SIMHALT

CHANBLUE:
            MOVE.B  #80,D0
            MOVE.L  #$00550000,D1
            TRAP    #15
            
            MOVE.B  #81,D0
            MOVE.L  #$00FF0000,D1
            TRAP    #15
            RTS

CHANGREE:
            MOVE.B  #80,D0
            MOVE.L  #$00005500,D1
            TRAP    #15
            
            MOVE.B  #81,D0
            MOVE.L  #$0000FF00,D1
            TRAP    #15
            RTS
            
CHANRED:
            MOVE.B  #80,D0
            MOVE.L  #$00000055,D1
            TRAP    #15
            
            MOVE.B  #81,D0
            MOVE.L  #$000000FF,D1
            TRAP    #15
            RTS



    SIMHALT             ; halt simulator
LVL1T   DC.B    ' LVL 1',0
LVL2T   DC.B    ' LVL 2',0
LVL3T   DC.B    ' LVL 3',0
* Put variables and constants here

*    END    START        ; last line of source

*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
