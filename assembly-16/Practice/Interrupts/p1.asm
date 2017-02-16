;1. A string of bytes is given in the data segment. 
;Print on the standard output (screen) the elements of this string in base 2.

assume CS:code,DS:data
data segment

    mainStr db 'FUCKFUCK'
    len EQU $-mainStr
    element db 10,8 dup (?),'$'
    opt db 8

data ends
code segment

start:
    push data
    pop DS

    ;prepare strings for loading in ax
    mov cx, len
    mov si, offset mainStr
    cld
    jcxz final
    repeat:
        ;read the main string byte by byte
        lodsb
        mov di, 1
        mov opt, 8
        ;take the bits from the bytes and put them in the string element
        again:
            mov ah,0 
            shl ax,1
            add ah,'0'
            mov element[di], ah
            inc di
            dec opt
            cmp opt,0
            jne again
        ;print the element
        mov ah,09h
        mov dx,offset element
        int 21h
        ;reapeat the process for the rest of bytes
        loop repeat

final:
    mov ax,4c00h
    int 21h

code ends
end start
