;4. Print the current date on the screen and also the current day of the week (using letters, not numbers).
assume cs:code,ds:data

data segment

days db "Sunday",4 dup ('$')
     db "Monday",4 dup ('$')
     db "Tuesday",3 dup ('$')
     db "Wednesday",'$'
     db "Thursday",2 dup ('$')
     db "Friday",4 dup ('$')
     db "Saturday",2 dup ('$')
date db 10 dup (?),32,'$'
ten db 10
ten2 dw 10

data ends
code segment
start:
    mov ax, data
    mov ds, ax
    mov es,ax
    mov di, offset date+9
    std
    mov ah,2ah
    int 21h

    mov ah,0
    push ax

    mov ax, cx
    push dx
    call convert10
    pop dx
    mov al, '/'
    stosb
    

    mov al,dh
    mov ah,0
    push dx
    call convert10
    pop dx
    mov al,'/'
    stosb

    mov al, dl
    mov ah,0
    call convert10

    mov ah,09h
    mov dx, offset date
    int 21h

    pop ax
    mul ten
    mov dx, offset days
    add dx, ax
    mov ah,09h
    int 21h
    jmp final


convert10:
    mov dx,0
    div ten2
    add dl,'0'
    mov bx,ax
    mov al,dl
    stosb
    mov ax,bx
    cmp bx,0
    jne convert10
    ret  

final:
    mov ax,4c00h
    int 21h
code ends
end start