bits 32

global set_paging

PML4T_ADDR equ 0x1000
SIZEOF_PAGE_TABLE equ 4096
PML4T_ADDR equ 0x1000
PDPT_ADDR equ 0x2000
PDT_ADDR equ 0x3000
PT_ADDR equ 0x4000

; the page table only uses certain parts of the actual address
PT_ADDR_MASK equ 0xffffffffff000
PT_PRESENT equ 1                 ; marks the entry as in use, in memory or in hard drive
PT_READABLE equ 2                ; marks the entry as r/w

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

	
		
	mov eax, 2

	jmp $
