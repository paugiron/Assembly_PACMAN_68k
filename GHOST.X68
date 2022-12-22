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
            CLR.B   (GSTLAMO)
            RTS
            
; ------------------------------------------------------------------------------
GSTUPD
; UPDATES THE GHOST.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            
            ;MOVE.W  (PMPOSX)/16*(PMPOSX)/16+(PMPOSY)/16*(PMPOSY)/16-#GSTRNG*#GSTRNG,D0
            BNE     .GSTINRNG
.GSTNOTINRNG
            MOVE.B  #1,(GSTINRNG)
            BRA     .CHECKCRITIC
.GSTINRNG
            MOVE.B  #0,(GSTINRNG)
.CHECKCRITIC
            

            MOVEM.L (A7)+,D0-D4
            
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
