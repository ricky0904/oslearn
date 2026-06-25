OUTPUT_FORMAT("elf64-x86-64")
MEMORY
{
	FLASH (rx): ORIGIN = 0x7c00, LENGTH = 2K
	RAM (rw): ORIGIN = 0x8400, LENGTH = 2K
}
SECTIONS

{
	. = 0x7c00;
	.text : { ./build/entry64.o ./build/cstart.o(.text) } > FLASH
	.data : { ./build/entry64.o ./build/cstart.o(.data) } > RAM 
	.bss : { ./build/entry64.o ./build/cstart.o(.bss) } > RAM
	.rodata : { ./build/entry64.o ./build/cstart.o(.rodata) } > FLASH
	.data.rel.local : { ./build/entry64.o ./build/cstart.o(.data.rel.local) } > RAM
	.eh_frame : {
		./build/cstart.o(.eh_frame);
		}
}

