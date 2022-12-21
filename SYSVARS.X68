; ==============================================================================
; SYSTEM VARIABLES
; ==============================================================================
 
; --- KEYBOARD RELATED VARIABLES -----------------------------------------------

KBDVAL      DS.B    1                       ; KEY STATE
KBDEDGE     DS.B    1                       ; KEY EDGE

; --- TIMED INTERRUPT RELATED VARIABLES ----------------------------------------

SCRINTCT    DS.B    1                       ; INTERRUPT COUNTER
SCRCYCCT    DS.B    1                       ; CYCLE COUNTER
            DS.W    0        
            
; --- MAP RELATED VARIABLE -----------------------------------------------------

MAPVAR      DS.B    1024

            DS.B    0

POSCON      DS.W    1






*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
