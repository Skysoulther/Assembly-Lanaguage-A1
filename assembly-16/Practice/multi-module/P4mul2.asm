assume cs:code
extrn value:byte 
extrn hexa:byte
extrn sixteen:word
code segment

public Base16
Base16 proc
    push bp
    mov bp,sp

    push bx
    push cx
    push dx

    mov ax, [bp+2*3]
    mov bx, offset hexa
    mov di, seg value
    mov es, di
    mov di, offset value
    add di, 3
    std

bucla:
    mov dx, 0
    div sixteen
    push ax
    mov ax, dx
    xlat hexa
    stosb
    pop ax
    cmp ax, 0
    je final
    jmp bucla

final:

    pop dx
    pop cx
    pop bx

    pop bp
    ret 4

Base16 endp

code ends
end