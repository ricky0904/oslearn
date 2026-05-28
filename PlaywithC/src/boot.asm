global _start:
extern main:
bits 16

_start:
    xor ax, ax ; clear ax register
    mov ds, ax
    mov es, ax
    cld

    ;reading sector from hard drive

    mov ah, 0x02;  second function read section
    mov al, 1;  read two sectors
    mov ch, 0; cylinder number 0
    mov cl, 2; index of sector being read - 2
    mov dh, 0; head number 0
    mov dl, 0x80; drive number


    xor bx, bx;
    mov es, bx;
    mov bx, 7E00h; read data to ES:BX
    int 0x13 
     

    jc hang



    call main



hang:
    jmp hang 


times 510-($-$$) db 0

db 0x55
db 0xAA
section .note.GNU-stack noalloc noexec nowrite progbits
