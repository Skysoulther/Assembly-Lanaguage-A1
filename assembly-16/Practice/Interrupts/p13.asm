;13. Read from standard input (keyboard) the name of a file and the name of a directory. 
;Print a suitable message if that file exists or does not exist in the specified directory.
assume cs:code,ds:data
data segment

    msg1 db 10,"Enter the name of the file: $"
    msg2 db 10,"Enter the name of the directory: $"

    maxFile db 15
    lenFile db ?
    file db 15 dup (?)
    handle dw ?

    maxDir db 15
    lenDir db ?
    dir db 15 dup (?)
    root db "..",0

    errormsg1 db 10,"Directory doesn't exist!$"
    errormsg2 db 10,"File doesn't exist!$"
    success db 10,"The file exists in the specified directory!$"

data ends
code segment

inceput:
    mov ax, data
    mov ds, ax

    ;print the message1
    mov ah, 09h
    mov dx, offset msg1
    int 21h
    ;read the name of the file
    mov ah, 0ah
    mov dx, offset maxFile
    int 21h
    ;converft to asciiz
    mov al, lenFile
    mov ah, 0
    mov si, ax
    mov file[si],0

    ;print the message2
    mov ah, 09h
    mov dx, offset msg2
    int 21h
    ;read the name of the directory
    mov ah, 0ah
    mov dx, offset maxDir
    int 21h
    ;converft to asciiz
    mov al, lenDir
    mov ah, 0
    mov si, ax
    mov dir[si],0

    ;change directory
    mov ah,3bh
    mov dx, offset dir
    int 21h
    jc error1

    ;open file
    mov ax, 3d00h
    mov dx, offset file
    int 21h
    jc error2
    mov handle,ax

    ;print success
    mov ah, 09h
    mov dx, offset success
    int 21h

    ;close file
    mov ah, 3eh
    mov bx, handle
    int 21h
    jc error2

    jmp changeBack

changeBack:
    ;change back
    mov ah, 3bh
    mov dx, offset root
    int 21h
    jmp final

error1:
    ;directory error
    mov ah, 09h
    mov dx, offset errormsg1
    int 21h
    jmp final

error2:
    ;file error
    cmp ax, 2
    je printError
    cmp ax, 3
    je printError
    jmp changeBack

printError:
    mov ah, 09h
    mov dx, offset errormsg2
    int 21h
    jmp changeBack

final:
    mov ax, 4c00h
    int 21h

code ends
end inceput