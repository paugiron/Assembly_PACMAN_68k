; ==============================================================================
; GAME VARIABLES
; ==============================================================================

; --- PAC-MAN RELATED VARIABLES ------------------------------------------------

PMPOSX      DS.W    1                       ; PM X COORDINATE
PMPOSY      DS.W    1                       ; PM Y COORDINATE
PMVELX      DS.W    1                       ; PM X VELOCITY
PMVELY      DS.W    1                       ; PM Y VELOCITY
PMEAT       DS.B    1                       ; PM BOOLEAN EAT GST
PMLAMO      DS.B    1                       ; PM SAVE LAST MOVEMENT X O Y
            DS.B    0

; --- GHOST RELATED VARIABLES --------------------------------------------------

GSTPOSX     DS.W    1                       ; GST X COORDINATE
GSTPOSY     DS.W    1                       ; GST Y COORDINATE
GSTVELX     DS.W    1                       ; GST X VELOCITY
GSTVELY     DS.W    1                       ; GST Y VELOCITY
GSTDEAD     DS.B    1                       ; GST BOOLEAN DEAD
GSTLAMO     DS.B    1                       ; GST LAST MOVEMENT (X OR Y)
GSTINRNG    DS.B    1                       ; GST IS IN RANGE
GSTTARG     DS.B    1                       ; GST TARGET (0-PACMAN, 1-RANDOM)
GSTPOSMV    DS.B    1                       ; GST POSSIBLE MOVEMENTS (R,L,U,D)
            DS.B    0

; --- SCOREBOARD RELATED VARIABLES ---------------------------------------------

SCOLIFE     DS.W    1                       ; NUMBER OF LIFES
SCOPOINTS   DS.W    1                       ; NUMBER OF POINTS

; --- INTRO STATE RELATED VARIABLES --------------------------------------------

ISCTIMER    DS.W    1                       ; INTRO TIMER

; --- STATE RELATED VARIABLES --------------------------------------------------

STACUR      DS.W    1                       ; CURRENT STATE
STANEXT     DS.W    1                       ; NEXT STATE









*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
