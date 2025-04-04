PageEntry equ 0x1000

; -------------------------------
; Paging Initialization
; -------------------------------
Paging:
    mov edi, PageEntry       ; Set up page directory base
    mov cr3, edi             ; Load page directory base into CR3

; -------------------------------
; Set Up Page Directory Entries
; -------------------------------
    mov dword [edi], 0x2003  ; Map first page table
    add edi, 0x1000          ; Move to next entry

    mov dword [edi], 0x3003  ; Map second page table
    add edi, 0x1000          ; Move to next entry

    mov dword [edi], 0x4003  ; Map third page table
    add edi, 0x1000          ; Move to next entry

; -------------------------------
; Set Up Page Table Entries
; -------------------------------
    mov ebx, 0x00000003      ; Starting address for page table entries
    mov ecx, 512             ; Number of entries to create

.GetEntry:
    mov dword [edi], ebx     ; Write page table entry
    add ebx, 0x1000          ; Increment address by 4 KB
    add edi, 8               ; Move to the next entry
    loop .GetEntry           ; Repeat for all entries

; -------------------------------
; Enable Paging Features
; -------------------------------
    mov eax, cr4             ; Read CR4
    or eax, 1 << 5           ; Enable PAE (Physical Address Extension)
    mov cr4, eax             ; Write back to CR4

; -------------------------------
; Enable Long Mode
; -------------------------------
    mov ecx, 0xC0000080      ; Load MSR for EFER (Extended Feature Enable Register)
    rdmsr                    ; Read MSR
    or eax, 1 << 8           ; Enable Long Mode
    wrmsr                    ; Write back to MSR

; -------------------------------
; Enable Paging in CR0
; -------------------------------
    mov eax, cr0             ; Read CR0
    or eax, 1 << 31          ; Set the paging bit
    mov cr0, eax             ; Write back to CR0

    ret                      ; Return from Paging