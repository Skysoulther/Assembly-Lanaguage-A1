;8. Write a program which reads the name of a file and two characters from the keyboard. 
;The program should replace all occurrences of the first character in that file with the second character given by the user.
assume cs:code,ds:data
data segment

    errormsg1 db 10,'We have an error for opening or reading!','$'
    errormsg2 db 10,'We have an error for closing or writing!','$'
    msg1 db 10,'Enter the name of the file: $'
    msg2 db 10,'Enter the first character: $'
    msg3 db 10,'Enter the second character: $'
    maxFile db 15
    lenFile db ?
    filename db 15 dup (?)
    char1 db ?
    char2 db ?
    handle dw ?
    buffer db 400 dup (?),'$'

data ends
code segment
start:
    mov ax, data
    mov ds, ax

    ;print first message
    mov ah,09h
    lea dx, msg1
    int 21h
    ;read the name of the file
    mov ah,0ah
    lea dx,maxFile
    int 21h
    ;convert name to asciiz
    mov al,lenFile
    mov ah,0
    mov si, ax
    mov filename[si],0
    ;print second message
    mov ah,09h
    mov dx, offset msg2
    int 21h
    ;read char1 
    mov ah,01h
    int 21h
    mov char1,al
    ;print third message
    mov ah, 09h
    mov dx, offset msg3
    int 21h
    ;read char2
    mov ah,01h
    int 21h
    mov char2,al
    ;open the file
    mov ah,3dh
    mov al,2
    mov dx, offset filename
    int 21h
    jc error1
    mov handle,ax
    ;read the content of the filename
    mov bx, handle
    mov cx, 200
    mov dx, offset buffer
    mov si, 0
read:
    mov ah, 3fh
    int 21h
    jc error1
    add si, ax
    add dx, ax
    cmp ax, cx
    je read
    ;add final $
    mov buffer[si],'$'
    jmp step2

error1:
    ;print error
    mov ah,09h
    lea dx, errormsg1
    int 21h
    jmp final

step2:
    ;change the values
    mov si, 0
    mov ah, char2
    mov al, char1
    again:
        cmp buffer[si],'$'
        je step3
        cmp buffer[si],al
        je exchange
        inc si
        jmp again

exchange:
    ;changes the value1 with value2
    mov buffer[si],ah
    inc si
    jmp again

step3:
    ;set cursor
    mov ax, 4200h
    mov bx,handle
    mov cx, 0
    mov dx, 0
    int 21h
    jc error2
    ;writing the content of the buffer
    dec si
    mov cx, si
    mov ah, 40h
    mov dx, offset buffer
    int 21h
    jc error2
    ;close the file
    mov ah, 3eh
    int 21h
    jc error2
    jmp final 

error2:
    mov ah,09h
    lea dx, errormsg2
    int 21h
    jmp final

final:
    mov ax, 4c00h
    int 21h

code ends
end start