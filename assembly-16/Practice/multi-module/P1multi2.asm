assume cs:code,ds:data
data segment public
    public num16
    hexa db '0123456789ABCDEF'
    num16 db 4 dup (?),10,'$'

data ends
code segment public
public base16
base16:
    push ax
    push bx
    push cx
    push dx
    push si

    mov si, offset num16+4
    mov bx, offset hexa
    mov cx, 16

bucla:
    mov dx, 0
    div cx
    dec si
    push ax
    mov ax,dx
    xlat hexa
    mov byte ptr [si],al
    pop ax
    cmp ax, 0
    jne bucla
    ;PRINT NUMBER
    mov ah, 09h
    mov dx, si
    int 21h

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret




code ends
end