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
            
            MOVEM.W D0-D1,-(A7)
            
            MOVE.W  (PMVELX),D0
            MOVE.W  (PMVELY),D1
            
            BTST.B  #0,(KBDVAL)
            BEQ     .NOTPRESSLEFT
            NEG.W   D0
            BRA     .ACTX
.NOTPRESSLEFT
            BTST.B  #2,(KBDVAL)
            BEQ     .NOTPRESSRIGHT
            BRA     .ACTX
.NOTPRESSRIGHT
            BTST.B  #1,(KBDVAL)
            BEQ     .NOTPRESSUP
            NEG     D1
            BRA     .ACTY
.NOTPRESSUP
            BTST.B  #3,(KBDVAL)
            BEQ     .NOTPRESSDOWN
            BRA     .ACTY
.NOTPRESSDOWN
            BRA     .NOTPRESSED
 
.ACTX
            ADD.W   D0,(PMPOSX)
            BRA     .DONE
            
.ACTY
            ADD.W   D1,(PMPOSY)
         
.DONE     
.NOTPRESSED
            MOVEM.W (A7)+,D0-D1
            
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
