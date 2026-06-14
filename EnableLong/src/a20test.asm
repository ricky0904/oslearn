bits 16


;enable_a20_bios:
;	push ax
;	mov ax, 0x2401
;	int 0x15
;	pop ax
extern longjmp

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


	mov al, byte [es:di]
	push ax


	mov al, byte [ds:si]
	push ax


	mov byte [es:di], 0x00	
	mov byte [ds:si], 0xFF

	cmp byte [es:di], 0xFF  ; compare the data in es:di and ds:si, if they are the same means A20 is not active

	pop ax
	mov byte [ds:si], al


	pop ax 
	mov byte [es:di], al

	mov ax, 0

	je a20testexit

	mov ax, 1      ; if they are not same je will not happen, ax loaded with 1


    jmp longjmp

a20testexit:
	pop es
	pop ds
	pop	di
	pop si
	popf
	ret      ; clear the stack
	;mov al, [ds:si]
	;mov byte [.BufferBelowMB], al
	;mov al, [es:di]
	;mov byte [.BufferOverMB], al


	;.BufferBelowMB db 0
	;.BufferOverMB db 0
	section .note.GNU-stack noalloc noexec nowrite progbits
