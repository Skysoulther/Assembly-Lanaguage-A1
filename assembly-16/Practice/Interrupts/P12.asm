;12. Read from standard input (keyboard) two file names. 
;Copy the content of the first file in the second file. All possible errors are shown to the user.
assume cs:code,ds:data
data segment

    msg1 db 10,"Enter the name of the first file: $"
    msg2 db 10,"Enter the name of the second file: $"

    errormsgs db 10,"Function number invalid.$"
              db 10,"File not found.$",9 dup ('$')
              db 10,"Path not found.$",9 dup ('$')
              db 10,"No handle available.$", 4 dup ('$')
              db 10,"Access denied.$",10 dup ('$')
              db 10,"Invalid handle.$",9 dup ('$')
    errormsg2 db 10,"Open mode invalid.$"
    factor db 26

    maxFile1 db 15
    lenFile1 db ?
    file1 db 15 dup (?)
    handle1 dw ?

    maxFile2 db 15
    lenFile2 db ?
    file2 db 15 dup (?)
    handle2 dw ?

    buffer db 10,200 dup (?)

data ends
code segment

start:
    mov ax, data
    mov ds, ax
    
    ;print message1
    mov ah,09h
    mov dx, offset msg1
    int 21h
    ;input first file
    mov ah, 0ah
    mov dx, offset maxFile1
    int 21h
    ;convert to asciiz
    mov al, lenFile1
    mov ah, 0
    mov si, ax
    mov file1[si],0

    ;print message2
    mov ah,09h
    mov dx, offset msg2
    int 21h
    ;input second file
    mov ah, 0ah
    mov dx, offset maxFile2
    int 21h
    ;convert to asciiz
    mov al, lenFile2
    mov ah, 0
    mov si, ax
    mov file2[si],0

    ;open first file
    mov ah, 3dh
    mov al,0
    mov dx, offset file1
    int 21h
    jc error
    mov handle1, ax
    ;open second file
    mov ah, 3dh
    mov al,1
    mov dx, offset file2
    int 21h
    jc error
    mov handle2, ax

    ;read first file in the buffer
    mov bx, handle1
    mov cx, 100
    mov dx, offset buffer+1
    mov si, 0
    sub si, dx
    read:
        mov ah, 3fh
        int 21h
        add dx, ax
        cmp ax, cx
        je read
    ;finish the reading with a sign
    add si, dx
    mov buffer[si],'$'
    ;set cursor in second file
    mov ax, 4201h
    mov bx, handle2
    mov cx, 0
    mov dx, 1
    int 21h
    jc error
    jmp nextstage

error:
    cmp ax, 6
    jbe error1
    cmp ax,12
    je error2

nextstage:
    ;write the content
    mov ah, 40h
    dec si
    mov cx, si
    mov dx, offset buffer
    int 21h
    jc error
    
    ;close second file
    mov ah, 3eh
    int 21h
    jc error

    ;close first file
    mov ah, 3eh
    mov bx, handle1
    int 21h
    jc error
    jmp final

error1:
    dec ax
    mul factor
    mov dx, offset errormsgs
    add dx, ax
    mov ah, 09h
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