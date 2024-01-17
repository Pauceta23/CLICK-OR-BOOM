*-----------------------------------------------------------
* Title      : PRACTICA FINAL 23-24
* Written by : Pau Belmonte Clemente & Enrique Grau Artigao
* Date       : 17/01/2024
* Description: Click the balls before they explode!
*-----------------------------------------------------------
            ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "LIB/DMMCONST.X68"
            INCLUDE "SYSCONST.X68"
            INCLUDE "MENU.X68"
            INCLUDE "CIRCLE.X68"
            INCLUDE "SCORE.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "LIB/AGLCODE.X68"
            INCLUDE "LIB/UTLCODE.X68"
            
addAgent    MACRO
            LEA CIRCINIT,A1
            LEA CIRCUPD,A2
            LEA DRAWCIRC,A3
            MOVE.W  #1,D0
            JSR     AGLADD
            ENDM
            
START:      
;---- INITIALIZATION ---------------------------------------------------------
            ORI     #$0700,SR     ;DESACTIVACIÓN DE INTS
            JSR     SYSINIT       ;INICIALITZACIÓ DEL SISTEMA Y PASO A MODO USUARIO
MENU        
            CLR.B   (LVLNUM)      ;PONEMOS A 0 EL NIVEL ESCOGIDO
            MOVE.B  #0,MOUSMODE   ;SELECCIONAMOS EL MODO DEL RATÓN QUE QUEREMOS
            JSR     MENUINIT
.LVL                              ;BUCLE DEL MENU
            JSR     MOUSINIT
            JSR     READMOU
            JSR     LVLCLIC 
            
            CMP.B   #0,LVLNUM     ;MIENTRAS NO SE ELIJA UN MENU BUCLE       
            BEQ     .LVL
            
            TRAP    #0
            CLR.W   CIRCVEC
            MOVE.B  #30, CIRCPAC
            CLR.B   FRAMCONT
            MOVE.W  #1, CIRCVEL
            JSR     DMMINIT       ;INICIALIZACIÓN DELS AGENTS (CERCLES)
            JSR     SCOINIT
            JSR     SNDINIT
            
            ;AÑADIMOS EL PRIMER CIRCULO
            addAgent             
            
            CLR.B   (COUNTER)
            
LOOP:      
;---- UPDATE -----------------------------------------------------------------

            MOVE.L  D0,-(A7)
            ADDQ.B  #1,(COUNTER)  ;AÑADIMOS 1 AL CONTADOR DE AGENTES
            MOVE.B  (CIRCPAC),D0
            CMP.B   (COUNTER),D0  ;SI HA LLEGADO A 30
            BNE     SALTO         ;NO SALTA 
            CLR.B   (COUNTER)     ;REINICIA EL CONTADOR
            
            CMP.W   #250,(CIRCVEC)
            BNE     SIGUE
            JSR     RANINIT       ;CUANDO ACABA EL VECTOR SE REINICIA
SIGUE
            ADDQ.W  #2,(CIRCVEC)  ;AUMENTA EL ÍNDICE DEL NIVEL DE LOS CIRCULOS
            CMP.W   #100,(CIRCVEC)
            BNE   VEL2
             
            ADDQ.W  #1,(CIRCVEL)  ;AUMENTA LA VELOCIDAD DE CRECIMIENTO
            SUB.B  #3,(CIRCPAC)   ;AUMENTA LA VELOCIDAD A LA QUE APARECEN
VEL2
            CMP.W   #200,(CIRCVEC)
            BNE     VEL3
            ADDQ.W  #1,(CIRCVEL)  ;AUMENTA LA VELOCIDAD DE CRECIMIENTO
            SUBQ.B  #3,(CIRCPAC)  ;AUMENTA LA VELOCIDAD A LA QUE APARECEN
VEL3            
            ;AÑADIMOS UN CIRCULO MÁS
            addAgent            
            MOVE.L  (A7)+,D0
SALTO       JSR     MOUSINIT     ;A CADA ITERACIÓN REINICIAMOS EL ESTADO DEL RATÓN

;READ INPUT DEVICES

            JSR     READMOU       ;LECTURA DE RATÓN
    
;UPDATE GAME ELEMENTS

            JSR     AGLUPD        ;ACTUALITZAMOS LOS CIRCULOS
                                  
;---- SYNCRONIZATION ---------------------------------------------------------

WINT        TST.B   (SCRINTCT)    ;BUCLE DONDE ESPERA HASTA QUE LLEGUE LA SEÑAL 
            BEQ     WINT          ;DE LA SINCRONIZACIÓN
            CLR.B   (SCRINTCT)

;---- DRAWING ----------------------------------------------------------------
            
            JSR     AGLPLOT      ;DIBUJA LOS AGENTES (CIRCULOS)
            JSR     SCOPLOT      ;DIBUJA EL MARCADOR

            TRAP    #0           ;INTERCAMBIA LOS BUFFERS (OCULT<->VISIBLE)

;---- CHECK IF GAME OVER -----------------------------------------------------

            CMPI.B  #0,(SCOLIFE)    ;SI LAS VIDAS NO HAN LLEGADO A 0
            BNE     LOOP            ;SUBE Y CONTINUA EL JUEGO
            BRA     MENU            ;SI NO, VOLVEMOS AL MENÚ INICIAL

FFIN:       SIMHALT             
            
            INCLUDE "VARS.X68"
            INCLUDE "SYSVARS.X68"
            INCLUDE "LIB/UTLVARS.X68"  
            INCLUDE "LIB/DMMVARS.X68"
          

            END     START        































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
