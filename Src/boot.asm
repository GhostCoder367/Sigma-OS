[org 0x7c00]

mov [BOOT_PART], dl
mov bp, 0x7c00
mov sp, bp
mov ah, 0x00
mov al, 0x12
int 0x10

mov ah, 0Ch
mov bh, 0

mov al, 50
mov cx, 50
mov dx, 50
int 0x10

call ReadPart

jmp PROGRAM_SPACE

%include "printing.asm"
%include "FileReader.asm"

times 510-($-$$) db 0 

dw 0xaa55      