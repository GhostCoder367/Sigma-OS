[org 0x7e00]

jmp StartProtectMode

%include "GDT.asm"
%include "printing.asm"

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

LaunchProtectMode:

    mov ax, data
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    
    mov [0xb8000], byte ' '

    mov [0xb8004], byte 'T'
    mov [0xb8006], byte 'R'
    mov [0xb8008], byte 'O'
    mov [0xb800a], byte 'L'

    mov [0xb800a], byte ' '

    jmp $


times 2048-($-$$) db 0
