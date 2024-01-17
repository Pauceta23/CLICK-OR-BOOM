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
            ;INCLUDE "MENU.X68"
            INCLUDE "CIRCLE.X68"
            INCLUDE "SCORE.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "LIB/AGLCODE.X68"
            INCLUDE "LIB/UTLCODE.X68"
            
addAgent   MACRO
            LEA CIRCINIT,A1
            LEA CIRCUPD,A2
            LEA DRAWCIRC,A3
            MOVE.W  #1,D0
            JSR     AGLADD
            ENDM
            
START:      
;---- INITIALIZATION ---------------------------------------------------------
            ORI     #$0700,SR     ;DESACTIVACIÓ DE INTERRUPCIONS I MODE USUARI
            JSR     SYSINIT       ;INICIALITZACIÓ DEL SISTEMA
            ;JSR     MENUINIT
;.MENU       BRA     .MENU
            JSR     DMMINIT       ;INICIALITZACIÓ DELS AGENTS (CERCLES)
            JSR     SCOINIT
            JSR     SNDINIT
            
            ;AFEGIM EL PRIMER CERCLE
            addAgent             
            
            ;ADDQ.W  #2,(CIRCVEC)
            CLR.B   (COUNTER)
            
LOOP:      
;---- UPDATE -----------------------------------------------------------------

            MOVE.L  D0,-(A7)
            ADDQ.B  #1,(COUNTER)  ;AFEGIM 1 AL CONTADOR DE CERCLES
            MOVE.B  (CIRCPAC),D0
            CMP.B   (COUNTER),D0 ;SI HA ARRIBAT A 30
            BNE     SALTO         ;NO BOTA 
            CLR.B   (COUNTER)     ;REINICIA EL COMPTADOR
            
            CMP.W   #250,(CIRCVEC)
            BNE     SIGUE
            JSR     RANINIT     ;CUANDO ACABA EL VECTOR SE REINICIA
SIGUE
            ADDQ.W  #2,(CIRCVEC)  ;AUMENTA L'INDEX DEL NIVELL DELS CERCLES
            CMP.W   #100,(CIRCVEC)
            BNE   VEL2
             
            ADDQ.W  #1,(CIRCVEL)
            SUB.B  #3,(CIRCPAC) 
VEL2
            CMP.W   #200,(CIRCVEC)
            BNE     VEL3
            ADDQ.W  #1,(CIRCVEL)
            SUBQ.B  #3,(CIRCPAC) 
VEL3            
            ;AFEGIM UN CERCLE MÉS
            addAgent            
            MOVE.L  (A7)+,D0
SALTO       JSR     MOUSINIT    ;A CADA ITERACIÓ REINICIAM L'ESTAT DEL RATOLÍ

;READ INPUT DEVICES

            JSR     READMOU       ;LECTURA DE RATOLÍ
    
;UPDATE GAME ELEMENTS

            JSR     AGLUPD        ;ACTUALITZAM ELS CERCLES
                                  
;---- SYNCRONIZATION ---------------------------------------------------------

WINT        TST.B   (SCRINTCT)    ;BUCLE ON ESPERA FINS QUE ARRIBI LA SENYAL 
            BEQ     WINT          ;DE SINCRONISME I PUGUI CONTINUAR
            CLR.B   (SCRINTCT)

;---- DRAWING ----------------------------------------------------------------
            
            JSR     AGLPLOT      ;DIBUIXA ELS AGENTS (CERCLES)
            JSR     SCOPLOT      ;DIBUIXA EL MARCADOR

            TRAP    #0           ;INTERCANVIA ELS BUFFERS (OCULT<->VISIBLE)

;---- CHECK IF GAME OVER -----------------------------------------------------

            CMPI.B  #0,(SCOLIFE)    ;SI LES VIDES NO HAN ARRIBAT A 0
            BNE     LOOP            ;TORNAM CAP AMUNT I CONTINUA EL JOC

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
