*-----------------------------------------------------------
* Title      : PRACTICA GINAL 23-24
* Written by : PAU BELMONTE & ENRIQUE GRAU
* Date       : 
* Description: El juego consiste en circulos que salen de
* manera aleatoria y van creciendo con el tiempo, el objetivo
* es clicarlos con el ratón antes de que lleguen a su tamaño
* final y pierdas una vida. Cada cierto tiempo, estos circulos
* crecen más rapido complicandolo más.
*-----------------------------------------------------------
                ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "SYSCONST.X68"
            INCLUDE "CIRCLE.X68"
            INCLUDE "VARS.X68"
            INCLUDE "SCORE.X68"
            INCLUDE "SYSVARS.X68"


START:                  ; first instruction of program

* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
