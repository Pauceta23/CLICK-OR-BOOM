; ==============================================================================
; GAME VARIABLES
; ==============================================================================

; --- CERCLES RELATED VARIABLES-------------------------------------------------

CIRCVEL DS.W    1           ;CERCLE GROW SPEED
CIRCPOX DS.W    1           ;CERCLE X COORDINATE
CIRCPOY DS.W    1           ;CERCLE Y COORDINATE
CIRCCOL DS.W    1           ;CERCLE COLOR
CIRCPOS DS.W    1           ; 2(A0)
;CIRCRAD DS.W    1           ;CERCLE RADIUS     (A0)
CIRCVEC DC.W    0           ;CIRCLE RANDOM VECTOR 
CIRCPAC DC.B    30           ;CIRCLE PACE 
        DS.W    0




; --- SCOREBOARD RELATED VARIABLES ---------------------------------------------

SCONUMB DS.B    1           ;NUMBER OF CAPTURED CERCLES
SCOLIFE DS.B    1           ;NUMBER OF LIFES
        DS.W    0

; --- LEVEL RELATED VARIABLES ---------------------------------------------

LVLNUM  DC.B    3           ;LEVEL CHOOSE
        DS.W    0









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
