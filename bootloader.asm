[ORG 0x00]
[BITS 16]

SECTION .text

mov ax, 0xB800
mov es, ax

.PRINTMESSAGE:
    mov ah, 0x07
    mov si, 0
    mov di, 0

.PRINTMESSAGELOOP:
    mov al, byte [si+MESSAGE+0x7C00]
    mov [es:di], ax
    add si, 1
    add di, 2

    cmp al, 0
    je .PRINTMESSAGEEND

    jmp .PRINTMESSAGELOOP

.PRINTMESSAGEEND:

jmp $

MESSAGE: db 'Hello, world!', 0;

times 510 - ($ - $$) db 0x00

db 0x55
db 0xAA
