; ==============================================================================
; GAME VARIABLES
; ==============================================================================

; --- PAC-MAN RELATED VARIABLES ------------------------------------------------

PMPOSX      DS.W    1                       ; PM X COORDINATE
PMPOSY      DS.W    1                       ; PM Y COORDINATE
PMVELX      DS.W    1                       ; PM X VELOCITY
PMVELY      DS.W    1                       ; PM Y VELOCITY
PMEAT       DS.B    1                       ; PM BOOLEAN EAT GST

; --- GHOST RELATED VARIABLES --------------------------------------------------

GSTPOSX     DS.W    1                       ; GST X COORDINATE
GSTPOSY     DS.W    1                       ; GST Y COORDINATE
GSTVELX     DS.W    1                       ; GST X VELOCITY
GSTVELY     DS.W    1                       ; GST Y VELOCITY
GSTDEAD     DS.B    1                       ; GST BOOLEAN DEAD

; --- SCOREBOARD RELATED VARIABLES ---------------------------------------------

SCOLIFE     DS.W    1                       ; NUMBER OF LIFES
SCOBNS      DS.W    1                       ; NUMBER OF BONUS

*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
