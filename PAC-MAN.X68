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
            ADDQ.W  #8,(PMPOSX)
            ADDQ.W  #8,(PMPOSY)
            MOVE.W  #PMSPEED,(PMVELX)
            MOVE.W  #PMSPEED,(PMVELY)
            CLR.B   (PMLAMO)

            RTS
            
; ------------------------------------------------------------------------------
PMUPD
; UPDATES THE PAC-MAN.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L D0-D6,-(A7)
            
            MOVE.W  #PMSPEED,D0
            
            
            MOVE.W  (PMPOSX),D2
            MOVE.W  (PMPOSY),D3
            
            ADDQ.W  #8,D2              
            ADDQ.W  #8,D3  
            
            MOVE.B  (PMLAMO),D4
            
            ;MASK OF THE LAST NIBBLE        
            AND.W   #$000F,D2               ; COORDENADA X
            AND.W   #$000F,D3               ; COORDENADA Y
            
            ;CHECK IF COORDS ARE MULTIPLES OF 16
            CMP     #$0000,D2
            BNE     .NOTMULT
            CMP     #$0000,D3
            BNE     .NOTMULT
            
            ;BRA     .ACTYUP

            ;CHECK THE DIRECTION
            BTST.B  #0,(KBDVAL)             ;CHECK LEFT
            BEQ     .NOTLEFT
            CLR.B   D4
            MOVE.B  #0,D4
            BRA     .ACTXLEFT
.NOTLEFT            
            BTST.B   #2,(KBDVAL)             ;CHECK RIGHT
            BEQ     .NOTRIGHT
            CLR.B   D4
            MOVE.B   #1,D4
            BRA     .ACTXRIGHT
.NOTRIGHT            
            BTST.B   #1,(KBDVAL)             ;CHECK UP
            BEQ     .NOTUP
            CLR.B   D4
            MOVE.B  #2,D4
            BRA     .ACTYUP
.NOTUP            
            BTST.B   #3,(KBDVAL)             ;CHECK DOWN
            BEQ     .NOTDOWN
            CLR.B   D4
            MOVE.B   #3,D4
            BRA     .ACTYDOWN
.NOTDOWN
            BRA     .DONE
            
            
            ;UPDATE COORDS
            
.ACTXRIGHT  
            JSR     COLWALLRIGHT
            CMP     #1,D5
            BNE     .NOTCOLISION
            MOVE.W  #0,D0
.NOTCOLISION
            CMP     #4,D5
            BNE     .NOTTP
            SUB.W   #30*16,(PMPOSX)
.NOTTP
            ADD.W   D0,(PMPOSX)
            BRA     .DONE
.ACTXLEFT
            JSR     COLWALLLEFT
            CMP     #1,D5
            BNE     .NOTCOLISION2
            MOVE.W  #0,D0
.NOTCOLISION2
            CMP     #4,D5
            BNE     .NOTTP2
            ADD.W   #30*16,(PMPOSX)
.NOTTP2
            SUB.W   D0,(PMPOSX)
            BRA     .DONE
    
.ACTYDOWN
            JSR     COLWALLDOWN
            CMP     #1,D5
            BNE     .NOTCOLISION3
            MOVE.W  #0,D0
.NOTCOLISION3
            ADD.W   D0,(PMPOSY)
            BRA     .DONE
.ACTYUP     
            JSR     COLWALLUP
            CMP     #1,D5
            BNE     .NOTCOLISION4
            MOVE.W  #0,D0
.NOTCOLISION4
            SUB.W   D0,(PMPOSY)
            BRA     .DONE
            
            
            ;IF NOT MULT DO
.NOTMULT     
            CMP.B     #0,D4
            BEQ     .ACTXLEFT
            CMP.B     #1,D4
            BEQ     .ACTXRIGHT
            CMP.B     #2,D4
            BEQ     .ACTYUP
            BRA     .ACTYDOWN
.DONE
            ;RESTORE
            JSR     GETPOINTS
            MOVE.B  D4,(PMLAMO)
            
            MOVEM.L (A7)+,D0-D6
            
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
            
            ;DRAW MOVEMENT
            ;MOVE.W  #84,D0
            
            
            
            ;TRAP    #15
            
            MOVEM.L (A7)+,D0-D4
            
            RTS

























*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
