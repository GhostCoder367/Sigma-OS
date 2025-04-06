[org 0x7e00]

; -------------------------------
; Color Definitions
; -------------------------------
%define COLOR_BLUE    0x01
%define COLOR_GREEN   0x02
%define COLOR_RED     0x04
%define COLOR_CYAN    0x03
%define COLOR_MAGENTA 0x05
%define COLOR_YELLOW  0x06
%define COLOR_WHITE   0x07

; -------------------------------
; Start Boot Process
; -------------------------------
jmp StartProtectMode

; -------------------------------
; Include External Files
; -------------------------------
%include "GDT.asm"
%include "printing.asm"

; -------------------------------
; Protected Mode Initialization
; -------------------------------
StartProtectMode:
    call StartA20
    cli
    lgdt [gdt_criptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp code:LaunchProtectMode

StartA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]

; -------------------------------
; Include Additional Modules
; -------------------------------
%include "CPU.asm"
%include "Page.asm"

LaunchProtectMode:
    mov ax, data
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    call CPU_Detection
    call LongMode_Detection
    call Paging
    call EditGDT
    jmp code:Open_64bit

[bits 64]

; -------------------------------
; Long Mode Entry Point
; -------------------------------
Open_64bit:
    mov edi, 0xA0000         ; Set video memory base address

    mov al, COLOR_WHITE      ; Set color to white
          ; Draw pixel

    mov ecx, 64000           ; Fill screen with color

    rep stosb
    mov edi, 0xA0000         ; Set video memory base address
    mov al, COLOR_BLUE      ; Set color to blue
    mov ecx, 64000
    rep stosb     ; Draw pixel




    jmp $                    ; Infinite loop

; -------------------------------
; Drawing Functions
; -------------------------------
Draw:

    call Vec2toBufferLoc     ; Convert coordinates to buffer location
    mov [edi + esi], al      ; Write color to video memory

    ret

Vec2toBufferLoc:
    mov ecx, ebx             ; Load X-coordinate
    imul ecx, eax            ; Multiply X by screen width (assumed in eax)
    add esi, edx             ; Add Y-coordinate
    ret

; -------------------------------
; Padding and Alignment
; -------------------------------
times 2048-($-$$) db 0       ; Pad to 2048 bytes
