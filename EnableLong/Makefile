NFLAGS = -f elf64 -g -F dwarf
CFLAGS = -m64 -gdwarf -O0 -c
image.bin: ./build/debug_symbols.elf 
	objcopy -O binary ./build/debug_symbols.elf image.bin

./build/boot_elf32.o: ./src/boot.asm 
	nasm $(NFLAGS) ./src/boot.asm -o ./build/boot_elf32.o # this gives elf64 output 
./build/a20test_elf32.o: ./src/a20test.asm 
	nasm $(NFLAGS) ./src/a20test.asm -o ./build/a20test_elf32.o # this gives elf64 output 
./build/longjmp_elf32.o: ./src/longjmp.asm 
	nasm $(NFLAGS) ./src/longjmp.asm -o ./build/longjmp_elf32.o # this gives elf64 output 
./build/cpuidtest_elf32.o: ./src/cpuidtest.asm 
	nasm $(NFLAGS) ./src/cpuidtest.asm -o ./build/cpuidtest_elf32.o # this gives elf64 output 
./build/setpaging_elf32.o: ./src/setpaging.asm 
	nasm $(NFLAGS) ./src/setpaging.asm -o ./build/setpaging_elf32.o # this gives elf64 output 
./build/longstart_elf32.o: ./src/longstart.asm 
	nasm $(NFLAGS) ./src/longstart.asm -o ./build/longstart_elf32.o # this gives elf64 output 
./build/entry_elf64.o: ./src/entry.c 
	gcc $(CFLAGS) ./src/entry.c -o ./build/entry_elf64.o -fno-pie -ffreestanding # this gives elf64 output 
	#gcc -m32 -g -O0 -c ./src/printchar.c -o ./build/printchar.o -fno-pie -ffreestanding # compile with debugg flags 


./build/debug_symbols.elf: ./build/boot_elf32.o ./build/a20test_elf32.o ./build/longjmp_elf32.o ./build/cpuidtest_elf32.o ./build/setpaging_elf32.o ./build/longstart_elf32.o ./build/entry_elf64.o
	ld -m elf_x86_64 -Ttext=0x7c00 ./build/boot_elf32.o ./build/a20test_elf32.o ./build/longjmp_elf32.o ./build/cpuidtest_elf32.o ./build/setpaging_elf32.o ./build/longstart_elf32.o ./build/entry_elf64.o -o ./build/debug_symbols.elf # set function starting point at 0x7c00



