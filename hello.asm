    mov ax, 0x07C0
    mov ds, ax  ; move segment number into ds segment register


    mov si, msg ; move the string location in to offset register ax : si
    cld

ch_loop: lodsb ; lodsb: loading data from memory (location DS:SI or DS:ESI) into AL register 
    or al, al
    jz hang  ; if al is zero, jump to hang, if not keep executing 
    mov ah, 0x0E ; 0x0E TTY output
    mov bh, 0 ; 0 in bh, page number 0
    int 0x10
    jmp ch_loop

hang:

    jmp hang

msg db 'Hello World', 13, 10, 0 ; 13 carriage return \r (return to the beginning of current line, 10 line feed \n move to next line but not the beginning. 0 null.   
    times 510-($-$$) db 0
    
    db 0x55
    db 0xAA
