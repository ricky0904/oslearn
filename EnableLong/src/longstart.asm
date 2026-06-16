bits 32
global load_gdt64
extern gdt_descriptor
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
bits 64			
Realm64:
	mov rax, 1
	jmp $


