[org 0x7c00]

mov [BOOT_PART], dl
mov bp, 0x7c00
mov sp, bp
;mov ah, 0x00
;mov al, 0x13
;int 0x10




    

call ReadPart

jmp PROGRAM_SPACE

%include "printing.asm"
%include "FileReader.asm"

times 510-($-$$) db 0 

dw 0xaa55      