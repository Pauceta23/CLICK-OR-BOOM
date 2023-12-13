;=====================================================================
;SYSTEM INITIALIZATION
;=====================================================================

SYSINIT:
            JSR SCRINIT
            MOVE.L  #BUFFUPD,($80)      ;INSTALLS A ROUTINE IN TRAP #0
            MOVE.L  #SCRUPD, ($64)
            CLR.B   (FRAMCONT)
            MOVE.W   #1,(CIRCVEL)
            MOVE.W  SR,-(A7)
            ANDI.W  #$D8FF,(A7)               ; ENABLE INTS
            MOVE.W  #60,D0
            MOVE.W  #3<<8|1,D1
            TRAP    #15
            RTE


RANINIT:

        CLR.W   (CIRCVEC)
        RTS


; -----------------------------------------------------------------------------
SCRINIT:
; INITIALIZES THE SCREEN, SCREEN-RELATED INTERRUPT AND VARS.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.W D0-D1,-(A7)
            
            ;MOVE.L  #SCRUPD,($84) ; INSTALL TRAP
            
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH,D1 ; SET RESOLUTION
            MOVE.B  #33,D0
            TRAP    #15
            MOVE.L  #1,D1                     ; SET WINDOWED MODE
            TRAP    #15
            
            MOVE.W  #$FF00,D1                 ; CLEAR VISIBLE BUFFER
            MOVE.B  #11,D0
            TRAP    #15
            
            MOVE.B  #17,D1                    ; ENABLE DOUBLE BUFFER
            MOVE.B  #92,D0
            TRAP    #15
            
            MOVE.W  #$FF00,D1                 ; CLEAR HIDDEN BUFFER
            MOVE.B  #11,D0
            TRAP    #15
            
            MOVE.B  #32,D0                    ;CREACIÓ DE TIMED INT
            MOVE.B  #6,D1
            MOVE.B  #$81,D2                   ;8(HABILITAR INT) 1(QUINA INT)
            MOVE.L  #1000/FRAMRATE,D3         ;FER AQUESTA INT CADA X ms
            ;MOVE.L  #10,D3                    ;FER AQUESTA INT CADA X ms
            TRAP    #15
    
            CLR.B   (SCRINTCT)                                             
            
*           MOVE.L  #SCRISR,($60+SCRIRQ*4)    ; SET EXCEPTION VECTOR
*           MOVE.B  #5,D1                     ; ENABLE EXCEPTION PROCESSING
*           MOVE.B  #32,D0
*           TRAP    #15
*           MOVE.B  #%10000000|SCRIRQ,D2      ; ENABLE AUTO-IRQ
*           MOVE.B  #SCRTIM,D3
*           MOVE.B  #6,D1
*           MOVE.B  #32,D0
*           TRAP    #15
*           CLR.B   (SCRINTCT)                ; PREPARE INTERRUPT FLAG
*           CLR.B   (SCRCYCCT)                ; PREPARE CYCLE COUNTER
 
            MOVEM.W (A7)+,D0-D1
            RTS

; -----------------------------------------------------------------------------
BUFFUPD:
; SWITCHES THE BUFFERS AND CLEARS THE HIDDEN ONE 
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.W D0-D1,-(A7)
            
            ; SWITCH BUFFERS
            MOVE.B  #94,D0
            TRAP    #15
           
            ; CLEAR HIDDEN BUFFER
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15  
            
            MOVEM.W (A7)+,D0-D1
            RTE

;-----------------------------------------------------------------------------            
SCRUPD
; TIMED INTERRUPT
;
;
;
;-----------------------------------------------------------------------------
            ADDQ.B  #1,(SCRINTCT)
            RTE
            
            
;-----------------------------------------------------------------------------             
READMOU
;READ MOUSE VARIABLES
;            
;
;
;----------------------------------------------------------------------------- 
            MOVEM.W  D0-D1,-(A7)
            MOVE.W  #61,D0
            MOVE.W  #2,D1
            TRAP    #15
            
            MOVEM.W (A7)+,D0-D1
            RTS
            
            





*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
