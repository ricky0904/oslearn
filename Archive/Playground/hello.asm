
global _start:

_start:
	jmp _start


times 510-($-$$) db 0
db 0x55
db 0xAA
