; ==============================================================================
; GHOST MANAGEMENT (AGENT)
; GSTPOSX (W) (A0)
; GSTPOSY (W) 2(A0)
; GSTVELX (W) 4(A0)
; GSTVELY (W) 6(A0)
; GSTPOSMV(W) 8(A0)
; GSTLAMO (W) 9(A0)
; ==============================================================================
            
; ------------------------------------------------------------------------------
GSTINIT
; INITIALIZE GHOST.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.W  #GSTINX1*16+64-8,(GSTPOSX)
            MOVE.W  #GSTINY1*16+64-8,(GSTPOSY)
            MOVE.W  #GSTSPEED,(GSTVELX)
            MOVE.W  #GSTSPEED,(GSTVELY)
            MOVE.B  #2,(GSTLAMO)
            RTS
            
; ------------------------------------------------------------------------------
GSTUPD
; UPDATES THE GHOST.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D5,-(A7)
            
            MOVE.W  #GSTSPEED,D0
            
            MOVE.W  (GSTPOSX),D2
            MOVE.W  (GSTPOSY),D3
            
            ADDQ.W  #8,D2              
            ADDQ.W  #8,D3

            ;MASK OF THE LAST NIBBLE        
            AND.W   #$000F,D2               ; COORDENADA X
            AND.W   #$000F,D3               ; COORDENADA Y
            
            ;CHECK IF COORDS ARE MULTIPLES OF 16
            CMP     #$0000,D2
            BNE     .GSTNOTMULT
            CMP     #$0000,D3
            BNE     .GSTNOTMULT
.GSTMULT
            MOVE.B  #0,(GSTPOSMV)
.GSTMULTRIGHT
            JSR     GSTCOLWALLRIGHT
            CMP     #1,D5
            BEQ     .GSTMULTLEFT
            ADD.B   #1,(GSTPOSMV)
            ADDQ.W  #1,D4
.GSTMULTLEFT
            JSR     GSTCOLWALLLEFT
            CMP     #1,D5
            BEQ     .GSTMULTDOWN
            ADD.B   #2,(GSTPOSMV)
            ADDQ.W  #1,D4
.GSTMULTDOWN
            JSR     GSTCOLWALLDOWN
            CMP     #1,D5
            BEQ     .GSTMULTUP
            ADD.B   #4,(GSTPOSMV)
            ADDQ.W  #1,D4
.GSTMULTUP
            JSR     GSTCOLWALLUP
            CMP     #1,D5
            BEQ     .GSTDECISSION
            ADD.B   #8,(GSTPOSMV)
            ADDQ.W  #1,D4
.GSTDECISSION
            CMP     #2,D4
            BLE     .GST2MOVES
            JSR     UTLRAND
            AND.L   #$00000006,D0
            LEA     GSTDECVEC,A1
            MOVE.W  (A1,D0),D1
            CMP     #1,D1
            BEQ     .GSTRANRIGHT
            CMP     #2,D1
            BEQ     .GSTRANLEFT
            CMP     #3,D1
            BEQ     .GSTRANDOWN
            BRA     .GSTRANUP
.GST2MOVES
            JSR     GST2DECISSIONS
            CMP     #0,D4
            BNE     .GSTNOTMULT
            MOVE.B  (GSTLAMO),D4
            CMP     #1,D4
            BEQ     .2MLAMOX
            CMP     #2,D4
            BEQ     .2MLAMOX
            BRA     .2MLAMOY
.2MLAMOX
            JSR     GSTCOLWALLUP
            CMP     #1,D5
            BNE     .GSTUPMOVE
            BRA     .GSTDOWNMOVE
.2MLAMOY
            JSR     GSTCOLWALLRIGHT
            CMP     #1,D5
            BNE     .GSTRIGHTMOVE
            BRA     .GSTLEFTMOVE

.GSTRANRIGHT
            BTST.B  #0,(GSTPOSMV)
            BEQ     .GSTDECISSION
            BRA     .GSTRIGHTMOVE
.GSTRANLEFT
            BTST.B  #1,(GSTPOSMV)
            BEQ     .GSTDECISSION
            BRA     .GSTLEFTMOVE
.GSTRANDOWN
            BTST.B  #2,(GSTPOSMV)
            BEQ     .GSTDECISSION
            BRA     .GSTDOWNMOVE
.GSTRANUP
            BTST.B  #3,(GSTPOSMV)
            BEQ     .GSTDECISSION
            BRA     .GSTUPMOVE
.GSTNOTMULT 
            MOVE.B  (GSTLAMO),D4           
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
            MOVE.B  #1,(GSTLAMO)
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
            MOVE.B  #2,(GSTLAMO)
            BRA     .GSTDONE
    
.GSTDOWNMOVE
            JSR     GSTCOLWALLDOWN
            CMP     #1,D5
            BNE     .GSTNOTCOLISION3
            MOVE.W  #0,D0
.GSTNOTCOLISION3
            ADD.W   D0,(GSTPOSY)
            MOVE.B  #3,(GSTLAMO)
            BRA     .GSTDONE
.GSTUPMOVE    
            JSR     GSTCOLWALLUP
            CMP     #1,D5
            BNE     .GSTNOTCOLISION4
            MOVE.W  #0,D0
.GSTNOTCOLISION4
            SUB.W   D0,(GSTPOSY)
            MOVE.B  #4,(GSTLAMO)
            BRA     .GSTDONE

.GSTDONE

            MOVEM.L (A7)+,D0-D5
            
            RTS
            
; SUBRUTINES FOR GHOST UPDATE --------------------------------------------------

GST2DECISSIONS

            MOVEM.L D0,-(A7)
            
            MOVE.B  (GSTLAMO),D0
            CMP     #1,D0
            BEQ     .LAMORIGHT
            CMP     #2,D0
            BEQ     .LAMOLEFT
            CMP     #3,D0
            BEQ     .LAMODOWN
            BRA     .LAMOUP
            
.LAMORIGHT
            BTST.B  #0,(GSTPOSMV)
            BEQ     .RETURN0
            MOVE.W  #1,D4
            BRA     .GST2DECEND
.LAMOLEFT
            BTST.B  #1,(GSTPOSMV)
            BEQ     .RETURN0
            MOVE.W  #1,D4
            BRA     .GST2DECEND
.LAMODOWN
            BTST.B  #2,(GSTPOSMV)
            BEQ     .RETURN0
            MOVE.W  #1,D4
            BRA     .GST2DECEND
.LAMOUP
            BTST.B  #3,(GSTPOSMV)
            BEQ     .RETURN0
            MOVE.W  #1,D4
            BRA     .GST2DECEND
.RETURN0
            MOVE.W  #0,D4
            
.GST2DECEND

            MOVEM.L (A7)+,D0
            RTS

            
; ------------------------------------------------------------------------------
GSTPLOT
; PLOT THE GHOST.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            
            ;SET PEN COLOR
            MOVE.W  #80,D0
            MOVE.L  #GSTCONT,D1
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
