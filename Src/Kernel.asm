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

    mov rsi, letter_I_bitmap  ; Pointer to the bitmap data
    mov r8d, 0             ; Y-coordinate (top)
    mov r9d, 5              ; X-coordinate (left)
    mov r10d, 5             ; Width of the bitmap (in pixels)
    mov r11d, 4             ; Height of the bitmap (in pixels)

    call DrawBitmap    

    mov rsi, letter_D_bitmap  ; Pointer to the bitmap data
    mov r8d, 0             ; Y-coordinate (top)
    mov r9d, 12              ; X-coordinate (left)
    mov r10d, 5             ; Width of the bitmap (in pixels)
    mov r11d, 4             ; Height of the bitmap (in pixels)

    call DrawBitmap    

    mov rsi, letter_A_bitmap  ; Pointer to the bitmap data
    mov r8d, 0             ; Y-coordinate (top)
    mov r9d, 16              ; X-coordinate (left)
    mov r10d, 6             ; Width of the bitmap (in pixels)
    mov r11d, 4             ; Height of the bitmap (in pixels)

    call DrawBitmap   

    mov rsi, letter_N_bitmap  ; Pointer to the bitmap data
    mov r8d, 0             ; Y-coordinate (top)
    mov r9d, 23              ; X-coordinate (left)
    mov r10d, 4             ; Width of the bitmap (in pixels)
    mov r11d, 4             ; Height of the bitmap (in pixels)

    call DrawBitmap   


    jmp $                    ; Infinite loop



letter_A_bitmap:
    db 00, 00, 01, 01, 00, 00
    db 00, 01, 00, 00, 01, 00
    db 00, 01, 01, 01, 01, 00 
    db 00, 01, 00, 00, 01, 00

letter_I_bitmap:
    db 00, 00, 01, 01, 01
    db 00, 00, 00, 01, 00
    db 00, 00, 00, 01, 00 
    db 00, 00, 01, 01, 01


letter_D_bitmap:
    db 01, 01, 01, 00, 00
    db 01, 00, 00, 01, 00
    db 01, 00, 00, 01, 00 
    db 01, 01, 01, 00, 00

letter_N_bitmap:
    db 01, 00, 00, 01 
    db 01, 01, 00, 01 
    db 01, 00, 01, 01  
    db 01, 00, 00, 01

Number_one:
    db 00, 00, 00, 01, 01, 00, 00, 00
    db 00, 00, 00, 00, 01, 00, 00, 00
    db 00, 00, 00, 00, 01, 00, 00, 00 
    db 00, 00, 00, 01, 01, 01, 00, 00 


