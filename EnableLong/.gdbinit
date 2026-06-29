file ./build/debug_symbols64.elf
#add-inferior
#inferior 2
#file ./build/debug_symbols64.elf
#info inferiors
set architecture i386:x86-64
target remote localhost:1234

set disassembly-flavor intel

layout src 
layout reg


#hardware breakpoint
#hb *_start
#hb *a20test 
#hb *set_paging
#hb *complete_flush
#hb *longjmp
#hb *load_gdt64
#hb *entry64
hb *cstart
hb *gdbBreak
#hb *entry64
focus reg
# break main
continue


