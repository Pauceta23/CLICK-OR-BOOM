*-----------------------------------------------------------
* Title      : PRACTICA FINAL 23-24
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
            ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "LIB/DMMCONST.X68"
            INCLUDE "SYSCONST.X68"
            INCLUDE "VARS.X68"
            INCLUDE "SYSVARS.X68"
            INCLUDE "LIB/UTLVARS.X68"
            INCLUDE "CIRCLE.X68"
            ;INCLUDE "SCORE.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "LIB/AGLCODE.X68"
            
            INCLUDE "LIB/UTLCODE.X68"
            INCLUDE "LIB/DMMVARS.X68"
START:      
;---- INITIALIZATION ---------------------------------------------------------
            ORI     #$0700,SR     
            JSR     SYSINIT
            JSR     DMMINIT
            MOVE.W  #3,(SCOLIFE)
            ;JSR     CIRCINIT
            
            
LOOP:      
;---- UPDATE -----------------------------------------------------------------

;READ INPUT DEVICES

            JSR     READMOU
            LEA CIRCINIT,A1
            LEA CIRCUPD,A2
            LEA DRAWCIRC,A3
            MOVE.W  #1,D0
            JSR     AGLADD


    ******RELLENAR CON LECTURA DEL RATÓN O TECLADO
    
;UPDATE GAME ELEMENTS
            ;JSR CIRCUPD
            JSR AGLUPD
    ******AÑADIR EL PROCESAMIENTO DE LAS LECTURAS ANTES REALIZADAS

;---- SYNCRONIZATION ---------------------------------------------------------

WINT        TST.B   (SCRINTCT)
            BEQ     WINT
            CLR.B   (SCRINTCT)

;---- DRAWING ----------------------------------------------------------------
            
            ;JSR     DRAWCIRC
            JSR      AGLPLOT
            TRAP    #0
            ;JSR     DRAWSCOR
            ;TRAP    #0         ;UPDATE DOUBLE BUFFER
            
;COMO ESTÁ AHORA EL PROGRAMA ACABA AL LLEGAR LA PELOTA A SU RADIO MÁXIMO,
;CAMBIAR ESTO POR QUE EL JUGADOR PIERDA UNA VIDA

            CMPI    #2,(SCOLIFE)
            BEQ     FIN
            BRA     LOOP
FIN

            SIMHALT             
            
            

            END     START        












*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
