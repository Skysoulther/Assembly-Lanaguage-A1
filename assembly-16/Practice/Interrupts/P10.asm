;10. Print on the screen the attributes of a file whose name is given at the keyboard (Useful DOS commands: attrib).
assume cs:code,ds:data
data segment

    errormsg db 10,'ERROR! This is the end! AAAAAAHhh!','$'
    msg db 10,'Enter the message file: ','$'
    maxFile db 15
    lenFile db ?
    filename db 15 dup (?)
    attributes db 10,'Normal',4 dup ('$')
               db 10,'Read-only','$'
               db 10,'Hidden',4 dup ('$')
               db 10,'System','$'
    archive db 10,'Archive','$'
    eleven db 11

data ends
code segment
start:
    mov ax, data
    mov ds,ax

    ;print the message
    mov ah, 09h
    mov dx, offset msg
    int 21h
    ;read the filename
    mov ah, 0ah
    mov dx, offset maxFile
    int 21h
    ;convert toa asciiz
    mov al, lenFile
    mov ah, 0
    mov si, ax
    mov filename[si],0
    ;get attributes
    mov ax, 4300h
    mov dx, offset filename
    int 21h
    jc error
    mov ah,09h
    lea dx, attributes
    int 21h
    mov bl,0
    again:
        inc bl
        cmp bl,4
        je archive2
        shr cx,1
        jc print
        jmp again

print:
    mov al,bl
    mul eleven
    mov dx, offset attributes
    add dx,ax
    mov ah,09h
    int 21h
    jmp again

archive2:
    cmp cl,4
    je printArchive
    jmp final

printArchive:
    mov ah, 09h
    mov dx, offset archive
    int 21h
    jmp final

error:
    ;print error msg
    mov ah, 09h
    lea dx, errormsg
    int 21h
    jmp final

final:
    mov ax, 4c00h
    int 21h

code ends
end start
