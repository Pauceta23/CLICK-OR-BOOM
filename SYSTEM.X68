;=====================================================================
;SYSTEM INITIALIZATION
;=====================================================================

SYSINIT:
            JSR SCRINIT
            MOVE.W  SR,-(A7)
            ANDI.W  #$D8FF,(A7)               ; ENABLE INTS
            RTE




; -----------------------------------------------------------------------------
SCRINIT:
; INITIALIZES THE SCREEN, SCREEN-RELATED INTERRUPT AND VARS.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - D0,D1,D2,D3
; -----------------------------------------------------------------------------
            ;MOVE.L  #SCRUPD,($80+SCRTRAP*4) ; INSTALL TRAP
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH,D1 ; SET RESOLUTION
            MOVE.B  #33,D0
            TRAP    #15
            MOVE.L  #1,D1                   ; SET WINDOWED MODE
            TRAP    #15
*           MOVE.W  #$FF00,D1               ; CLEAR VISIBLE BUFFER
*           MOVE.B  #11,D0
*           TRAP    #15
*           MOVE.B  #17,D1                  ; ENABLE DOUBLE BUFFER
*           MOVE.B  #92,D0
*           TRAP    #15
*           MOVE.W  #$FF00,D1               ; CLEAR HIDDEN BUFFER
*           MOVE.B  #11,D0
*           TRAP    #15
*           MOVE.L  #SCRISR,($60+SCRIRQ*4)  ; SET EXCEPTION VECTOR
*           MOVE.B  #5,D1                   ; ENABLE EXCEPTION PROCESSING
*           MOVE.B  #32,D0
*           TRAP    #15
*           MOVE.B  #%10000000|SCRIRQ,D2    ; ENABLE AUTO-IRQ
*           MOVE.B  #SCRTIM,D3
*           MOVE.B  #6,D1
*           MOVE.B  #32,D0
*           TRAP    #15
*           CLR.B   (SCRINTCT)              ; PREPARE INTERRUPT FLAG
*           CLR.B   (SCRCYCCT)              ; PREPARE CYCLE COUNTER
            
            RTS


*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
