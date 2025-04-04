; -------------------------------
; CPU Feature Detection
; -------------------------------
CPU_Detection:
    pushfd                  ; Save EFLAGS to the stack
    pop eax                 ; Load EFLAGS into EAX
    mov ecx, eax            ; Save original EFLAGS in ECX
    xor eax, 1 << 21        ; Toggle the ID flag (bit 21)

    push eax                ; Save modified EFLAGS to the stack
    popfd                   ; Load modified EFLAGS into EFLAGS

    pushfd                  ; Save modified EFLAGS to the stack
    pop eax                 ; Load modified EFLAGS into EAX

    push ecx                ; Restore original EFLAGS from ECX
    popfd                   ; Load original EFLAGS into EFLAGS

    xor eax, ecx            ; Check if the ID flag was successfully toggled
    jz NoCPU                ; Jump if the CPU does not support CPUID

    ret                     ; Return if the CPU supports CPUID

; -------------------------------
; Long Mode Detection
; -------------------------------
LongMode_Detection:
    mov eax, 0x80000001     ; Query extended CPU features
    cpuid                   ; Execute CPUID instruction
    test edx, 1 << 29       ; Check if the Long Mode bit (bit 29) is set
    jz LongMode_Disable     ; Jump if Long Mode is not supported
    ret                     ; Return if Long Mode is supported

; -------------------------------
; Error Handlers
; -------------------------------
LongMode_Disable:
    hlt                     ; Halt the CPU (Long Mode is not supported)

NoCPU:
    hlt                     ; Halt the CPU (CPUID is not supported)