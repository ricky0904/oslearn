[ORG 0x7C00]

	xor ax, ax
	mov ds, ax ; zero data segment reg
	mov ss, ax ; zero stack segment reg
	mov sp, 0x9C00; location of stack pointer
	
	cld ; clear direciton flag (SI and DI increment by 1)

	mov ax, 0xb800; text video memory
	mov es, ax ; es: extra data segment register
	mov si, msg ; show text string
	
	lodsb ; load ds:si into al
	mov ah, 0xF
	mov [es:di], ax
		

	

hang:
	jmp hang		
	
dochar: call cprint ; print one char
sprint: 
	lodsb
	cmp al, 0
	jne dochar
	add byte [ypos], 1
	mov byte [xpos], 0
	ret



cprint:
	mov ah, 0x0F ;white font
	mov cx, ax ; make a copy of ax into cx, al - char, ah - font, for recovery later
	movzx ax, byte [ypos] ; al holds y coordinate, and padding ah with zero 
	mov dx, 160;  tty has 160 columns, each column hold 2 bytes
	mul dx; multiply dx with ax and save result in ax
	movzx bx, byte [xpos] ; bx holds x position
	shl bx, 1 ; avoiding attrib


	mov di, 0; 

	


	xpos db 0
	ypos db 0

	msg db "What are you doing, Dave?", 0

	times 510-($-$$) db 0

	db 0x55
	db 0xAA
