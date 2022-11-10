; ==============================================================================
; PAC-MAN MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
PMINIT
; INITIALIZE PAC-MAN.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVE.W  #SCRWIDTH/2,(PMPOSX)
            MOVE.W  #SCRHEIGH/2,(PMPOSY)
            MOVE.W  #PMSPEED,(PMVELX)
            MOVE.W  #PMSPEED,(PMVELY)

            RTS
            
; ------------------------------------------------------------------------------
PMUPD
; UPDATES THE PAC-MAN.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            RTS
            
; ------------------------------------------------------------------------------
PMPLOT
; PLOT THE BALL.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D4,-(A7)

            ;SET PEN COLOR
            MOVE.W  #80,D0
            MOVE.L  #PMPCOL,D1
            TRAP    #15
            
            ;SET FILL COLOR
            MOVE.W  #81,D0
            MOVE.L  #PMFCOL,D1
            TRAP    #15
            
            ;SET COORDS
            MOVE.W  (PMPOSX),D1
            SUB.W   #PMRAD,D1
            MOVE.W  (PMPOSY),D2
            SUB.W   #PMRAD,D2
            
            MOVE.W  D1,D3
            ADD.W   #PMRAD*2,D3
            MOVE.W  D2,D4
            ADD.W   #PMRAD*2,D4
              
            ;DRAW PAC-MAN
            MOVE.W  #88,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4
            
            RTS


*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
