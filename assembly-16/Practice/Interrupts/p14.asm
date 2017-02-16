;14. Read a word and the name of a file from the keyboard.
; Print a suitable message on the screen if the word exists or does not exist in the given file.

assume cs:code, ds:data
data segment

    msg1 db 10, "Enter the word (less than 12 characters): $"
    msg2 db 10, "Enter the name of the file: $"

    maxWord db 12
    lenWord db ?
    theWord db 12 dup (?)

    maxFile db 15
    lenFile db ?
    file db 15 dup (?)
    handle dw ?
    buffer db 500 dup (?)

    errormsg1 db 10, "Houston, we have a problem with the fil or handle!$"
    success db 10,"Word exists in the given file!$"
    fail db 10,"Word doesn't exist in the given file!$"

data ends
code segment

start:
    mov ax, data
    mov ds, ax
    mov es, ax

    ;print msg1
    mov ah, 09h
    lea dx, msg1
    int 21h
    ;read the word
    mov ah, 0ah
    lea dx, maxWord
    int 21h
    ;add final
    mov al, lenWord
    mov ah, 0
    mov si,ax
    mov theWord[si],'$'

    ;print msg2
    mov ah, 09h
    lea dx, msg2
    int 21h
    ;read the name of the file
    mov ah, 0ah
    lea dx, maxFile
    int 21h
    ;convert to asciiz
    mov al, lenFile
    mov ah, 0
    mov si,ax
    mov file[si],0

    ;open file
    mov ah,3dh
    mov al, 0
    mov dx, offset file
    int 21h
    jc error
    mov handle,ax

    ;read the file
    mov bx, handle
    mov dx, offset buffer
    mov cx, 100
    mov si, 0
    sub si, dx

read:
    mov ah, 3fh
    int 21h
    add dx, ax
    cmp ax, cx
    je read
    add si,dx
    ;search the word in the buffer
    mov cx, si
    mov bl, lenWord
    mov si, offset buffer
    cld

search:
    mov di, offset theWord
    lodsb
    scasb
    je possibleword
    loop search
    jmp notFound

first:
    inc si
    jmp again

error:
    ;print error
    mov ah, 09h
    mov dx, offset errormsg1
    int 21h
    jmp final

possibleword:
    mov bh, 0
    sub si, 2
    cmp si, offset buffer
    jb first
    lodsb
    cmp al,32
    je again
    cmp al,44
    je again
    inc si
    jmp search

    again:
        inc si
        inc bh
        lodsb
        dec si
        scasb
        je again

    cmp al, 32
    je part2
    cmp al, 46
    je part2
    cmp al, 10
    je part2
    jmp search

part2:
    cmp bh, bl
    je found
    jne search

notFound:
    mov ah, 09h
    lea dx, fail
    int 21h
    jmp closeFile

found:
    mov ah, 09h
    lea dx, success
    int 21h

closeFile:
    mov ah,3eh
    mov bx, handle
    int 21h
    jc error

final:
    mov ax, 4c00h
    int 21h

code ends
end start