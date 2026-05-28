org 0x7C00

start:
    ; Setup segment registers
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; Destination buffer = 0000:7E00
    mov bx, 0x7E00

    ; INT 13h - Read sectors
    mov ah, 0x02        ; Function 02h = Read sectors
    mov al, 0x01        ; Number of sectors to read

    mov ch, 0x00        ; Cylinder 0
    mov cl, 0x02        ; Sector 2
                         ; Sector numbering starts at 1

    mov dh, 0x00        ; Head 0
    mov dl, 0x80        ; Drive 80h = first hard disk

    int 0x13            ; BIOS disk service

    jc disk_error       ; Carry flag set if error

success:
    ; Hang if successful
    cli
    hlt

disk_error:
    ; AH contains error code
    cli
    hlt

times 510 - ($ - $$) db 0
dw 0xAA55
times 1024 - ($ - $$) db 0
