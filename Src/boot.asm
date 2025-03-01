[org 0x7c00]

mov [BOOT_PART], dl
mov bp, 0x7c00
mov sp, bp
mov ah, 0x00
mov al, 0x13
int 0x10

   
    mov si, 100   
    mov di, 100


    mov cx, 10  
    mov dx, 10  


draw_square:

    push cx
    mov cx, 50


    mov bx, si        
    mov bh, 200
    
draw_row:

    mov ah, 0x0C       
    mov al, 50  
    mov cx, bx        
    mov dx, di       
    int 0x10           


    inc bx
    loop draw_row     

   
    inc di
    pop cx
    loop draw_square    
call ReadPart

jmp PROGRAM_SPACE

%include "printing.asm"
%include "FileReader.asm"

times 510-($-$$) db 0 

dw 0xaa55      