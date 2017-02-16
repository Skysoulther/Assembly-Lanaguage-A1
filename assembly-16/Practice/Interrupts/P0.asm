; Read from the standard input (keyboard) the name of a file. Print the contents of this file on the screen.

assume CS:code,DS:data
data segment

    msg1 db 10,"Enter the name of the file: $"
    maxFile db 12
    lFile db ?
    fileName db 12 dup (?)
    buffer db 900 dup (?), '$'
    errormsg1 db 10,'File not found','$'
    errormsg2 db 10,'Path not found','$'
    errormsg3 db 10,'Access denied','$'
    errormsg4 db 10,'Invalid handle','$'

data ends
code segment

start:
    push data
    pop ds

    ;Write the message on the screen
    mov ah, 09h
    mov dx, offset msg1 ;lea dx, msg1
    int 21h

    ;Read the name of the file
    mov ah, 0ah
    mov dx, offset maxFile
    int 21h

    ;Make the string an ASCIIZ one
    mov al, lFile
    mov ah, 0
    mov si, ax
    mov fileName[si],0

    ;open a file
    mov ah,3dh
    mov al,0
    mov dx,offset fileName
    int 21h
    jc OpenError

    ;Read from the file
    mov bx, ax
    mov cx, 100
    mov dx, offset buffer
    mov si, 0
    sub si, dx

    goOn:
        mov ah,3fh
        int 21h
        jc ReadError
        ;Add characters in the buffer
        add dx, ax
        cmp ax, cx
        je goOn
    
    ;Print the buffer on the screen
    add si,dx
    mov buffer[si],'$'
    mov ah,09h
    mov dx, offset buffer
    int 21h

    ;close the handle
    mov ah,3eh
    int 21h
    jc CloseError

    ;end the program
    jmp final

OpenError:
    cmp ax, 2
    je error1
    cmp ax, 3
    je error2
    jmp final

ReadError:
    cmp ax, 5
    je error3
    cmp ax,6
    je error4
    jmp final

CloseError:
    cmp ax,6
    je error4

error1:
    mov ah, 09h
    mov dx, offset errormsg1
    int 21h
    jmp final

error2:
    mov ah, 09h
    mov dx, offset errormsg2
    int 21h
    jmp final

error3:
    mov ah, 09h
    mov dx, offset errormsg3
    int 21h
    jmp final

error4:
    mov ah, 09h
    mov dx, offset errormsg4
    int 21h
    jmp final

final:
    mov ax, 4c00h
    int 21h

code ends
end start

