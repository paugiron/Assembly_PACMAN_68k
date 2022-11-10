; ==============================================================================
; SYSTEM
; ==============================================================================
            
; ------------------------------------------------------------------------------
SYSINIT
; INITIALIZE SYSTEM.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVE.L  #SCRUPD,($80+0*4)          ;INSTALL SUBRUTINE TO TRAP #0
            
            JSR     SCRINIT
            
            MOVE.W  SR,-(A7)
            ANDI.W  #$D8FF,(A7)                ;BIT SUPERVISOR TO O AND INTERRPUT MASK 000 (FOR REACTIVATE INTERRUPTIONS)             
            RTE
   
; ------------------------------------------------------------------------------
SCRINIT
; INIT SCREEN. SET SCREEN RESOLUTION, SET WINDOWED MODE, CLEAR SCREEN, ENABLE BUFFER
; ENABLE TIMED INTERRUPTION
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D1,-(A7)                 ;SAFE REGISTERS IN STACK

            ; SET SCREEN RESOLUTION
            MOVE.B  #33,D0
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH,D1
            TRAP    #15
            
            ; SET WINDOWED MODE
            MOVE.L  #1,D1
            TRAP    #15
            
            ; ENABLE DOUBLE BUFFER
            MOVE.B  #92,D0
            MOVE.B  #17,D1
            TRAP    #15
            
            ; CLEAR SCREEN
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            
            ;ENABLE TIMED INTERRPUT
            MOVE.W  #32,D0
            MOVE.B  #6,D1
            MOVE.B  #$81,D2                   ;INDICATE THAT INTERRUPT 1 IS ACTIVATED PERIODICALLY
            MOVE.L  #20,D3                    ;INDICATE THE MILISECONDS FOR THAT PERIOD
            TRAP    #15
            
            ;CLEAR INTERRUPT COUNTER
            CLR.B   (SCRINTCT)
            
            MOVEM.L (A7)+,D0-D1                 ;RESTORE REGISTERS FROM STACK
            
            RTS
            
;------------------------------------------------------------------------------            
SCRUPD
; UPDATES DOUBLE BUFFER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.W D0-D1,-(A7)
            
            ;SWITCH BUFFERS
            MOVE.B #94,D0
            TRAP #15
            
            ;CLEAR HIDDEN BUFFER
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            
            MOVEM.W (A7)+,D0-D1
            
            RTE





*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
