;1. A number a represented on 16 bits is given. Print on the screen a in base 16, 
;as well as the result of all circular permutations of the digits. 
assume cs:code, ds:data

data segment public

    a dw 01101111010111b

data ends
code segment public
extrn base16:proc
start:
    push data
    pop ds

    mov ax, a
    mov cl, 4
    mov bx, 4

bucla:
    dec bx
    call base16
    ror ax, cl
    cmp bx, 0
    jne bucla

final:
    mov ax, 4c00h
    int 21h

code ends
end start