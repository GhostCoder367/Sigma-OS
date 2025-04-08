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
    mov edi, 0xA0000      ; Set video memory base address
    mov bl, COLOR_BLUE 
    call FillScreen

    mov eax, 120           ; Y-coordinate
    mov ebx, 0             ; X-coordinate
    mov ecx, 30000         ; Number of pixels to draw
    mov bl, COLOR_GREEN    ; Set the color to blue
    call DrawPixel         ; Draw a blue pixel at (0, 0)

    


    jmp $                    ; Infinite loop

; -------------------------------
; Drawing Functions
; -------------------------------



FillScreen:
    mov al, bl

    mov ecx, 64000
    rep stosb
    ret
DrawPixel:
    ; Inputs:
    ;   eax = Y-coordinate (height)
    ;   ebx = X-coordinate (width)
    ;   ecx = Number of pixels to draw
    ;   bl  = Color

    mov r8d, eax             ; Preserve Y-coordinate in r8d
    mov r9d, ebx             ; Preserve X-coordinate in r9d


    mov edi, 0xA0000         ; Set video memory base address
    mov edx, 320             ; Screen width (320 pixels in mode 13h)
    imul eax, edx            ; eax = Y * ScreenWidth
    add eax, r9d             ; eax = X + (Y * ScreenWidth)
    add edi, eax             ; edi = Video memory address for the starting pixel
    sub edi, 2

    mov eax, r8d             ; Restore Y-coordinate from r8d
    mov al, bl               ; Load the color into AL
    rep stosb                ; Write the color to the specified number of pixels
    ret

; -------------------------------
; Padding and Alignment
; -------------------------------
times 2048-($-$$) db 0       ; Pad to 2048 bytes
