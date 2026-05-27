.intel_syntax noprefix   # Force GCC to use Intel format instead of AT&T
.code16                  # Tell the assembler to emit 16-bit Real Mode instructions
.global _start

_start:
    # 1. Clear interrupts during critical CPU setup
    cli                  

    # 2. Reset the main Data and Extra segment registers to 0x0000
    xor ax, ax           
    mov ds, ax           
    mov es, ax           
    mov ss, ax           # Stack Segment is also set to 0

    # 3. Setup a safe Stack Pointer (growing down from 0x7C00)
    # This is crucial for the 32-bit operations injected by .code16gcc
    mov sp, 0x7C00       
    mov esp, 0x7C00      # Initialize the 32-bit stack register variant

    # 4. Re-enable hardware interrupts now that segments and stack are safe
    sti                  

    # 5. Jump straight into your C code main function
    call main            

    # 6. Infinite loop fallback just in case the C code main returns
hang:
    hlt                  # Halt the CPU to save power
    jmp hang             # Loop forever if an interrupt wakes it up

    # 7. Pad out the remainder of the 512-byte sector with zeros
    # '.' means current address, '_start' is the beginning address
    .fill 510 - (. - _start), 1, 0
    
    # 8. Mandatory 2-byte BIOS Boot Signature (0xAA55)
    # The BIOS will not boot this file in QEMU if these exact bytes are missing!
    .word 0xAA55         

