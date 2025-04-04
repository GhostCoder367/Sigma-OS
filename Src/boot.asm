[org 0x7c00]

; -------------------------------
; Bootloader Initialization
; -------------------------------
mov [BOOT_PART], dl       ; Store boot partition
mov bp, 0x7c00            ; Set base pointer to bootloader start
mov sp, bp                ; Initialize stack pointer
mov ah, 0x00              ; Set video mode
mov al, 0x13              ; 320x200 256-color mode
int 0x10                  ; BIOS interrupt to set video mode

; -------------------------------
; Read Partition and Jump to Program
; -------------------------------
call ReadPart             ; Read partition into memory
jmp PROGRAM_SPACE         ; Jump to program execution space

; -------------------------------
; Include External Files
; -------------------------------
%include "printing.asm"   ; Include printing utilities
%include "FileReader.asm" ; Include file reader utilities

; -------------------------------
; Bootloader Padding and Signature
; -------------------------------
times 510-($-$$) db 0     ; Pad bootloader to 510 bytes
dw 0xaa55                 ; Bootloader signature