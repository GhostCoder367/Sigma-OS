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




FillScreen:
    mov al, bl ; Load the color into AL

    mov ecx, 64000 ; Number of pixels to fill for mode 13h
    rep stosb ; Fill the screen with the specified color
    ret    