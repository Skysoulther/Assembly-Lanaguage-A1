;7. Write a program which reads the name of a file from the keyboard and 
;then it prints on the screen the even lines from this file.
assume cs:code,ds:data

data segment

    msgerror db 10,'It seems that we have an error!','$'
    msg db 10,"Enter the name of the file (don't forget the extension): ",'$'
    two db 2
    maxFile db 15
    lenFile db ?
    filename db 15 dup (?)
    buffer db 400 dup (?),'$'
    prints db 200 dup ('$')

data ends
code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax

    ;print message
    mov ah,09h
    lea dx, msg
    int 21h
    ;read filename
    mov ah,0ah
    lea dx, maxFile
    int 21h
    ;convert filename into asciiz
    mov al,lenFile
    mov ah, 0
    mov si, ax
    mov filename[si],0
    ;open the file
    mov al,0
    mov ah,3dh
    mov dx, offset filename
    int 21h
    jc error
    ;read from file
    mov bx, ax
    mov cx,100
    mov dx, offset buffer
    mov si,0
    sub si,dx
    jmp read

error:
    mov ah,09h
    lea dx, msgerror
    int 21h
    jmp final

read:
    mov ah, 3fh
    int 21h
    add dx, ax
    cmp ax, cx
    je read
    ;prepare buffer for testing
    add si, dx
    mov buffer[si],'$'
    mov bl, 1
    mov si, offset buffer
    cld
    ;checks the chars from the buffer
testul:
    lodsb
    cmp al,'$'
    je print
    cmp al, 10
    je newline
    jmp testul

newline:
    inc bl
    mov bh, 0
    mov ax, bx
    div two
    cmp ah,0
    je prepare
    jmp testul

print:
    ;prints a line
    mov bh, al
    mov al,'$'
    stosb
    mov ah, 09h
    lea dx, prints
    int 21h
    cmp bh, 10
    je newline
    cmp bh,'$'
    jmp final

prepare:
    mov di,offset prints
    cld
    mov al,10
    stosb
    again:
        lodsb
        cmp al, 10
        je print
        cmp al,'$'
        je print
        stosb
        jmp again

final:
    mov ax, 4c00h
    int 21h

code ends
end start