bits 16

a20test:

	pushf
	push si
	push di
	push ds
	push es
	cli


	xor ax, ax
	mov ds, ax
	mov si, 0x0500 ; ds:si = 0x0000:0x0500 = 0x00000500

	not ax
	mov es, ax
	mov di, 0x0510 ; es:di = 0xFFFF:0x0510 = 0x00100500	


	mov al, [ds:si]
	mov byte [.BufferBelowMB], al
	mov al, [es:di]
	mov byte [.BufferOverMB], al


	.BufferBelowMB db 0
	.BufferOverMB db 0
	section .note.GNU-stack noalloc noexec nowrite progbits
