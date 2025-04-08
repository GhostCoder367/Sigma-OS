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