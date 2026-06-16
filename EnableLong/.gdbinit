file ./build/debug_symbols.elf
set architecture i386:x86-64
target remote localhost:1234

set disassembly-flavor intel

layout asm
layout reg


#hardware breakpoint
#hb *_start
#hb *a20test 
#hb *set_paging
#hb *complete_flush
hb *longjmp
hb *enable_PAE
# break main
continue


