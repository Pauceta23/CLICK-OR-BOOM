*-----------------------------------------------------------
* Title      : PRACTICA FINAL 23-24
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
            INCLUDE "SYSTEM.X68"


START:      
;---- INITIALIZATION ---------------------------------------------------------
            ORI     #$0700,SR   
            CLR     (CIRCRAD)   
            JSR     SYSINIT
            JSR     CIRCINIT
.LOOP:      
;---- UPDATE -----------------------------------------------------------------
;READ INPUT DEVICES

    ;RELLENAR CON LECTURA DEL RATÓN O TECLADO
    
;UPDATE GAME ELEMENTS
            ADDQ.W  #2,(CIRCRAD)
            ;AÑADIR EL PROCESAMIENTO DE LAS LECTURAS ANTES REALIZADAS

;---- SYNCRONIZATION ---------------------------------------------------------
    ;RELLENAR CON EL VÍDEO TUT14

;---- DRAWING ----------------------------------------------------------------

            JSR     DRAWCIRC
            ;JSR     DRAWSCOR
            ;TRAP    #0         ;UPDATE DOUBLE BUFFER
            
;COMO ESTÁ AHORA EL PROGRAMA ACABA AL LLEGAR LA PELOTA A SU RADIO MÁXIMO,
;CAMBIAR ESTO POR QUE EL JUGADOR PIERDA UNA VIDA

            CMPI.W  #RADFINA,CIRCRAD
            BLT     .LOOP
            BRA     START

            SIMHALT             
            
            INCLUDE "SYSVARS.X68"

            END    START        


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
