;15. Read from the standard input (keyboard) two directory names, dir1 and dir2. Create the new directory dir1\dir2.

assume DS:data,CS:code

data segment

msg1 db "Enter the name of the first directory: $"
maxDir1 db 12
lenDir1 db ?
Dir1 db 12 dup (?)
msg2 db "Enter the name of the second directory: $"
maxDir2 db 12
lenDir2 db ?
Dir2 db 12 dup (?)
fullName db 24 dup (?)
PathError db "Path not found!$"
AccessError db "Access denied!$"

data ends

code segment
start:

    push data
    pop DS
    ; Print the first message
    mov ah, 09h
    mov dx, offset msg1
    int 21h
    ; Read the first directory's name
    mov ah, 0ah
    mov dx, offset maxDir1
    int 21h
    ; Prepare the strings Dir1 and fullName to be copied
    mov cl, lenDir1
    xor ch, ch
    mov ax, seg fullName
    mov es, ax
    mov si, offset Dir1
    mov di, offset fullName
    cld
    jcxz sfarsit
    ; copy the bytes from Dir1 to fullName
    repeat1:
        lodsb
        stosb
        loop repeat1
    ; add the character '\' at the end of actual fullName
    mov al,'-'
    stosb
    ; Print the second message
    mov ah, 09h
    mov dx, offset msg2
    int 21h
    ; Read the second directory's name
    mov ah, 0ah
    mov dx, offset maxDir2
    int 21h
    ; Prepare the strings Dir2 for copying bytes
    mov cl, lenDir2
    xor ch, ch
    mov si, offset Dir2
    cld
    jcxz sfarsit
    ; copy the bytes from Dir2 to fullName
    repeat2:
        lodsb
        stosb
        loop repeat2
    ; Put a zero at the end of fullName (AsciiZ)
    mov al, 0
    stosb
    ;Create directory with the name fullName
    mov ah, 39h
    mov dx, offset fullName
    int 21h
    ; jump to error if error occurs (CF=1)
    jc error
    ; jump to sfarist if no error occurs
    jmp sfarsit
; checks what kind of error it got
error:
    cmp ax, 3
    je pError  
    cmp ax, 5
    je aError 
; prints message for path error
pError:
    mov ah, 09h
    mov dx, offset PathError
    int 21h
    jmp sfarsit
; prints message for access error
aError:
    mov ah, 09h
    mov dx, offset AccessError
    int 21h
; the end of the program
sfarsit:
    mov ax, 4C00h
    int 21h

code ends
end start



    
