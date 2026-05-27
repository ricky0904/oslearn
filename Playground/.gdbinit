target remote localhost:1234
file debug_symbols.elf


set architecture i386
set disassembly-flavor intel

layout src
layout reg

hb *_start
continue


