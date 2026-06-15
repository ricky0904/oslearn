bits 32

global complete_flush:
EFLAGS_ID equ 1 << 21
CPUID_EXTENSIONS equ 0x80000000; 32 bit value, EAX Maximum input value for entended CPUID information 
CPUID_FEATURES equ 0x80000001; Extended processor signature and feature bits
CPUID_EDX_EXT_FEAT_LM equ 1<<29; bit 19, Intel A64 Enable


complete_flush:
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	call checkCPUID
	
	mov eax, CPUID_EXTENSIONS
	cpuid
	cmp eax, CPUID_FEATURES 
	jb .NoLongMode  ; No long mode is a local lable, move it outside complete_flush will cause assembly error
	mov eax, CPUID_FEATURES
	cpuid
	test edx, CPUID_EDX_EXT_FEAT_LM 
	jz .NoLongMode
		
	
	mov eax, 02
	.NoLongMode:
	jmp $



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

