[ORG 0x10200]
[BITS 32]

SECTION .text

mov eax, 0
mov edi, eax
mov ah, 0x07
mov al, '%'
mov [edi + 0xB8000], ax

jmp $

times 512 - ($ - $$) db 0x00