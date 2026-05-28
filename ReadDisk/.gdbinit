target remote localhost:1234


set architecture i386
set disassembly-flavor intel

layout asm
layout reg
focus asm
break *0x7C00
break *0x7C19
break *0x7C1B

continue


