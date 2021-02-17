[ORG 0x00]
[BITS 16]

SECTION .text

jmp 0x07C0:START

START:
    mov ax, 0x07C0
    mov ds, ax

    ; stack
    mov ax, 0x0000
    mov ss, ax
    mov sp, 0xFFFE
    mov bp, 0xFFFE

    ; print message
    call PRINTCLEAR

    push ENTER16MESSAGE
    push 0
    push 0
    call PRINTMESSAGE
    add sp, 6

    ; disk load
    mov ax, 0x1000
    mov es, ax
    mov bx, 0x0000
    mov di, word 1024

.READDISKLOOP:
    cmp di, 0
    je .READDISKEND
    sub di, 0x1

    mov ah, 0x02
    mov al, 0x01
    mov cl, [SECTOR]
    mov dh, [HEAD]
    mov ch, [TRACK]
    mov dl, 0x00

    int 0x13

    add si, 0x0020
    mov es, si

    cmp byte [SECTOR], 18
    jne .READDISKLOOP
    
    mov al, byte [SECTOR]
    add al, 1
    mov byte [SECTOR], al

    xor byte [HEAD], 0x01
    cmp byte [HEAD], 1
    je .READDISKLOOP

    mov al, byte [TRACK]
    add al, 1
    mov byte [TRACK], al
    jmp .READDISKLOOP

.READDISKEND:

    push COMPLETEREADDISKMESSAGE
    push 1
    push 0
    call PRINTMESSAGE
    add sp, 6

jmp $

; function
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
    
; variable
ENTER16MESSAGE: db 'ENTER REAL MODE (16bit)', 0;
COMPLETEREADDISKMESSAGE: db 'COMPLETE READ DISK (1024 SECTOR)', 0;

SECTOR: db 2
HEAD: db 0
TRACK: db 0

times 510 - ($ - $$) db 0x00

db 0x55
db 0xAA
