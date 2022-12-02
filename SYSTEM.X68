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
            MOVE.L  #KBDUPD,($80+1*4)          ;INSTALL SUBRUTINE TO TRAP #1
            
            
            MOVE.L  #SCRTIM,($60+1*4)          ;INSTALL INTERRUPT #1
            
            JSR     SCRINIT
            JSR     KBDINIT
            
            
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
            MOVE.L  #20,D3                    ;INDICATE THE MILISECONDS FOR THAT PERIOD (20 ms == 50 FPS)
            TRAP    #15
            
            ;CLEAR INTERRUPT COUNTER
            CLR.B   (SCRINTCT)
            
            MOVEM.L (A7)+,D0-D1               ;RESTORE REGISTERS FROM STACK
            
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
            
;------------------------------------------------------------------------------            
SCRTIM
; TIME INTERRPUT SERVICE ROUTINE FOR SYNC
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            ADDQ.B  #1,(SCRINTCT)
            RTE
            
;------------------------------------------------------------------------------            
KBDINIT
; INIT THE KEYBOARD
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            CLR.B   (KBDVAL)
            CLR.B   (KBDEDGE)

            RTS

;------------------------------------------------------------------------------            
KBDUPD
; UPDATES KEYBOARD INFO
; 3 -> DOWN
; 2 -> RIGHT
; 1 -> UP
; 0 -> LEFT
; ------------------------------------------------------------------------------
            
            MOVEM.L D0-D4,-(A7)
            
            MOVE.W  #19,D0
            ;GET INFO OF THE KEYS
            MOVE.L  #KBDDOWN<<24|KBDRIGHT<<16|KBDUP<<8|KBDLEFT,D1
            TRAP    #15
            
            ;CONVERT TO DESIRED FORMAT
            JSR .CONVERT

            ;GET KBDEDGE (IF SOME KEY HAVE CHANGED THE VALUE)
            MOVE.B  (KBDVAL),D0             ;D0 -> LAST KBDVAL
            NOT.B   D0                      ;D2 -> ACTUAL KBDVAL
            AND.B   D2,D0
            MOVE.B  D0,(KBDEDGE)
            
       
            CMP.B   #0,D0
            BEQ     .NOACT          
            
            ;STORE NEW KBDVAL
            MOVE.B  D2,(KBDVAL)
.NOACT
            
            MOVEM.L (A7)+,D0-D4
            
            RTE    
            
.CONVERT 
            MOVE.W  #3,D3
            
.LOOP       LSL.L   #8,D1
            ROXL.B  #1,D2
            DBRA.W  D3,.LOOP
            RTS
           
            



















*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
