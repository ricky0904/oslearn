global _start:
extern main:


_start:
    cli
    xor ax, ax ; clear ax register
    mov ds, ax
    mov es, ax

    call main

hang:
    jmp hang 


times 510-($-$$) db 0

db 0x55
db 0xAA
