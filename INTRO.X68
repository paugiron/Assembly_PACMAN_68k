; ==============================================================================
; INTRO SCREEN
; ==============================================================================

; ------------------------------------------------------------------------------
ISCINIT
; INTRO SCREEN INIT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.W   (ISCTIMER)
            JSR     OPENFILE
            RTS

; ------------------------------------------------------------------------------
ISCUPD
; INTRO SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            BTST.B  #4,(KBDVAL)
            BEQ     .CONT
            MOVE.W  #1,(STANEXT)
.CONT       ;ADDQ.W  #1,(ISCTIMER)
;            CMP.W   #500,(ISCTIMER)
;            BLT     .DONE
;            MOVE.W  #1,(STANEXT)
.DONE       RTS

; ------------------------------------------------------------------------------
ISCPLOT
; INTRO SCREEN PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0,-(A7)
            
            CLR.L   D1
            MOVE.B  #81,D0
            TRAP    #15
            
            ;JSR     IMGPLOT
            
            BTST.B  #4,(SCRCYCCT)
            BEQ     .DONE
            
            LEA     .TXT2,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
.DONE       MOVEM.L (A7)+,D0-D1/A0

            RTS
.TXT1       DC.B    'PAC-MAN 68000',0
.TXT2       DC.B    'PRESS SPACE BUTTON TO START',0
            DS.W    0
            
;------------------------------------------------------------------------
            
OPENFILE                 
            ;OPEN FILE
            LEA     FILENAME,A1
            MOVE    #51,D0
            TRAP    #15
            
            ;READ FILE
            MOVE.L  #FILESIZE,D2
            LEA     BUFFER,A1
            MOVE    #53,D0
            TRAP    #15
            
    
            
            RTS
; ------------------------------------------------------------------------------
IMGPLOT
; TITLE IMAGE PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D6,-(A7)
            MOVEM.L A0-A1,-(A7)
            
            ;PLOT
 
            LEA.L   BUFFER,A0
            MOVE.W  #220,D6
            MOVE.W  #28,D2
BUCLE_FILA3
            MOVE.W  #100,D5
            MOVE.W  #101,D1
            ADD.W   #4,D6

BUCLE_COLUMNA3
            ADD.W   #4,D5

            MOVE.B  (A0)+,D0
             
            CMP     #1,D0
            BEQ     ZERO3
            CMP     #0,D0
            JSR     DRAW
ZERO3
            DBRA    D1,BUCLE_COLUMNA3
            DBRA    D2,BUCLE_FILA3
            
            MOVEM.L (A7)+,A0-A1
            MOVEM.L (A7)+,D0-D6
        

            RTS


; -----------------------------------------------------------------------------
DRAW
; SUBRUTINE DRAW 
; INPUT    : D5=POSITION X, D6=POSITION Y
; OUTPUT   : NONE
; MODIFIES : NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D6,-(A7)
            ; SET CONTOURN COLOR
            MOVE.B  #80,D0
            MOVE.L  #$00AA0000,D1
            TRAP    #15
            
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #$00FF0000,D1
            TRAP    #15
            
            ; DEFINE COORDINATES RECTANGLE
            MOVE.W  D5,D1
            MOVE.W  D6,D2
            ADD.W   #4,D5
            ADD.W   #4,D6
            MOVE.W  D5,D3
            MOVE.W  D6,D4
            
            ; DRAW RECTANGLE
            MOVE.B  #87,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D6

            RTS







*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
