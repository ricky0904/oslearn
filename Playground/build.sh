nasm hello.asm -f bin -o hello_raw.bin  # this is nasm original raw binary

nasm -f elf64 -g -F dwarf hello.asm -o hello_elf64.o # this gives elf64 output 
ld -Ttext=0x7c00 hello_elf64.o -o debug_symbols.elf # set function starting point at 0x7c00
objcopy -O binary debug_symbols.elf hello_elf64.bin
objcopy -O binary hello_elf64.o hello_elf64_raw.bin



