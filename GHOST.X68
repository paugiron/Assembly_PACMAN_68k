; ==============================================================================
; GHOST MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
GSTINIT
; INITIALIZE GHOST.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.W  #GSTINX1*16+64-8,(GSTPOSX)
            MOVE.W  #GSTINY1*16+64-8,(GSTPOSY)
            MOVE.W  #GSTSPEED,(GSTVELX)
            MOVE.W  #GSTSPEED,(GSTVELY)
            MOVE.B  #1,(GSTLAMO)
            RTS
            
; ------------------------------------------------------------------------------
GSTUPD
; UPDATES THE GHOST.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D5,-(A7)
            
            MOVE.W  (PMPOSX)/16*(PMPOSX)/16+(PMPOSY)/16*(PMPOSY)/16,D0
            MOVE.W  #GSTRNG,D1
            MULU.W  #GSTRNG,D1
            SUB.W   D0,D1
            BNE     .GSTINRNG
.GSTNOTINRNG
            CLR     D0
            CLR     D1
            MOVE.B  #1,(GSTINRNG)
            BRA     .GSTMOVE
.GSTINRNG
            MOVE.B  #0,(GSTINRNG)
.GSTMOVE
            MOVE.B  (GSTLAMO),D4

            ;MASK OF THE LAST NIBBLE        
            AND.W   #$000F,D2               ; COORDENADA X
            AND.W   #$000F,D3               ; COORDENADA Y
            
            ;CHECK IF COORDS ARE MULTIPLES OF 16
            CMP     #$0000,D2
            BNE     .GSTNOTMULT
            CMP     #$0000,D3
            ;BNE     .GSTNOTMULT
.GSTMULT
.GSTMULTRIGHT
            JSR     GSTCOLWALLRIGHT
            CMP     #1,D5
            BEQ     .GSTMULTLEFT
            ADD.B   #8,(GSTPOSMV)
.GSTMULTLEFT
            JSR     GSTCOLWALLLEFT
            CMP     #1,D5
            BEQ     .GSTMULTDOWN
            ADD.B   #4,(GSTPOSMV)
.GSTMULTDOWN
            JSR     GSTCOLWALLDOWN
            CMP     #1,D5
            BEQ     .GSTMULTUP
            ADD.B   #2,(GSTPOSMV)
.GSTMULTUP
            JSR     GSTCOLWALLUP
            CMP     #1,D5
            BEQ     .GSTDECISSION
            ADD.B   #1,(GSTPOSMV)
.GSTDECISSION
            MOVE.B  (GSTPOSMV),D0
            BTST.B  #5,D0
            BEQ     .GSTDECRIGHT
            BTST.B  #6,D0
            BEQ     .GSTDECLEFT
            BTST.B  #7,D0
            BEQ     .GSTDECDOWN
            
            
.GSTDECRIGHT
            MOVE.B  (GSTPOSMV),D0
            BTST.B  #6,D0
            BEQ     .GSTDECLEFT
.GSTDECLEFT
            MOVE.B  (GSTPOSMV),D0
            BTST.B  #6,D0
            BEQ     .GSTDECDOWN
.GSTDECDOWN
            MOVE.B  (GSTPOSMV),D0
            BTST.B  #6,D0
            BEQ     .GSTDECUP
.GSTDECUP
            MOVE.B  (GSTPOSMV),D0
            BTST.B  #6,D0
            BEQ     .GSTDONE
.GSTNOTMULT            
            CMP     #1,D4
            BEQ     .GSTRIGHTMOVE
            CMP     #2,D4
            BEQ     .GSTLEFTMOVE
            CMP     #3,D4
            BEQ     .GSTDOWNMOVE
            BRA     .GSTUPMOVE

            ;UPDATE COORDS
            
.GSTRIGHTMOVE
            JSR     GSTCOLWALLRIGHT
            CMP     #1,D5
            BNE     .GSTNOTCOLISION
            MOVE.W  #0,D0
.GSTNOTCOLISION
            CMP     #4,D5
            BNE     .GSTNOTTP
            SUB.W   #30*16,(GSTPOSX)
.GSTNOTTP
            ADD.W   D0,(GSTPOSX)
            BRA     .GSTDONE
.GSTLEFTMOVE
            JSR     GSTCOLWALLLEFT
            CMP     #1,D5
            BNE     .GSTNOTCOLISION2
            MOVE.W  #0,D0
.GSTNOTCOLISION2
            CMP     #4,D5
            BNE     .GSTNOTTP2
            ADD.W   #30*16,(GSTPOSX)
.GSTNOTTP2
            SUB.W   D0,(GSTPOSX)
            BRA     .GSTDONE
    
.GSTDOWNMOVE
            JSR     GSTCOLWALLDOWN
            CMP     #1,D5
            BNE     .GSTNOTCOLISION3
            MOVE.W  #0,D0
.GSTNOTCOLISION3
            ADD.W   D0,(GSTPOSY)
            BRA     .GSTDONE
.GSTUPMOVE    
            JSR     GSTCOLWALLUP
            CMP     #1,D5
            BNE     .GSTNOTCOLISION4
            MOVE.W  #0,D0
.GSTNOTCOLISION4
            SUB.W   D0,(GSTPOSY)
            BRA     .GSTDONE

.GSTDONE
            MOVE.B  D4,(GSTLAMO)

            MOVEM.L (A7)+,D0-D5
            
            RTS
            
; ------------------------------------------------------------------------------
GSTPLOT
; PLOT THE GHOST.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            
            ;SET PEN COLOR
            MOVE.W  #80,D0
            MOVE.L  #GSTCOL1,D1
            TRAP    #15
            
            ;SET FILL COLOR
            MOVE.W  #81,D0
            MOVE.L  #GSTFCOL1,D1
            TRAP    #15
            
            ;SET COORDS
            MOVE.W  (GSTPOSX),D1
            SUB.W   #GSTRAD,D1
            MOVE.W  (GSTPOSY),D2
            SUB.W   #GSTRAD,D2
            
            MOVE.W  D1,D3
            ADD.W   #GSTRAD*2,D3
            MOVE.W  D2,D4
            ADD.W   #GSTRAD*2,D4
            
            ;DRAW GHOST
            MOVE.W  #88,D0
            TRAP    #15
            
            ;SET RANGE COORDS
            MOVE.W  (GSTPOSX),D1
            SUB.W   #GSTRNG*16,D1
            MOVE.W  (GSTPOSY),D2
            SUB.W   #GSTRNG*16,D2
            
            MOVE.W  D1,D3
            ADD.W   #GSTRNG*16*2,D3
            MOVE.W  D2,D4
            ADD.W   #GSTRNG*16*2,D4
            
            ;DRAW GHOST RANGE
            MOVE.W  #91,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4
            

            RTS






*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
