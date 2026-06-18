bits 32

global complete_flush:
extern set_paging:
EFLAGS_ID equ 1 << 21
CPUID_EXTENSIONS equ 0x80000000; 32 bit value, EAX Maximum input value for entended CPUID information 
CPUID_FEATURES equ 0x80000001; Extended processor signature and feature bits
CPUID_EDX_EXT_FEAT_LM equ 1<<29; bit 19, Intel A64 Enable
CR0_PAGING equ 1<<31


complete_flush:
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	
	mov esp, 0x90000  ; set stack base position

	call checkCPUID
	
	mov eax, CPUID_EXTENSIONS
	cpuid
	cmp eax, CPUID_FEATURES 
	jb .NoLongMode  ; No long mode is a local lable, move it outside complete_flush will cause assembly error
	mov eax, CPUID_FEATURES
	cpuid
	test edx, CPUID_EDX_EXT_FEAT_LM 
	jz .NoLongMode
		
	
	call disablePaging
		
	
	jmp set_paging

	.NoLongMode:
	jmp $

disablePaging:
; set bit 31 in cr0 to zero 
	mov eax, cr0 
	and eax, ~CR0_PAGING
	mov cr0, eax 
	xor eax, eax
	ret


checkCPUID:
	pushfd ; push flag register
	pop eax ; eflags => eax register
	
	mov ecx, eax
	xor eax, EFLAGS_ID ; flip bit 21 in eax

	push eax
	popfd ; write back to eflags
	pushfd ; 
	pop eax ; write eflag value back to eax, if cpuid is supported, bit 21 remains 1, if cpuid is not supoorted, eax remain 0


	push ecx;
	popfd;  restore original value of eflags


	xor eax, ecx;
	jnz .supported

	.notsupported:
		mov ax, 0
		ret
	.supported:
		mov ax, 1
		ret

