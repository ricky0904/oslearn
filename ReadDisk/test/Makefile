all:
	gcc -m32 -g -c boot.asm -o boot.o
	gcc -m32 -g -c main.c -o main.o -ffreestanding -fno-pie -O0
	ld -m elf_i386 -Ttext 0x7C00 -no-pie boot.o main.o -o os_image.elf
	objcopy -O binary os_image.elf os_image.raw

clean:
	rm -f *.o *.elf *.raw

