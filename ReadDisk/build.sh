# nasm boot.asm -f bin -o boot_raw.bin  # this is nasm original raw binary
nasm ./src/boot.asm -o image.bin # this gives elf64 output 

# nasm -f elf16 -g -F dwarf ./src/boot.asm -o ./build/boot_elf16.o # this gives elf64 output 
# gcc -m32 -c ./src/boot.asm -o ./build/boot_elf32.o
# gcc -m32 -g -O0 -c ./src/hello.c -o ./build/hello.o -fno-pie -ffreestanding # compile with debugg flags 
# ld -m elf_i386 -Ttext=0x7c00 ./build/boot_elf16.o -o ./build/debug_symbols.elf # set function starting point at 0x7c00
# objcopy -O binary ./build/debug_symbols.elf image.bin
# objcopy -O binary hello_elf64.o hello_elf64_raw.bin



