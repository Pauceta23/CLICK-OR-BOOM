
;=====================================================================
;SYSTEM INITIALIZATION
;=====================================================================

SYSINIT:
            MOVEM.W  D0-D1,-(A7)
            MOVEM.W  D2-D3,-(A7)

            JSR     SCRINIT                   ; SYSTEM INIT
            MOVE.L  #BUFFUPD,($80)            ; INSTALLS A ROUTINE IN TRAP #0
            MOVE.L  #SNDPLAY,($84)
            MOVE.L  #SCRUPD, ($64)            ; INSTALLS A TIMED ROUTINE
            CLR.B   (FRAMCONT)
            MOVE.W   #1,(CIRCVEL)
            MOVE.W  SR,-(A7)
            ANDI.W  #$D8FF,(A7)               ; ENABLE INTS            

            MOVEM.W (A7)+, D2-D3
            MOVEM.W (A7)+, D0-D1
            
            RTE
RANINIT:

            CLR.W   (CIRCVEC)
            RTS


; -----------------------------------------------------------------------------
SNDINIT:
;SOUND SYSTEM INIT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
        MOVEM.L D0-D1/A1-A2,-(A7)
        CLR.B   D1
        LEA     .SNDLIST,A2
.LOOP   MOVE.L  (A2)+,D0
        BEQ     .DONE
        MOVE.L  D0,A1
        MOVE.B  #71,D0
        TRAP    #15
        ADDQ.B  #1,D1
        BRA     .LOOP
.DONE   MOVEM.L (A7)+,D0-D1/A1-A2
        RTS
.SNDCLK     DC.B    'SND/HIT.wav',0
.SNDMISS    DC.B    'SND/MISS.wav',0
.SNDLIST    DC.L    .SNDCLK,.SNDMISS,0



; -----------------------------------------------------------------------------
SNDPLAY:
;SOUND SYSTEM INIT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

        RTE


; -----------------------------------------------------------------------------
SCRINIT:
; INITIALIZES THE SCREEN, SCREEN-RELATED INTERRUPT AND VARS.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
                        
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
            MOVEM.W D0-D1, -(A7)
            MOVEM.W D2-D3, -(A7)
            
            MOVE.W  #61,D0          ;LECTURA DEL RATOLÍ
            MOVE.W  #0,D1
            TRAP    #15
            
            MOVE.B  D0, MOUSCLIC     ;EMMAGATZEMAM SI S'HA CLICAT EL RATOLÍ
            MOVE.L  D1, D2          ;PROCÉS D'EXTRACCIÓ DE LA COORDENADA X
            ANDI.L  #$0000FFFF, D2
            MOVE.L  D2, MOUSCODX     ;EMMAGATZEMAM LA COORDENADA X
            
            MOVE.L  D1, D3          ;PROCÉS D'EXTRACCIÓ DE LA COORDENADA Y
            ANDI.L  #$FFFF0000, D3
            LSR.L   #8, D3
            LSR.L   #8, D3
            MOVE.L  D3, MOUSCODY     ;EMMAGATZEMAM LA COORDENADA Y
            
            MOVEM.W (A7)+, D2-D3            
            MOVEM.W (A7)+, D0-D1
            RTS
            
            









*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
