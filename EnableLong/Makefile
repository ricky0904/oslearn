NFLAGS = -f elf32 -g -F dwarf
NFLAGS64 = -f elf64 -g -F dwarf

./build/entry64.bin: ./build/debug_symbols64.elf 
	objcopy -O binary ./build/debug_symbols64.elf ./build/entry64.bin

./build/debug_symbols64.elf: ./build/entry64.o
	ld -m elf_x86_64 ./build/entry64.o -o ./build/debug_symbols64.elf # set function starting point at 0x7c00

./build/entry64.o: ./src/entry64.asm ./build/bootto64.bin
	nasm $(NFLAGS64) ./src/entry64.asm -o ./build/entry64.o # this gives elf64 output 
./build/bootto64.bin: ./build/debug_symbols.elf 
	objcopy -O binary ./build/debug_symbols.elf ./build/bootto64.bin

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


./build/debug_symbols.elf: ./build/boot_elf32.o ./build/a20test_elf32.o ./build/longjmp_elf32.o ./build/cpuidtest_elf32.o ./build/setpaging_elf32.o ./build/longstart_elf32.o
	ld -m elf_i386 -Ttext=0x7c00 ./build/boot_elf32.o ./build/a20test_elf32.o ./build/longjmp_elf32.o ./build/cpuidtest_elf32.o ./build/setpaging_elf32.o ./build/longstart_elf32.o -o ./build/debug_symbols.elf # set function starting point at 0x7c00




