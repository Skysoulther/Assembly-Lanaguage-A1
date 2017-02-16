;5. Print the current system time on the screen using the hh:mm format and also specify whether it is 'AM' or 'PM'.
assume cs:code,ds:data
data segment

time db 7 dup(?),10,'$'
ten db 10
twelve db 12
clock db '120102030405060708091011'

data ends
code segment

start:
    mov ax,data
    mov ds,ax
    mov es,ax
    mov di, offset time+6
    std
    ;Get the time informations
    mov ah,2ch
    int 21h

    ;establish am or pm
    mov al, 'M'
    stosb
    cmp ch,12
    jb am
    jmp pm

am:
    mov al, 'A'
    stosb
    jmp continue1

pm:
    mov al, 'P'
    stosb

continue1:
    ;add the minutes
    cmp cl,10
    jb sm
    jmp lg

sm:
    mov al,cl
    add al,'0'
    stosb
    mov al,'0'
    stosb
    jmp continue2

lg:
    mov al,cl
    mov ah,0
    div ten
    mov bl, al
    add bl,'0'
    mov al, ah
    add al, '0'
    stosb
    mov al,bl
    stosb

continue2:
    ;add the hour
    mov al,':'
    stosb
    mov cl,ch
    mov ch,0
    mov ax, cx
    div twelve
    mov al, ah
    add al, al
    mov ah, al
    inc al
    lea bx, clock
    xlat
    stosb
    mov al,ah
    xlat
    stosb

    ;print time
    mov ah, 09h
    lea dx, time
    int 21h

    mov ax, 4c00h
    int 21h

code ends
end start