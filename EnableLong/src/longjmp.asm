bits 16
global longjmp ; expose this entry to other assemblyfiles
extern complete_flush
longjmp:
;    mov al, 2




;_start:
;    xor ax,ax ; set ax to zero
;    cli                         ; 1. Disable interrupts before changing CPU modes

    lgdt [gdt_descriptor]       ; 2. Load the GDT pointer into the GDTR register
    mov eax, cr0   ; cr0 protected mode must be set, otherwise the code wont be executed properly. 
    or eax, 1    ; bit 1 = 1, first bit: protected mode enable
    mov cr0, eax


    ; 3. Execute the long jump. 
    ; 0x08 is the offset to our code segment descriptor in the GDT (8 bytes from start)
    jmp 0x08:complete_flush
    ;mov ax, 0x02



; ==============================================================================
; GLOBAL DESCRIPTOR TABLE (GDT) DEFINITION
; ==============================================================================
align 4                         ; Ensure GDT is aligned in memory for performance

gdt_start:
    ; 1. Null Descriptor (Mandatory first 8 bytes of zeroes)
    dd 0x00000000               
    dd 0x00000000               

    ; 2. Code Segment Descriptor (Offset: 0x08)
    ; Base: 0x00000000, Limit: 0xFFFFF
    ; Access byte: 0x9A (Present, Ring 0, Code segment, Executable, Readable)
    ; Flags: 0xCF (4KB granularity, 32-bit protected mode)
    dw 0xFFFF                   ; Limit (bits 0-15)
    dw 0x0000                   ; Base (bits 0-15)
    db 0x00                     ; Base (bits 16-23)
    db 0x9A                     ; Access byte
    ; 0x9A = 10011010
    ; msb to lsb
    ; 1: Present bit, must be 1 for a valid segment
    ; 00: Highest priviledge, (11: 3, lowest privilage, user privilage)
    ; 1: Descriptor types, 1:=code or data, 0:=system
    ; 1: Executable Bit: 1:=code segment, 0:=data segement
    ; 0: Direction bit: 0:=segement grows up, 1:=segment grows down
    ; 1: R/W bit: for code segment: 0:= read prohibited, 1:= read allowed (for data segment, 0:=write prohibited, 1:=write allowed).
    ; 0: Access bit: this bits flag by CPU as soon as any segment register refer to the segment. Use to identify page fault

    db 0xCF                     ; Flags (4 bits) + Limit (bits 16-19)
    ; 0xCF = 11001111
    ; msb to lsb
    ; 1: Granularity bit: 1:= 4KB page size, 0:=1 Byte page size
    ; 1: Size flag: 1:= 32 bit protectd mode, 0:= 16 bit protected mode. 
    ; 0: Long mode flag: 1:= 64 bit protected code segment, if this bit is set, the size flag (one bit to its left) should always be 0. 0:= any other type
    ; 0: reserved
    ; 1111: MSB of limit section.
    db 0x00                     ; Base (bits 24-31)

    ; 3. Data Segment Descriptor (Offset: 0x10)
    ; Base: 0x00000000, Limit: 0xFFFFF
    ; Access byte: 0x92 (Present, Ring 0, Data segment, Writable)
    ; Flags: 0xCF (4KB granularity, 32-bit protected mode)
    dw 0xFFFF                   ; Limit (bits 0-15)
    dw 0x0000                   ; Base (bits 0-15)
    db 0x00                     ; Base (bits 16-23)
    db 0x92                     ; Access byte
    db 0xCF                     ; Flags (4 bits) + Limit (bits 16-19)
    db 0x00                     ; Base (bits 24-31)
gdt_end:

; GDT Descriptor pointer passed to the 'lgdt' instruction
gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; Size of GDT minus 1 byte, because this is an offset value from the beginning of GDT
    dd gdt_start                ; Linear address where the GDT starts
