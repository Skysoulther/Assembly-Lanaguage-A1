;16. Read from the standard input (keyboard) the name of a file. 
;Verify whether the size of the file is a multiple of 13 and if it is not, 
;add zero bytes to the file so that the size of the file becomes a multiple of 13.
assume cs:code, ds:data
data segment

    msg db 10,"Enter the name of the file: $"
    
    maxFile db 16
    lenFile db ?
    file db 16 dup (?)
    handle dw ?
    thirteen dw 13
    buffer db 12 dup (0)

    errormsg1 db "Can't open the file!$"
    errormsg2 db "Can't move the pointer!$"
    errormsg3 db "Can't write in the file!$"
    errormsg4 db "Can't close the file!$"

data ends
code segment

start:
    mov ax, data
    mov ds, ax

    ;print message
    mov ah, 09h
    lea dx, msg
    int 21h
    ;read the name of the file
    mov ah, 0ah
    lea dx, maxFile
    int 21h
    ;convert to asciiz
    mov al, lenFile
    mov ah, 0
    mov si, ax
    mov file[si],0
    ;open file
    mov ah, 3dh
    mov al, 02
    mov dx, offset file
    int 21h
    jc error1
    mov handle, ax

    ;move pointer
    mov ax, 4202h
    mov bx, handle
    mov cx, 0
    mov dx, 0
    int 21h
    jc error2
    ;verify if size is a multiple of 13
    div thirteen
    cmp dx, 0
    je final

    ;write 0s
    mov ah, 40h
    mov bx, handle
    mov cx, thirteen
    sub cx, dx
    mov dx, offset buffer
    int 21h
    jc error3
    
    ;close the file
    mov ah,3eh
    int 21h
    jc error4
    jmp final

error1:
    ;print error message one
    mov ah, 09h
    mov dx, offset errormsg1
    int 21h
    jmp final

error2:
    ;print error message two
    mov ah, 09h
    mov dx, offset errormsg2
    int 21h
    jmp final

error3:
    ;print error message three
    mov ah, 09h
    mov dx, offset errormsg3
    int 21h
    jmp final

error4:
    ;print error message four
    mov ah, 09h
    mov dx, offset errormsg4
    int 21h

final:
    mov ax, 4c00h
    int 21h

code ends
end start