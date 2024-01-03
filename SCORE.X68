; ==============================================================================
; SCOREBOARD MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
SCOINIT
; INITIALIZE SCOREBOARD
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.B   (SCONUMB)
            MOVE.B  #3,(SCOLIFE)  ;INICIALITACIÓ DE LES VIDES
            RTS
            
; ------------------------------------------------------------------------------
SCOPLOT
; PLOT THE SCOREBOARD
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D1/A1,-(A7)

            ; SET BACKGROUND COLOR
            MOVE.B  #81,D0
            MOVE.L  #SCOFCOL,D1
            TRAP    #15
            
            ; SET FIRST LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE1,D1
            TRAP    #15

            ; PRINT FIRST LINE
            LEA     .LIFESCOU,A1
            CLR.L   D1
            MOVE.B  (SCOLIFE),D1
            MOVE.B  #17,D0
            TRAP    #15

            ; SET SECOND LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE2,D1
            TRAP    #15

            ; PRINT SECOND LINE
            LEA     .CIRCLCOU,A1
            CLR.L   D1
            MOVE.B  (SCONUMB),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1/A1
            
            RTS
            
.LIFESCOU   DC.B    'LIFES :',0
.CIRCLCOU   DC.B    'CIRCLES HIT:',0
            DS.W    0




*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
