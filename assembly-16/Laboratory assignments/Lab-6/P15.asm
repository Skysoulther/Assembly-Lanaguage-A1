;15. Read from the standard input several numbers, in base 2. Print on the screen these numbers in base 10.

assume DS:data,CS:code

data segment

result db 8 dup ('$')
message db 10,"Enter the number(nothing to end the reading): $"
numMaxim db 16
numLength db ?
number db 16 dup (?)
dest dw 31 dup (?)
errorMsg db 10,"The number should be in base 2 $"

data ends

code segment

extrn base10:proc

start:
    mov ax,data
    mov ds, ax
    mov es, ax
    mov di, offset dest

    read:

        mov ah,09h
        mov dx, offset message
        int 21h

        mov ah, 0ah
        mov dx, offset numMaxim
        int 21h
    
    cmp numLength,0
    je tipar
        
    mov si, offset number
    mov cl, numLength
    xor ch, ch
    cld
    mov bx, 0
    jcxz final

    repeat:

        lodsb
        cmp al, '0'
        jb error
        cmp al, '1'
        ja error

        sub al, '0'
        rcr al, 1
        rcl bx, 1
        loop repeat
    
    mov ax, bx
    stosw
    jmp read

    tipar:
        mov si, offset dest
        cld
        bucla: 
            cmp si, di
            je final
            lodsw
            call base10
        jmp bucla

error:

    mov ah, 09h
    mov dx, offset errorMsg
    int 21h

final:

    mov ax, 4c00h
    int 21h

code ends
end start