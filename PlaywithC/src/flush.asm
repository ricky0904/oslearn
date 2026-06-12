bits 32
global complete_flush:
complete_flush:
    ; 4. Update all data segment registers to point to our data segment selector (0x10)
     mov ebx, 0x11223344                
;   mov ds, ax
;    mov es, ax
;    mov fs, ax
;    mov gs, ax
;    mov ss, ax

    ; 5. Update the stack pointer to a safe memory area
;    mov esp, 0x90000            

 ;   mov ebx, 0x000B8000;
 ;   mov byte [ebx], 'P';
    ; Your protected mode code goes here
 ;   jmp $                       ; Infinite loop to halt execution Safely












