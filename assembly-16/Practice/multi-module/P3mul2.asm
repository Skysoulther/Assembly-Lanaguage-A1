assume cs:code

extrn finalS

code segment
public Concat
Concat proc

    push bp
    mov bp, sp

    mov di, seg finalS
    mov es, di
    mov di, offset finalS

    mov si, [bp+2*4]

    bucla1:
        lodsb
        test al,al
        jz cont
        stosb
        jmp bucla1

cont:
    mov si,[bp+2*3]

    bucla2:
        lodsb
        test al,al
        jz endConcat
        stosb
        jmp bucla2
    
endConcat:
    mov al, '$'
    stosb

    pop bp
    ret 6

Concat endp
public Print
Print proc

    push bp
    mov bp,sp

    mov ah, 09h
    mov dx, [bp+2*3]
    int 21h

    pop bp
    ret 4

Print endp

code ends
end