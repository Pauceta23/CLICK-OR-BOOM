
;=====================================================================
;SYSTEM INITIALIZATION
;=====================================================================

SYSINIT:

            JSR     SCRINIT                   ; INICIALIZACION DE SYSTEM
            CLR.W   (SCONUMB)
            MOVE.L  #BUFFUPD,($80)            ; INSTALAMOS RUTINAS EN TRAP #0
            MOVE.L  #SCRUPD, ($64)            ; INSTALAMOS UNA RUTINA TEMPORIZADA
            MOVE.W  SR,-(A7)
            ANDI.W  #$D8FF,(A7)               ; ACTIVAMOS INTERRUPCIONES           
            
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
.LOOP       MOVE.L  (A2)+,D0                  ;INICIALIZAMOS SONIDOS Y LOS PONEMOS EN LA LISTA
            BEQ     .DONE
            MOVE.L  D0,A1
            MOVE.B  #71,D0
            TRAP    #15
            ADDQ.B  #1,D1
            BRA     .LOOP
.DONE       MOVEM.L (A7)+,D0-D1/A1-A2
            RTS
.SNDCLK     DC.B    'SND/HIT.wav',0
.SNDMISS    DC.B    'SND/MISS.wav',0
.SNDLIST    DC.L    .SNDCLK,.SNDMISS,0



; -----------------------------------------------------------------------------
SNDPLAY1:
;SOUND SYSTEM PLAY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D1,-(A7)               ;SONIDO DE ACIERTO
            MOVE.B  #72,D0
            CLR.B   D1
            TRAP    #15
            MOVEM.L (A7)+,D0-D1

            RTS
        
; -----------------------------------------------------------------------------
SNDPLAY2:
;SOUND SYSTEM PLAY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

            MOVEM.L D0-D1,-(A7)               ;SONIDO DE FALLO
            MOVE.B  #72,D0
            MOVE.B  #1,D1
            TRAP    #15
            MOVEM.L (A7)+,D0-D1

            RTS

; -----------------------------------------------------------------------------
SCRINIT:
; INITIALIZES THE SCREEN, SCREEN-RELATED INTERRUPT AND VARS.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
                        
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH,D1 ; SET RESOLUCION
            MOVE.B  #33,D0
            TRAP    #15
            MOVE.L  #1,D1                     ; SET MODO VENTANA
            TRAP    #15
            
            MOVE.W  #$FF00,D1                 ; BORRAR VISIBLE BUFFER
            MOVE.B  #11,D0
            TRAP    #15
            
            MOVE.B  #17,D1                    ; ACTIVAR DOUBLE BUFFER
            MOVE.B  #92,D0
            TRAP    #15
            
            MOVE.W  #$FF00,D1                 ; BORRAR HIDDEN BUFFER
            MOVE.B  #11,D0
            TRAP    #15
            
            MOVE.B  #32,D0                    ;CREACIÓN DE TIMED INT
            MOVE.B  #6,D1
            MOVE.B  #$81,D2                   ;8(HABILITAR INT) 1(QUINA INT)
            MOVE.L  #1000/FRAMRATE,D3         ;HACER ESTA INT CADA X ms
            TRAP    #15
    
            CLR.B   (SCRINTCT)                                             
            
 
            RTS

; -----------------------------------------------------------------------------
BUFFUPD:
; SWITCHES THE BUFFERS AND CLEARS THE HIDDEN ONE 
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.W D0-D1,-(A7)
            
            ; CAMBIAR BUFFERS
            MOVE.B  #94,D0
            TRAP    #15
           
            ; BORRAR HIDDEN BUFFER
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15  
            
            MOVEM.W (A7)+,D0-D1
            RTE

;-----------------------------------------------------------------------------            
SCRUPD
; TIMED INTERRUPT
;
;-----------------------------------------------------------------------------
            ADDQ.B  #1,(SCRINTCT)
            RTE
            
           
;-----------------------------------------------------------------------------             
MOUSINIT
;INICIALITZA LES VARIABLES DEL RATOLÍ
;
;----------------------------------------------------------------------------- 

            CLR.W   MOUSCODX      
            CLR.W   MOUSCODY    
            CLR.B   MOUSCLIC  
            
            RTS
;-----------------------------------------------------------------------------             
READMOU
;READ MOUSE VARIABLES
;
;----------------------------------------------------------------------------- 
            MOVEM.L D0-D1, -(A7)
            MOVEM.L D2-D3, -(A7)
            CLR.L   D1
            
            MOVE.W  #61,D0           ;LECTURA DEL RATÓN
            MOVE.B  MOUSMODE,D1
            TRAP    #15
            
            BTST    #0,D0
            BEQ     .NOCLICAT
            MOVE.B  #1,MOUSCLIC
      
            MOVE.L  D1, D2           ;PROCESO DE EXTRACCIÓN DE LA COORDENADA X
            ANDI.L  #$0000FFFF, D2
            MOVE.W  D2, MOUSCODX     ;GUARDAMOS LA COORDENADA X
            
            MOVE.L  D1, D3           ;PROCESO D'EXTRACCIÓN DE LA COORDENADA Y
            ANDI.L  #$FFFF0000, D3
            LSR.L   #8, D3
            LSR.L   #8, D3
            MOVE.W  D3, MOUSCODY     ;GUARDAMOS LA COORDENADA Y
.NOCLICAT:             
            MOVEM.L (A7)+, D2-D3            
            MOVEM.L (A7)+, D0-D1
            RTS





















*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
