;2. Read from the standard input a string of numbers, given in base 10.
assume cs:code, ds:data
data segment public

    errormsg db 10,"Error: that is not a number!$"
    msg db 10,'Type a number: $'
    msg2 db 10,'The string is: $'
    maxNum db 15
    lenNum db ?
    Number db 15 dup (?)
    buffer db 200 dup (?)
    len dw 0
    public Number
    public buffer
    public len

data ends
code segment
extrn checkNumber:far
extrn save:far
start:
    mov ax, data
    mov ds, ax

bucla:
    ;print message
    mov ah, 09h
    mov dx,offset msg
    int 21h
    ;read number
    mov ah, 0ah
    mov dx, offset maxNum
    int 21h
    ;asciiz
    mov al, lenNum
    mov ah, 0
    mov si,ax
    mov Number[si],0

    cmp lenNum, 0
    je print
    mov ax, offset Number
    call checkNumber

    cmp ax, -1
    je saver
    cmp ax, 0
    je error

saver: 
    call save
    mov len, di
    jmp bucla

error:
    mov ah, 09h
    mov dx, offset errormsg
    int 21h

print:
    mov di, len
    mov buffer[di],'$'

    mov ah, 09h
    mov dx,offset msg2
    int 21h

    mov ah, 09h
    mov dx, offset buffer
    int 21h

final:
    mov ax, 4c00h
    int 21h

code ends
end start