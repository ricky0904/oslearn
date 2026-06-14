// 1. Force the compiler to use 16-bit real mode instructions for early booting
__asm__(".code16gcc\n");

// 2. Define the main function called by boot.asm
void main() {
    // Pointer to the start of VGA text mode video memory
    // In text mode, the screen is a flat array of characters starting at 0xB8000
    char *video_memory = (char *)0xB8000;
    
    // Each character on screen takes up 2 bytes of memory:
    // Byte 1: The ASCII character code
    // Byte 2: The Color Attribute (0x07 = Light Grey text on a Black background)
    
    // Write 'H' to the top-left corner (Index 0 and 1)
    video_memory[0] = 'H';
    video_memory[1] = 0x07;
    
    // Write 'I' to the second slot (Index 2 and 3)
    video_memory[2] = 'I';
    video_memory[3] = 0x07;

    // 3. Infinite loop to prevent the CPU from running off into random memory
    while(1) {
        // Sit idle inside this block forever
    }
}

