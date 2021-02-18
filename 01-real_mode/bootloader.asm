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
    mov ax, 0
    mov dl, 0
    int 0x13
    jc DISKREADERROR1

    mov si, 0x1000
    mov es, si
    mov bx, 0x0000
    mov di, word 1

.READDISKLOOP:
    cmp di, 0
    je .READDISKEND
    sub di, 0x1

    mov ah, 0x02
    mov al, 0x1
    mov cl, byte [SECTOR]
    mov dh, byte [HEAD]
    mov ch, byte [TRACK]
    mov dl, 0x00

    int 0x13
    jc DISKREADERROR2

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

    jmp 0x1000:0x0000

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

DISKREADERROR1:
    push DISKERRORMESSAGE1
    push 1
    push 0
    call PRINTMESSAGE

    jmp $

DISKREADERROR2:
    push DISKERRORMESSAGE2
    push 1
    push 0
    call PRINTMESSAGE

    jmp $
    
; variable
ENTER16MESSAGE: db 'ENTER REAL MODE (16bit)', 0
DISKERRORMESSAGE1: db 'FAILED READ DISK (1)', 0
DISKERRORMESSAGE2: db 'FAILED READ DISK (2)', 0
COMPLETEREADDISKMESSAGE: db 'COMPLETE READ DISK (1024 SECTOR)', 0

SECTOR: db 0x02
HEAD: db 0x00
TRACK: db 0x00

times 510 - ($ - $$) db 0x00

db 0x55
db 0xAA
