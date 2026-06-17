bits 32
global load_gdt64
extern entry

; extern gdt_descriptor
; 64bit gdt fields
; Access bits
PRESENT        equ 1 << 7
NOT_SYS        equ 1 << 4
EXEC           equ 1 << 3
DC             equ 1 << 2
RW             equ 1 << 1
ACCESSED       equ 1 << 0

; Flags bits
GRAN_4K       equ 1 << 7
SZ_32         equ 1 << 6
LONG_MODE     equ 1 << 5


load_gdt64:
	lgdt [gdt_descriptor]
	jmp 0x08:Realm64

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

    db 0xAF                     ; Flags (4 bits) + Limit (bits 16-19)
    ; 0xCF = 10101111
    ; msb to lsb
    ; 1: Granularity bit: 1:= 4KB page size, 0:=1 Byte page size
    ; 0: Size flag: 1:= 32 bit protectd mode, 0:= 16 bit protected mode. 
    ; 1: Long mode flag: 1:= 64 bit protected code segment, if this bit is set, the size flag (one bit to its left) should always be 0. 0:= any other type
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


bits 64			
Realm64:
	mov rax, 0x1122334455667788
	mov r8, 0x1122334455667788
	mov rax, 0x0
	cpuid 

	mov rax, 0x1
	jmp entry
;	add r8, 5
;	mov r8d, 0x0776
	;mov rax, 0xB8000
	;mov WORD [rax], r8d
	jmp $


