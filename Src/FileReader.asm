; -------------------------------
; Constants and Definitions
; -------------------------------
PROGRAM_SPACE equ 0x7e00  ; Memory location to load the program

; -------------------------------
; Read Partition Function
; -------------------------------
ReadPart:
    mov ah, 0x02           ; BIOS function to read sectors
    mov bx, PROGRAM_SPACE  ; Load program into memory at PROGRAM_SPACE
    mov al, 2              ; Number of sectors to read
    mov dl, [BOOT_PART]    ; Boot partition
    mov ch, 0x00           ; Cylinder number
    mov dh, 0x00           ; Head number
    mov cl, 0x02           ; Starting sector number
    
    int 0x13               ; BIOS interrupt to read disk
    
    jc PartReadFailed      ; Jump to error handler if carry flag is set

    ret                    ; Return if successful

; -------------------------------
; Boot Partition Variable
; -------------------------------
BOOT_PART:
    db 0                   ; Boot partition identifier

; -------------------------------
; Error Handling
; -------------------------------
PartReadFailedString:
    db 'Partition read error!', 0  ; Error message string

PartReadFailed:
    mov bx, PartReadFailedString   ; Load error message address into BX
    call Printing                  ; Call printing function to display error
    jmp $                          ; Infinite loop to halt execution