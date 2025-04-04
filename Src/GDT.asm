; -------------------------------
; Global Descriptor Table (GDT)
; -------------------------------

; Null Descriptor
gdt_null:
    dd 0                    ; Null descriptor (all zeros)
    dd 0

; Code Segment Descriptor
gdt_code:
    dw 0xFFFF               ; Segment limit (low 16 bits)
    dw 0x0000               ; Base address (low 16 bits)
    db 0x00                 ; Base address (middle 8 bits)
    db 10011010b            ; Access flags (code segment)
    db 11001111b            ; Flags and segment limit (high 4 bits)
    db 0x00                 ; Base address (high 8 bits)

; Data Segment Descriptor
gdt_data:
    dw 0xFFFF               ; Segment limit (low 16 bits)
    dw 0x0000               ; Base address (low 16 bits)
    db 0x00                 ; Base address (middle 8 bits)
    db 10010010b            ; Access flags (data segment)
    db 11001111b            ; Flags and segment limit (high 4 bits)
    db 0x00                 ; Base address (high 8 bits)

; End of GDT
gdt_end:

; GDT Descriptor
gdt_criptor:
    gdt_size:
        dw gdt_end - gdt_null - 1  ; Size of GDT (in bytes) minus 1
        dq gdt_null                ; Address of the GDT

; -------------------------------
; Segment Offsets
; -------------------------------
code equ gdt_code - gdt_null       ; Offset for code segment
data equ gdt_data - gdt_null       ; Offset for data segment

; -------------------------------
; Edit GDT Function
; -------------------------------
[bits 32]
EditGDT:
    mov [gdt_code + 6], byte 10101111b ; Modify GDT code segment flags
    mov [gdt_code + 6], byte 10101111b ; Modify GDT code segment flags
    ret

[bits 16]
