;6. Three character strings are given. 
;Compute and print on the screen the result of their concatenation.
assume cs:code,ds:data

data segment

    s1 db 'Ana ',0
    s2 db 'are ',0
    s3 db 'mere.',0
    finalS db 75 dup (?)
    public finalS

data ends
code segment
extrn Concat:far
start:
    mov ax, data
    mov ds, ax

    push offset s1
    push offset s2
    push offset s3

    call Concat

    mov ah,09h
    lea dx,finalS
    int 21h

    mov ah,02h
    mov dl,10
    int 21h

    mov ax, 4c00h
    int 21h

code ends
end start
