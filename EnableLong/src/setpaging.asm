bits 32

global set_paging
extern Realm64

PML4T_ADDR equ 0x11000
SIZEOF_PAGE_TABLE equ 4096
PDPT_ADDR equ 0x12000
PDT_ADDR equ 0x13000
PT_ADDR equ 0x14000

; the page table only uses certain parts of the actual address
PT_ADDR_MASK equ 0xffffffffff000
PT_PRESENT equ 1                 ; marks the entry as in use, in memory or in hard drive
PT_READABLE equ 2                ; marks the entry as r/w

ENTRIES_PER_PT equ 512 ; number of entries in each table
SIZEOF_PT_ENTRY equ 8 ; size of each entry
PAGE_SIZE equ 0x1000 ; 4096 page size

CR4_PAE_ENABLE equ 1 << 5 ; enable PAE bits in CR4

EFER_MSR equ 0xC0000080 ; EFER (Extended Feature Enable Register) - Address 
EFER_LM_ENABLE equ 1 << 8 ; Bit 8, Enable Long mode

CR0_PM_ENABLE equ 1 << 0; bit 0, enable protected mode
CR0_PG_ENABLE equ 1 << 31; bit 31, enable paging


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





set_paging:
	
	mov edi, PML4T_ADDR
	mov cr3, edi       ; cr3 lets the CPU know where the page tables are

   	xor eax, eax
	mov ecx, SIZEOF_PAGE_TABLE
    	rep stosd          ; writes 4 * SIZEOF_PAGE_TABLE bytes, which is enough space
                       ; for the 4 page tables
	mov edi, cr3       ; reset di back to the beginning of the page table	
	; edi was previously set to PML4T_ADDR
  	mov DWORD [edi], PDPT_ADDR & PT_ADDR_MASK | PT_PRESENT | PT_READABLE

    	mov edi, PDPT_ADDR
    	mov DWORD [edi], PDT_ADDR & PT_ADDR_MASK | PT_PRESENT | PT_READABLE

    	mov edi, PDT_ADDR
    	mov DWORD [edi], PT_ADDR & PT_ADDR_MASK | PT_PRESENT | PT_READABLE

	mov edi, PT_ADDR
	mov ebx, PT_PRESENT | PT_READABLE	
	mov ecx, ENTRIES_PER_PT
	
	.SetEntry:
		mov DWORD [EDI], ebx
		add ebx, PAGE_SIZE
		add edi, SIZEOF_PT_ENTRY
		loop .SetEntry

enable_PAE:
	mov eax, cr4
	or eax, CR4_PAE_ENABLE 
	mov cr4, eax

enable_LM:
	mov ecx, EFER_MSR  
	rdmsr ; read MSR where address in ecx
	or eax, EFER_LM_ENABLE  
	wrmsr

enable_PG_PM:  ; enable paging and protected mode
	mov eax, cr0
	or eax, CR0_PG_ENABLE | CR0_PM_ENABLE	
	mov cr0,  eax

;bits 64
;
long_jmp:
	
	lgdt [GDT.Pointer]
	jmp GDT.Code:Realm64
			
GDT:
    .Null: equ $ - GDT
        dq 0
    .Code: equ $ - GDT
        .Code.limit_lo: dw 0xffff
        .Code.base_lo: dw 0
        .Code.base_mid: db 0
        .Code.access: db PRESENT | NOT_SYS | EXEC | RW
        .Code.flags: db GRAN_4K | LONG_MODE | 0xF   ; Flags & Limit (high, bits 16-19)
        .Code.base_hi: db 0
    .Data: equ $ - GDT
        .Data.limit_lo: dw 0xffff
        .Data.base_lo: dw 0
        .Data.base_mid: db 0
        .Data.access: db PRESENT | NOT_SYS | RW
        .Data.Flags: db GRAN_4K | SZ_32 | 0xF       ; Flags & Limit (high, bits 16-19)
        .Data.base_hi: db 0
    .Pointer:
        dw $ - GDT - 1
        dq GDT
;
;
;

	;mov eax, 2

	;jmp $
