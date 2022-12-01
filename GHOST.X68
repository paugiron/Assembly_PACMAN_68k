; ==============================================================================
; GHOST MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
GSTINIT
; INITIALIZE PADDLE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.W  #SCRWIDTH/2,(GSTPOSX)
            MOVE.W  #SCRHEIGH/2+32,(GSTPOSY)
            ADDQ.W  #8,(GSTPOSX)
            ADDQ.W  #8,(GSTPOSY)
            MOVE.W  #GSTSPEED,(GSTVELX)
            MOVE.W  #GSTSPEED,(GSTVELY)
            RTS
            
; ------------------------------------------------------------------------------
GSTUPD
; UPDATES THE PADDLE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.W D0-D3,-(A7)
            
            MOVE.W  (GSTVELX),D0
            MOVE.W  (GSTVELY),D1
            
            MOVE.W  (GSTPOSX),D2
            MOVE.W  (GSTPOSY),D3
            ADDQ.W  #8,D2
            ADDQ.W  #8,D3
            
            RTS
            
; ------------------------------------------------------------------------------
GSTPLOT
; PLOT THE PADDLE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            RTS

*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
