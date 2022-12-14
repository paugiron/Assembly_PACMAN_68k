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
GSTLAMO     DS.B    1                       ; GST LAST MOVEMENT (X OR Y)
GSTPOSMV    DS.B    1                       ; GST POSSIBLE MOVEMENTS (R,L,U,D)
GSTDEAD     DS.B    1                       ; GST BOOLEAN DEAD
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
