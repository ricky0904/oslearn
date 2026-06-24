bits 64
global _start
extern cstart

_start: 
	incbin "./build/bootto64.bin" ; the relative path to make file
entry64:
	align 8
	mov ax, 0x10
;	align 8
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov ss, ax  ; flush the registers
	jmp cstart
