[ORG 0x00]
[BITS 16]

SECTION .text

jmp 0x1000:START

START:
    mov ax, 0x1000
    mov ds, ax

    ; test
    mov ax, 0xB800
    mov es, ax

    mov si, 0

    mov ah, 0x07
    mov al, 'H'
    mov [es:si], ax

jmp $

times 512 - ($ - $$) db 0x00
