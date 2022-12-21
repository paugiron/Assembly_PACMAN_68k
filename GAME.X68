; ==============================================================================
; GAME MANAGEMENT
; ==============================================================================

; ------------------------------------------------------------------------------
GAMINIT
; INITIALIZES GAME.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     SYSINIT
            JSR     PMINIT
            JSR     MAPINIT
            JSR     GSTINIT
            BRA     SCOINIT

; ------------------------------------------------------------------------------
GAMUPD
; UPDATES THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            BRA     PMUPD
            
; ------------------------------------------------------------------------------
GAMPLOT
; PLOTS THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     MAPPLOT
            JSR     SCOPLOT
            JSR     PMPLOT
            BRA     GSTPLOT

*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
