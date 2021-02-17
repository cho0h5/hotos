[ORG 0x00]
[BITS 16]

SECTION .text

mov ax, 0xB800
mov es, ax

mov ah, 0x07

mov al, 'H'
mov [es:0x0000], ax
mov al, 'e'
mov [es:0x0002], ax
mov al, 'l'
mov [es:0x0004], ax
mov al, 'l'
mov [es:0x0006], ax
mov al, 'o'
mov [es:0x0008], ax
mov al, ','
mov [es:0x000A], ax
mov al, ' '
mov [es:0x000C], ax
mov al, 'w'
mov [es:0x000E], ax
mov al, 'o'
mov [es:0x0010], ax
mov al, 'r'
mov [es:0x0012], ax
mov al, 'l'
mov [es:0x0014], ax
mov al, 'd'
mov [es:0x0016], ax
mov al, '!'
mov [es:0x0018], ax

jmp $

times 510 - ($ - $$) db 0x00

db 0x55
db 0xAA
