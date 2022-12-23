; ==============================================================================
; SYSTEM CONSTANTS
; ==============================================================================

; --- SCREEN RELATED CONSTANTS -------------------------------------------------

SCRWIDTH    EQU     640                     ; SCREEN WIDTH
SCRHEIGH    EQU     640                     ; SCREEN HEIGHT

;--- TITLE RELATED CONSTANTS ---------------------------------------------------
FILENAME    DC.B    'title.txt',0
FILESIZE    EQU     2700
            DS.B    0                       
;---KEYCODES--------------------------------------------------------------------

KBDLEFT     EQU     $25
KBDUP       EQU     $26
KBDRIGHT    EQU     $27
KBDDOWN     EQU     $28
KBDFIRE1    EQU     ' '
KBDFIRE2    EQU     'M'                         
KBDFIRE3    EQU     $10
KBDPAUSE    EQU     'P'










*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
