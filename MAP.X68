*-----------------------------------------------------------
* MAP
*-----------------------------------------------------------

; ------------------------------------------------------------------------------
MAPINIT
; INIT MAP
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------            
            
            MOVE.L  #DIBFIG,($80+2*4)          ;INSTALL SUBRUTINE TO TRAP #2
            
            
            
            LEA.L   MAPMAT,A0
            MOVE.W  #48,D6
            MOVE.W  #31,D2
BUCLE_FILA
            MOVE.W  #48,D5
            MOVE.W  #31,D1
            ADD.W   #16,D6

BUCLE_COLUMNA
            ADD.W   #16,D5

            MOVE.B  (A0)+,D0
            CMP     #0,D0
            BEQ     ZERO
            TRAP    #2

ZERO
            DBRA    D1,BUCLE_COLUMNA
            
            DBRA    D2,BUCLE_FILA
            
            RTS            
            
; -----------------------------------------------------------------------------
DIBFIG
; SUBRUTINE DRAW MAP
; INPUT    : D5=POSITION X, D6=POSITION Y
; OUTPUT   : NONE
; MODIFIES : NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D6,-(A7)
            ; SET CONTOURN COLOR
            MOVE.B  #80,D0
            MOVE.L  #$00FF0000,D1
            TRAP    #15
            
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #$00000000,D1
            TRAP    #15
            
            ; DEFINE COORDINATES RACTANGLE
            MOVE.W  D5,D1
            MOVE.W  D6,D2
            ADD.W   #16,D5
            ADD.W   #16,D6
            MOVE.W  D5,D3
            MOVE.W  D6,D4
            
            ; DRAW RECTANGLE
            MOVE.B  #87,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D6

            RTE

*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
