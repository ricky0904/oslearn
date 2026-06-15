
image.bin: ./build/debug_symbols.elf 
	objcopy -O binary ./build/debug_symbols.elf image.bin

./build/boot_elf32.o: ./src/boot.asm 
	nasm -f elf32 -g -F dwarf ./src/boot.asm -o ./build/boot_elf32.o # this gives elf64 output 
./build/a20test_elf32.o: ./src/a20test.asm 
	nasm -f elf32 -g -F dwarf ./src/a20test.asm -o ./build/a20test_elf32.o # this gives elf64 output 
./build/longjmp_elf32.o: ./src/longjmp.asm 
	nasm -f elf32 -g -F dwarf ./src/longjmp.asm -o ./build/longjmp_elf32.o # this gives elf64 output 
./build/cpuidtest_elf32.o: ./src/cpuidtest.asm 
	nasm -f elf32 -g -F dwarf ./src/cpuidtest.asm -o ./build/cpuidtest_elf32.o # this gives elf64 output 
./build/debug_symbols.elf: ./build/boot_elf32.o ./build/a20test_elf32.o ./build/longjmp_elf32.o ./build/cpuidtest_elf32.o 
	ld -m elf_i386 -Ttext=0x7c00 ./build/boot_elf32.o ./build/a20test_elf32.o ./build/longjmp_elf32.o ./build/cpuidtest_elf32.o -o ./build/debug_symbols.elf # set function starting point at 0x7c00



