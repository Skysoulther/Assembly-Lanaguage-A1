assume cs:code
extrn number:byte
extrn separate:byte
extrn row:byte
code segment
public base10
base10 proc

    mov di, seg number
    mov es, di
    mov di, offset number
    add di, 2
    mov cx, 10
    std

bucla:
    mov dx, 0
    div cx
    xchg ax, dx
    add al,'0'
    stosb
    xchg ax, dx
    cmp ax, 0
    jne bucla

final:
    ret

base10 endp

public print
print proc

    mov ah, 09h
    int 21h

    mov ah,09h
    lea dx,separate
    int 21h

    mov dl,al
    mov ah, 02h
    int 21h
    dec row

    cmp row,0
    je pressEnter

    mov dl,','
    int 21h

    mov dl,32
    int 21h

    jmp ending
    

pressEnter:
    mov row,6
    mov dl,10
    int 21h

ending:

    ret

print endp

code ends
end