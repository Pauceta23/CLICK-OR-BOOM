*-----------------------------------------------------------
* Title      : PRACTICA FINAL 23-24
* Written by : Pau Belmonte & Enrique Grau
* Date       : Last upd: 01/12/2023
* Description: Game which consists of clicking on growing 
*              cercles before they get to their maximum size
*-----------------------------------------------------------
            ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "LIB/DMMCONST.X68"
            INCLUDE "SYSCONST.X68"
            INCLUDE "VARS.X68"
            INCLUDE "SYSVARS.X68"
            INCLUDE "LIB/UTLVARS.X68"
            INCLUDE "CERCLE.X68"
            ;INCLUDE "SCORE.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "LIB/AGLCODE.X68"
            
            INCLUDE "LIB/UTLCODE.X68"
            INCLUDE "LIB/DMMVARS.X68"
START:      
;---- INITIALIZATION ---------------------------------------------------------
            ORI     #$0700,SR       ; DISABLE INTS 
    
            JSR     SYSINIT         ; SYSTEM INITIALIZATION
            JSR     DMMINIT         ; AGENTS (CERCLES) INITIALIZATION
            MOVE.W  #3,(SCOLIFE)    ; LIFES INITIALIZATION
*            JSR     SCOREINIT       ; **(FOR THE FUTURE)** SCORE INITIALIZATION
            
            LEA CIRCINIT,A1         ; MOVE CERCLE INITIALIZATION 
            LEA CIRCUPDA,A2         ; MOVE CERCLE UPDATE
            LEA CIRCDRAW,A3         ; MOVE CERCLE DRAWING
            
            MOVE.W  #1,D0           ; IF D0==0 THE FOLLOWING SUBRUTINE DOESN'T WORK
            JSR     AGLADD          ; CREATES A NEW AGENT (CERCLE)
LOOP:      
;---- UPDATE -----------------------------------------------------------------

;READ INPUT DEVICES

            JSR     READMOU         ; READ MOUSE INPUT

    ******RELLENAR CON LECTURA DEL RATÓN O TECLADO
    
;UPDATE GAME ELEMENTS
*            JSR CIRCUPD
            JSR AGLUPD              ;UPDATE AGENTS (CERCLES)
            
    ******AÑADIR EL PROCESAMIENTO DE LAS LECTURAS ANTES REALIZADAS (VIDAS Y SCORE)

;---- SYNCRONIZATION ---------------------------------------------------------

WINT        TST.B   (SCRINTCT)      ; SCRINTCT IS A TIMED INT
            BEQ     WINT            ; WE USE IT TO HAVE A CONSTANT FRAME-RATE
            CLR.B   (SCRINTCT)      ; ONCE IT HAS PUT 1, WE RESET IT TO 0 AND CONTINUE

;---- DRAWING ----------------------------------------------------------------
            
*            JSR     DRAWCIRC
            JSR     AGLPLOT         ; DRAW AGENTS (CERCLES) 
*            JSR     DRAWSCOR
            TRAP    #0              ;UPDATE DOUBLE BUFFER
            
;COMO ESTÁ AHORA EL PROGRAMA ACABA AL LLEGAR LA PELOTA A SU RADIO MÁXIMO,
;CAMBIAR ESTO POR QUE EL JUGADOR PIERDA UNA VIDA

            CMPI    #2,(SCOLIFE)    ; COMPARE IF WE STILL HAVE LIFES
            BEQ     FIN             ; IF NOT THE GAME ENDS 
            BRA     LOOP            ; ELSE THE GAME CONTINUES

FIN         SIMHALT             
            END     START        















*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
