;9. Read from the standard input a string of numbers, given in base 16.
assume cs:code,ds:data

data segment

     hexa db '0123456789ABCDEF'
     msg db 10,'Read as many numbers in base 16 you want(press only enter to stop):',10,'$'
     msg2 db 10,'String : $'
     errormsg db 10,'That is an error mother fucker!$'
     numMax db 5
     numLen db ?
     number db 5 dup (?)
     result dw 10 dup (0)
     sixteen dw 16
     locali dw 0
     public number
     public sixteen
     public hexa
     public locali

data ends

code segment
extrn base16:far
start:
    mov ax, data
    mov ds, ax
    mov bp,0

    mov ah, 09h
    mov dx, offset msg
    int 21h

read:
    mov ah, 0ah
    mov dx, offset numMax
    int 21h

    cmp numLen,0
    je final

    mov ah,0
    mov al, numLen
    mov si, ax
    mov number[si],0

    mov ah, 02h
    mov dl, 10
    int 21h

    call base16

    cmp locali,-1
    je error

    push locali

    jmp read

error:
    mov ah, 09h
    mov dx, offset errormsg
    int 21h
    jmp ending

final:
    mov di,0
    again:
        cmp bp,sp
        je ending
        pop result[di]
        add di,2
        jmp again

ending:
    mov ax, 4c00h
    int 21h

code ends
end start