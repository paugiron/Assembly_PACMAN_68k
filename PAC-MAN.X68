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
            MOVE.B  #0,(KBDVAL)
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
            MOVE.B  #0,(KBDVAL)
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
            MOVE.B  #0,(KBDVAL)
            MOVE.W  #0,D0
.NOTCOLISION3
            ADD.W   D0,(PMPOSY)
            BRA     .DONE
.ACTYUP     
            JSR     COLWALLUP
            CMP     #1,D5
            BNE     .NOTCOLISION4
            MOVE.B  #0,(KBDVAL)
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

            MOVEM.L D0-D5,-(A7)

            ;SET PEN COLOR
            MOVE.W  #80,D0
            MOVE.L  #$0000,D1
            TRAP    #15
            
            ;SET FILL COLOR
            MOVE.W  #81,D0
            MOVE.L  #PMFCOL,D1
            TRAP    #15
            
            BTST.B  #3,(SCRCYCCT)
            BEQ     .MOUTHOPEN
            
            ;DRAW QUIET
            JSR     .FULLDRAW
            BRA     .DDONE
            
.MOUTHOPEN     
            JSR     .FULLDRAW       
            MOVE.B  (KBDVAL),D5
            AND.B   #$0F,D5
 
            ;CHECK KBDVAL
            CMP.B   #$0,D5
            BEQ     .NOTMOVE
            CMP.B  #$1,D5             ;LEFT
            BEQ     .DLEFT
            CMP.B  #$2,D5             ;UP
            BEQ     .DUP
            CMP.B  #$4,D5             ;RIGHT
            BEQ     .DRIGHT
            CMP.B  #$8,D5             ;DOWN
            BEQ     .DDOWN
            
            ;DRAW MOVEMENT
.NOTMOVE    JSR     .FULLDRAW
            BRA     .DDONE
.DRIGHT
            JSR     .RIGHTDRAW
            BRA     .DRAW_MOUTH3
.DUP
            JSR     .UPDRAW
            BRA     .DRAW_MOUTH2

.DLEFT
            JSR     .LEFTDRAW
            BRA     .DRAW_MOUTH1

.DDOWN
            JSR     .DOWNDRAW
            BRA     .DRAW_MOUTH4
            
.DRAW_MOUTH1            
            JSR     .SET_MOUTHLEFT
            BRA     .DDONE
.DRAW_MOUTH2            
            JSR     .SET_MOUTHUP
            BRA     .DDONE
.DRAW_MOUTH3            
            JSR     .SET_MOUTHRIGHT
            BRA     .DDONE
.DRAW_MOUTH4            
            JSR     .SET_MOUTHDOWN
.DDONE
            MOVEM.L (A7)+,D0-D5
            
            RTS


;INTERNAL SUBRUTINES FOR PACMAN PLOT-------------------------------------------------------------

.FULLDRAW
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
            
            RTS
.LEFTDRAW
            
            
            MOVE.W  #84,D0
            MOVE.W  (PMPOSX),D1                   ;FINAL COORD OF THE FIRST LINE
            SUB.W   #PMRAD,D1
            MOVE.W  (PMPOSY),D2
            SUB.W   #PMRAD,D2
            
            MOVE.W  (PMPOSX),D3                   ;ORIGINAL COORD FIRST LINE
            MOVE.W  (PMPOSY),D4
            
            TRAP    #15
           
            MOVE.W  #85,D0                        ;DRAW SECOND LINE
            
            MOVE.W  D3,D1
            MOVE.W  D4,D2
            ADD.W   #PMRAD,D2
            SUB.W   #PMRAD,D1
            
            TRAP    #15
            
            
            RTS
            
.RIGHTDRAW
            
            
            MOVE.W  #84,D0
            MOVE.W  (PMPOSX),D1                   ;FINAL COORD OF THE FIRST LINE
            ADD.W   #PMRAD,D1
            MOVE.W  (PMPOSY),D2
            ADD.W   #PMRAD,D2
            
            MOVE.W  (PMPOSX),D3                   ;ORIGINAL COORD FIRST LINE
            MOVE.W  (PMPOSY),D4
            
            TRAP    #15
           
            MOVE.W  #85,D0                        ;DRAW SECOND LINE
            
            MOVE.W  D3,D1
            MOVE.W  D4,D2
            SUB.W   #PMRAD,D2
            ADD.W   #PMRAD,D1
            
            TRAP    #15
            
            
            RTS
.UPDRAW
            
            
            MOVE.W  #84,D0
            MOVE.W  (PMPOSX),D1                   ;FINAL COORD OF THE FIRST LINE
            SUB.W   #PMRAD,D1
            MOVE.W  (PMPOSY),D2
            SUB.W   #PMRAD,D2
            
            MOVE.W  (PMPOSX),D3                   ;ORIGINAL COORD FIRST LINE
            MOVE.W  (PMPOSY),D4
            
            TRAP    #15
           
            MOVE.W  #85,D0                        ;DRAW SECOND LINE
            
            MOVE.W  D3,D1
            MOVE.W  D4,D2
            SUB.W   #PMRAD,D2
            ADD.W   #PMRAD,D1
            
            TRAP    #15
            
            
            RTS
            
.DOWNDRAW
            
            
            MOVE.W  #84,D0
            MOVE.W  (PMPOSX),D1                   ;FINAL COORD OF THE FIRST LINE
            SUB.W   #PMRAD,D1
            MOVE.W  (PMPOSY),D2
            ADD.W   #PMRAD,D2
            
            MOVE.W  (PMPOSX),D3                   ;ORIGINAL COORD FIRST LINE
            MOVE.W  (PMPOSY),D4
            
            TRAP    #15
           
            MOVE.W  #85,D0                        ;DRAW SECOND LINE
            
            MOVE.W  D3,D1
            MOVE.W  D4,D2
            ADD.W   #PMRAD,D2
            ADD.W   #PMRAD,D1
            
            TRAP    #15
            
            
            RTS

            
.SET_MOUTHLEFT
            
            MOVE.W  #81,D0                         ;SET BLACK
            MOVE.L  #$0000,D1
            TRAP    #15
            
            MOVE.W  #89,D0                         ;FILL
            MOVE.W  (PMPOSX),D1
            SUBQ.W   #2,D1
            MOVE.W  (PMPOSY),D2
            TRAP    #15

            RTS
            
.SET_MOUTHRIGHT
            
            MOVE.W  #81,D0                         ;SET BLACK
            MOVE.L  #$0000,D1
            TRAP    #15
            
            MOVE.W  #89,D0                         ;FILL
            MOVE.W  (PMPOSX),D1
            ADDQ.W   #2,D1
            MOVE.W  (PMPOSY),D2
            TRAP    #15

            RTS

.SET_MOUTHUP
            
            MOVE.W  #81,D0                         ;SET BLACK
            MOVE.L  #$0000,D1
            TRAP    #15
            
            MOVE.W  #89,D0                         ;FILL
            MOVE.W  (PMPOSX),D1
            MOVE.W  (PMPOSY),D2
            SUBQ.W   #2,D2
            TRAP    #15

            RTS

.SET_MOUTHDOWN
            
            MOVE.W  #81,D0                         ;SET BLACK
            MOVE.L  #$0000,D1
            TRAP    #15
            
            MOVE.W  #89,D0                         ;FILL
            MOVE.W  (PMPOSX),D1
            MOVE.W  (PMPOSY),D2
            ADDQ.W   #2,D2
            TRAP    #15

            RTS



























*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
