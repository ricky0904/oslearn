; hello_bios_rom.asm - Direct video memory Hello World
[bits 16]
[org 0x7c00]          ; We'll copy this to the reset vector later

start:
    cli

    ; Setup segments
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00

    ; Optional: Try to set text mode
    mov ax, 0x0003
    int 0x10

    ; Direct write to VGA text memory (most reliable)
    mov ax, 0xB800
    mov es, ax
    xor di, di

    mov si, msg
    mov ah, 0x1F          ; White text on blue background

print_loop:
    lodsb
    or al, al
    jz done
    stosw                 ; Store char + attribute
    jmp print_loop

done:
    hlt
    jmp done

msg db 'Hello, World! from custom BIOS ROM', 0

; Pad to 512 bytes + boot signature
times 510 - ($ - $$) db 0
dw 0xAA55
