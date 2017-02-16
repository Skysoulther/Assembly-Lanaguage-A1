;11. Set the attributes of a file whose name will be read from the keyboard. 
;The new attributes will be determined through a dialog with the user (Useful DOS commands: attrib).
assume cs:code,ds:data
data segment

    errormsg1 db 10,'Houston, we have a problem!','$'
    errormsg2 db 10,'Access denied','$'
    invalid db 10,"Plese type y/n",'$'
    msg db 10,"Enter the name of the file: ",'$'
    read db 10,"Do you want Read-Only attribute (y/n): ",'$'
    hidden db 10,"Do you want Hidden attribute (y/n): ",'$'
    system db 10,"Do you want System attribute (y/n): ",'$'
    archive db 10,"Do you want Archive attribute (y/n): ",'$'
    maxFile db 15
    lenFile db ?
    filename db 15 dup (?)
    well db 10,'Well done!','$'

data ends
code segment
start:
    mov ax, data
    mov ds, ax

    ;print message
    mov ah, 09h
    mov dx, offset msg
    int 21h
    ;read the name of the file
    mov ah, 0ah
    mov dx, offset maxFile
    int 21h
    ;convert the filename to asciiz
    mov al, lenFile
    mov ah,0
    mov si, ax
    mov filename[si],0
    mov cx,0

readq:
    ;ask read-only question
    mov ah,09h
    mov dx, offset read
    int 21h
    ;read answer
    mov ah,01h
    int 21h
    cmp al,'y'
    je addRead
    cmp al, 'n'
    je hiddenq
    mov ah,09h
    mov dx, offset invalid
    int 21h
    jmp readq

addRead:
    add cx, 01h

hiddenq:
    ;ask hidden question
    mov ah,09h
    mov dx, offset hidden
    int 21h
    ;read answer
    mov ah,01h
    int 21h
    cmp al,'y'
    je addHidden
    cmp al, 'n'
    je systemq
    mov ah,09h
    mov dx, offset invalid
    int 21h
    jmp hiddenq

addHidden:
    add cx,02h

systemq:
    ;ask hidden question
    mov ah,09h
    mov dx, offset system
    int 21h
    ;read answer
    mov ah,01h
    int 21h
    cmp al,'y'
    je addSystem
    cmp al, 'n'
    je archiveq
    mov ah,09h
    mov dx, offset invalid
    int 21h
    jmp systemq

addSystem:
    add cx, 04h

archiveq:
    ;ask hidden question
    mov ah,09h
    mov dx, offset archive
    int 21h
    ;read answer
    mov ah,01h
    int 21h
    cmp al,'y'
    je addArchive
    cmp al, 'n'
    je setAttr
    mov ah,09h
    mov dx, offset invalid
    int 21h
    jmp archiveq

addArchive:
    add cx,20h

setAttr:
    ;set the attributes
    mov ax, 4301h
    mov dx, offset filename
    int 21h
    jc error
    mov ah,09h
    mov dx, offset well
    int 21h
    jmp final

error:
    cmp ax,5
    je error2
    jmp error1

error1:
    ;print error message
    mov ah, 09h
    mov dx, offset errormsg1
    int 21h
    jmp final

error2:
    ;print error message
    mov ah, 09h
    mov dx, offset errormsg2
    int 21h

final:
    mov ax,4c00h
    int 21h


code ends
end start