;8. Print on the screen, for each number between 32 and 126,
;the value of the number (in base 10) and the character whose ASCII code the number is.
assume cs:code,ds:data

data segment

    separate db ' - ','$'
    number db 3 dup (?),'$'
    row db 6
    public number
    public separate
    public row

data ends

code segment
extrn base10:far
extrn print:far
start:
    mov ax, data
    mov ds, ax

    mov ax,32

bucla:

    mov bx,ax
    call base10

    inc di
    mov dx, di
    mov ax, bx

    call print

    mov ax, bx
    inc ax
    cmp ax, 127
    jne bucla

final:
    mov ax, 4c00h
    int 21h

code ends
end start