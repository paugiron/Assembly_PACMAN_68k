; ==============================================================================
; TITLE       : PAC-MAN 68000
; DESCRIPTION : GAME IN MOTOROLA 68000 BASED ON PAC-MAN GAME
; AUTHOR      : JORDI FLORIT ENSENYAT
;               JOSEP GABRIEL FORN�S REYN�S
;               PAU GIR�N RODR�GUEZ
; ==============================================================================
            ORG    $1000

            INCLUDE "CONST.X68"
            INCLUDE "GHOST.X68"
            INCLUDE "PAC-MAN.X68"
            INCLUDE "SCORE.X68"
            INCLUDE "SYSCONST.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "SYSVARS.X68"
            INCLUDE "VARS.X68"
    
START:

;--- INITIALIZATION -----------------------------------------------------------

            JSR     SYSINIT
            JSR     PMINIT
            JSR     GSTINIT
            JSR     SCOINIT

.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

; UPDATE GAME LOGIC

            JSR     PMUPD
            JSR     GSTUPD            

; --- SYNC ---------------------------------------------------------------------

; --- PLOT ---------------------------------------------------------------------

            JSR     SCOPLOT
            JSR     PMPLOT
            JSR     GSTPLOT

            BRA     .LOOP


         

            SIMHALT             

            END    START        


*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
