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
    call DrawPixel         ; Draws Green pixels starting from (0, 120) 30000 times

    mov rsi, letter_A_bitmap  ; Pointer to the bitmap data
    mov r8d, 0             ; Y-coordinate (top)
    mov r9d, 0              ; X-coordinate (left)
    mov r10d, 6             ; Width of the bitmap (in pixels)
    mov r11d, 4             ; Height of the bitmap (in pixels)

    call DrawBitmap    


    jmp $                    ; Infinite loop



letter_A_bitmap:
    db 00, 00, 01, 01, 00, 00
    db 00, 01, 00, 00, 01, 00
    db 00, 01, 01, 01, 01, 00 
    db 00, 01, 00, 00, 01, 00 


