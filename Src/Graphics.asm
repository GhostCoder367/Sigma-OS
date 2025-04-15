; -------------------------------
; Drawing Functions
; -------------------------------


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

 DrawCharPixel:
    ; Inputs:
    ;   eax = Y-coordinate (height)
    ;   ebx = X-coordinate (width)
    ;   ecx = Number of pixels to draw


    mov r8d, eax             ; Preserve Y-coordinate in r8d
    mov r9d, ebx             ; Preserve X-coordinate in r9d


    mov edi, 0xA0000         ; Set video memory base address
    mov edx, 320             ; Screen width (320 pixels in mode 13h)
    imul eax, edx            ; eax = Y * ScreenWidth
    add eax, r9d             ; eax = X + (Y * ScreenWidth)
    add edi, eax             ; edi = Video memory address for the starting pixel
    sub edi, 2

    mov eax, r8d             ; Restore Y-coordinate from r8d
    mov al, COLOR_WHITE               ; Load the color into AL
    rep stosb                ; Write the color to the specified number of pixels
    ret     


DrawBitmap:
    ; Inputs:
    ;   rsi = Pointer to bitmap data
    ;   r8d = Y-coordinate (top)
    ;   r9d = X-coordinate (left)
    ;   r10d = Width of bitmap
    ;   r11d = Height of bitmap

    add r9d, 2
    mov r12d, r9d            ; X-coordinate (left) - used for inner loop
    mov r13d, r8d            ; Y-coordinate (top)  - used for outer loop
    mov r14d, r10d           ; Width of bitmap
    mov r15d, r11d           ; Height of bitmap
    xor r11d, r11d           ; Row counter

DrawBitmapRowLoop:
    mov r9d, r12d            ; Reset X-coordinate for each row
    xor r10d, r10d           ; Column counter

DrawBitmapColumnLoop:
    mov al, byte [rsi]       ; Load a byte from bitmap into BL
    inc rsi                  ; Manually advance bitmap pointer
    cmp al, 0                ; Check if pixel is transparent (0)
    je DrawBitmapSkipPixel    ; Skip writing if transparent



    ; Call DrawPixel to draw the pixel
    mov eax, r13d            ; Y-coordinate
    mov ebx, r9d             ; X-coordinate

    mov ecx, 1              ; Number of pixels to draw (always 1)
    
    call DrawCharPixel

DrawBitmapSkipPixel:
    inc r9d                  ; Move to the next pixel in the row
    inc r10d                 ; Increment column counter
    cmp r10d, r14d           ; Compare column counter with bitmap width
    jl DrawBitmapColumnLoop   ; If nopt all columns in the row are drawn, repeat

DrawBitmapNextRow:
    inc r13d                 ; Move to the next row
    inc r11d                 ; Increment row counter
    cmp r11d, r15d           ; Compare row counter to bitmap height
    jl DrawBitmapRowLoop     ; If not all rows are drawn, repeat

DrawBitmapEnd:
    ret


FillScreen:
    mov al, bl ; Load the color into AL

    mov ecx, 64000 ; Number of pixels to fill for mode 13h
    rep stosb ; Fill the screen with the specified color
    ret