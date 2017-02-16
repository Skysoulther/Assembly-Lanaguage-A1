assume CS:code,DS:data

data segment public
    tmp db 6 dup (?),13,10,'$'
data ends

code segment public
public base10

base10: 

    push bx
    push cx
    push dx

    mov bx, offset tmp+6
    mov cx, 10

    repeat2:
        mov dx, 0
        div cx
        dec bx
        add dl, '0'
        mov byte PTR [bx], dl
        cmp ax, 0
        jne repeat2
    
    dec bx
    mov byte PTR [bx], 10

    mov ah, 09h
    mov dx, bx
    int 21h

    pop dx
    pop cx
    pop bx

    ret

code ends
end