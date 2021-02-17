[ORG 0x00]
[BITS 16]

SECTION .text

START:
    mov ax, 0x1000
    mov ds, ax
    mov es, ax

    cli
    lgdt [GDTR]
    mov eax, cr0
    or al, 1
    mov cr0, eax

    jmp dword 0x08:(PROTECTEDMODE - $$ + 0x10000)

[BITS 32]
PROTECTEDMODE:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ss, ax
    mov esp, 0xFFFE
    mov ebp, 0xFFFE

    push (ENTER32MESSAGE - $$ + 0x10000)
    push 2
    push 0
    call PRINTMESSAGE
    add esp, 12

    jmp $

PRINTMESSAGE:
    push ebp
    mov ebp, esp

    push esi
    push edi
    push eax

    mov eax, dword [bp + 12]
    mov esi, 160
    mul esi
    add eax, dword [bp + 8]
    add eax, dword [bp + 8]
    mov edi, eax
    mov esi, dword [bp + 16]

    mov ah, 0x07

.PRINTMESSAGELOOP:
    mov al, byte [esi]
    mov [edi + 0xB8000], ax
    add esi, 1
    add edi, 2

    cmp al, 0
    je .PRINTMESSAGEEND

    jmp .PRINTMESSAGELOOP

.PRINTMESSAGEEND:
    pop eax
    pop edi
    pop esi

    pop ebp
    ret

GDTR:
    dw GDTEND - GDT - 1
    dd GDT - $$ + 0x10000

GDT:
    NULLDESCRIPTOR:
        dw 0x0000
        dw 0x0000
        db 0x00
        db 0x00
        db 0x00
        db 0x00
    CODEDESCRIPTOR:
        dw 0xFFFF
        dw 0x0000
        db 0x00
        db 0x9A
        db 0xCF
        db 0x00
    DATADESCRIPTOR:
        dw 0xFFFF
        dw 0x0000
        db 0x00
        db 0x92
        db 0xCF
        db 0x00
GDTEND:

ENTER32MESSAGE: db 'ENTER PROTECTED MODE (32bit)', 0

times 512 - ($ - $$) db 0x00
