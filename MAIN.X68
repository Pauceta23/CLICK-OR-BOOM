*-----------------------------------------------------------
* Title      : PRACTICA FINAL 23-24
* Written by : Pau Belmonte Clemente & Enrique Grau Artigao
* Date       : 13/12/2023
* Description: Click the balls before they explode!
*-----------------------------------------------------------
            ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "LIB/DMMCONST.X68"
            INCLUDE "SYSCONST.X68"

            INCLUDE "CIRCLE.X68"
            INCLUDE "SCORE.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "LIB/AGLCODE.X68"
            INCLUDE "LIB/UTLCODE.X68"
            
START:      
;---- INITIALIZATION ---------------------------------------------------------
            ORI     #$0700,SR     ;DESACTIVACIÓ DE INTERRUPCIONS I MODE USUARI
            JSR     SYSINIT       ;INICIALITZACIÓ DEL SISTEMA
            JSR     DMMINIT       ;INICIALITZACIÓ DELS AGENTS (CERCLES)
            JSR     RANINIT       
            JSR     SCOINIT
            MOVE.B  #3,(SCOLIFE)  ;INICIALITACIÓ DE LES VIDES
             
            LEA CIRCINIT,A1
            LEA CIRCUPD,A2
            LEA DRAWCIRC,A3
            MOVE.W  #1,D0
            ADDQ.W  #2,(CIRCVEC)
            JSR     AGLADD
            CLR.B   (COUNTER)
            
LOOP:      
;---- UPDATE -----------------------------------------------------------------

            ADDQ.B  #1,(COUNTER)  ;AFEGIM 1 AL CONTADOR DE CERCLES
            CMP.B   #30,(COUNTER) ;SI HA ARRIBAT A 30
            BNE     SALTO         ;NO BOTA 
            CLR.B   (COUNTER)     ;REINICIA EL COMPTADOR
            ADDQ.W  #2,(CIRCVEC)  ;PUJA LA VELOCITAT DE CREIXEMENT DELS CERCLES
            **AFEGIM CERCLES
            LEA CIRCINIT,A1
            LEA CIRCUPD,A2
            LEA DRAWCIRC,A3
            MOVE.W  #1,D0
            ADDQ.W  #2,(CIRCVEC)
            JSR     AGLADD
            **FI AFEGIM CERCLES
SALTO:      JSR     MOUSINIT

;READ INPUT DEVICES

            JSR     READMOU       ;LECTURA DE RATOLÍ
    
;UPDATE GAME ELEMENTS

            JSR     AGLUPD        ;ACTUALITZAM ELS CERCLES
                                  
;---- SYNCRONIZATION ---------------------------------------------------------

WINT        TST.B   (SCRINTCT)    ;BUCLE ON ESPERA FINS QUE ARRIBI LA SENYAL 
            BEQ     WINT          ;DE SINCRONISME I PUGUI CONTINUAR
            CLR.B   (SCRINTCT)

;---- DRAWING ----------------------------------------------------------------
            
            JSR     AGLPLOT      ;DIBUIXA AL BUFFER OCULT
            JSR     SCOPLOT      ;LA LECTURA DE RATOLÍ  

            TRAP    #0           ;INTERCANVIA ELS BUFFERS (OCULT<->VISIBLE)
            
;COMO ESTÁ AHORA EL PROGRAMA ACABA AL LLEGAR LA PELOTA A SU RADIO MÁXIMO,
;CAMBIAR ESTO POR QUE EL JUGADOR PIERDA UNA VIDA

            CMPI.B  #0,(SCOLIFE)
            BNE     LOOP

            SIMHALT             
            
            INCLUDE "VARS.X68"
            INCLUDE "SYSVARS.X68"
            INCLUDE "LIB/UTLVARS.X68"  
            INCLUDE "LIB/DMMVARS.X68"
          

            END     START        





















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
