*-----------------------------------------------------------
* Title      : PRACTICA GINAL 23-24
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
                ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "SYSCONST.X68"
            INCLUDE "CIRCLE.X68"
            INCLUDE "VARS.X68"
            ;INCLUDE "SCORE.X68"
            INCLUDE "SYSVARS.X68"
            INCLUDE "SYSTEM.X68"


START:            
            CLR     (CIRCVEL)
            MOVE.W  #4,D5
            JSR     SYSINIT
            JSR     CIRCINIT
.LOOP:      
            ADDQ.W  #2,(CIRCRAD)
            JSR     DRAWCIRC
            CMPI.W  #RADFINA,CIRCRAD
            BLT     .LOOP

* Put program code here

    SIMHALT             ; halt simulator
            
* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
