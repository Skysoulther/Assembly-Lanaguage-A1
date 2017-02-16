assume cs:code
extrn finalS:byte

code segment
public Concat

Concat proc

    push bp
    mov bp,sp

    mov di, seg finalS
    mov es, di
    mov di, offset finalS
    cld

    add bp,12
    mov cx,3
    jcxz final

bucla:
    sub bp,2
    mov si,[bp]

repeat:
    lodsb
    cmp al,0
    je continue
    stosb
    jmp repeat

continue:

    loop bucla

final:
    mov al,'$'
    stosb
    
    pop bp
    ret 8

Concat endp

code ends
end