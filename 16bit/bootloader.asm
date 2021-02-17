[ORG 0x00]
[BITS 16]

SECTION .text

jmp 0x07C0:START

START:
    call PRINTCLEAR

    mov ax, 0x07C0
    mov ds, ax

    push ENTER16MESSAGE
    push 0
    push 0
    call PRINTMESSAGE
    add sp, 6

jmp $

PRINTMESSAGE:
    push bp
    mov bp, sp

    push es
    push si
    push di
    push ax

    mov ax, 0xB800
    mov es, ax

    mov ax, word [bp + 6]
    mov si, 160
    mul si
    add ax, word [bp + 4]
    add ax, word [bp + 4]
    mov di, ax
    mov si, word [bp + 8]

    mov ah, 0x07

.PRINTMESSAGELOOP:
    mov al, byte [si]
    mov [es:di], ax
    add si, 1
    add di, 2

    cmp al, 0
    je .PRINTMESSAGEEND

    jmp .PRINTMESSAGELOOP

.PRINTMESSAGEEND:
    pop ax
    pop di
    pop si
    pop es

    pop bp
    ret

PRINTCLEAR:
    push bp
    mov bp, sp

    push ax
    push es
    push di

    mov ax, 0xB800
    mov es, ax
    
    mov di, 0

    mov ah, 0x07
    mov al, 0x00


.PRINTCLEARLOOP:
    cmp di, 4000
    je .PRINTCLEAREND

    mov [es:di], ax
    add di, 2
    jmp .PRINTCLEARLOOP
    

.PRINTCLEAREND:
    pop di
    pop es
    pop ax

    pop bp
    ret
    

ENTER16MESSAGE: db 'ENTER REAL MODE (16bit)', 0;

times 510 - ($ - $$) db 0x00

db 0x55
db 0xAA
