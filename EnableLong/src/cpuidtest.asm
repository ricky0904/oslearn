bits 32

global complete_flush:
EFLAGS_ID equ 1 << 21

complete_flush:
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax


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
	mov eax, 0x2

	.notsupported:
		mov ax, 0
		ret
	.supported:
		mov ax, 1
		ret
