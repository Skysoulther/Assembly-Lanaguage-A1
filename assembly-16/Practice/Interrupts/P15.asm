;15. Read from the standard input (keyboard) two directory names, dir1 and dir2. Create the new directory dir1\dir2.
assume cs:code,ds:data
data segment

    msg1 db 10,"Enter the name of the first directory: ",'$'
    msg2 db 10,"Enter the name of the second directory: ",'$'
    errormsg1 db 10,"Path not found!$"
    errormsg2 db 10,"Access denied or pathname already exists!$"

    maxDir1 db 15
    lenDir1 db ?
    Dir1 db 15 dup (?)

    maxDir2 db 15
    lenDir2 db ?
    Dir2 db 15 dup (?)

    root db '..',0

data ends
code segment

start:
    mov ax, data
    mov ds, ax

    ;print first message
    mov ah, 09h
    mov dx, offset msg1
    int 21h
    ;read first directory
    mov ah, 0ah
    mov dx, offset maxDir1
    int 21h
    ;convert to asciiz
    mov al, lenDir1
    mov ah, 0
    mov si, ax
    mov Dir1[si],0
    ;create directory1
    mov ah, 39h
    mov dx, offset Dir1
    int 21h
    jc error

    ;change directory
    mov ah,3bh
    mov dx, offset Dir1
    int 21h
    jc error

    ;print second message
    mov ah, 09h
    mov dx, offset msg2
    int 21h
    ;read second directory
    mov ah, 0ah
    mov dx, offset maxDir2
    int 21h
    ;convert to asciiz
    mov al, lenDir2
    mov ah, 0
    mov si, ax
    mov Dir2[si],0
    ;create directory2
    mov ah, 39h
    mov dx, offset Dir2
    int 21h
    jc error
 
    ;change directory
    mov ah,3bh
    mov dx, offset root
    int 21h
    jc error
    
    jmp final

error:
    cmp ax, 3
    je error1
    cmp ax, 5
    je error2

error1:
    mov ah, 09h
    mov dx, offset errormsg1
    int 21h
    jmp final

error2:
    mov ah, 09h
    mov dx, offset errormsg2
    int 21h

final:
    mov ax, 4c00h
    int 21h


code ends
end start