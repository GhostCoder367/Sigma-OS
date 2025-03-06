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

Open_64bit:
    mov edi, 0xB8000
    mov rax, 0x1f201f201f201f20
    mov ecx, 500
    rep stosq
    mov edi, 0x00b8000              
    
    mov rax, 0x1F6C1F6C1F651F48    
    mov [edi],rax
    
    mov rax, 0x1F6F1F571F201F6F
    mov [edi + 8], rax

    mov rax, 0x1F211F641F6C1F72
    mov [edi + 16], rax
    jmp $

times 2048-($-$$) db 0
