; ==============================================================================
; TITLE       : PAC-MAN 68000
; DESCRIPTION : GAME IN MOTOROLA 68000 BASED ON PAC-MAN GAME
; AUTHOR      : JORDI FLORIT ENSENYAT
;               JOSEP GABRIEL FORNES REYNES
;               PAU GIRON RODRIGUEZ
; ==============================================================================
            ORG    $1000

            INCLUDE "CONST.X68"
            INCLUDE "GHOST.X68"
            INCLUDE "PAC-MAN.X68"
            INCLUDE "SCORE.X68"
            INCLUDE "SYSCONST.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "MAP.X68"
            
    
START:

;--- INITIALIZATION -----------------------------------------------------------

            ORI.W   #$0700,SR               ;DISABLE INTERRUPTIONS

            JSR     SYSINIT
            JSR     PMINIT
            JSR     MAPINIT
            JSR     GSTINIT
            JSR     SCOINIT

.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

            TRAP    #1

; UPDATE GAME LOGIC

            JSR     PMUPD
           ;JSR     GSTUPD

; --- SYNC ---------------------------------------------------------------------
            ;WHILE THERES NO INTERRUPTS IN THE COUNTER THE PROGRAM WILL BE IN
            ;THE BUCLE
            
.WAITINIT   TST.B   (SCRINTCT)
            BEQ     .WAITINIT
            CLR.B   (SCRINTCT)

; --- PLOT ---------------------------------------------------------------------
            
            JSR     MAPPLOT
            JSR     SCOPLOT
            JSR     PMPLOT
            JSR     GSTPLOT
            
            
            
            TRAP    #0                      ;CHANGE BUFFER

            BRA     .LOOP

            SIMHALT  
           
            INCLUDE "SYSVARS.X68"
            INCLUDE "VARS.X68"
            
            END    START        



















*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
