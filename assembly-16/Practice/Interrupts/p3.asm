;3. Read a drive letter (e.g. 'C', 'D', 'Z'..) from the keyboard (let's call it X). 
; If the current drive is the drive letter read from the keyboard, set the default drive to X:.
; Otherwise make the current drive to be X:. Every error will be signalized to the user

assume cs:code,ds:data
data segment

    X db ?
    msgerror1 db 10,"Drive letter should be an upper letter (other symbols are invalid)!",'$'
    msgerror2 db 10,"Drive error!",'$'

data ends
code segment

start:
    mov ax,data
    mov ds,ax
    ;reads a letter from the keyboard
    mov ah, 01h
    int 21h

    ;checks if introduced key is a valid letterletter
    cmp al,'A'
    jb error1
    cmp al,'Z'
    ja error1
    ;we can put the letter in al
    sub al,'A'
    mov X,al
    ;Get current drive number
    mov ah,19h
    int 21h
    ;checks the drive letter
    cmp x,al
    je setDrive

    mov ah,0eh
    mov dl, X
    int 21h

    mov ah,19h
    int 21h
    jmp final
    

error1:
    ;print error message
    mov ah, 09h
    mov dx, offset msgerror1
    int 21h
    jmp final

setDrive:
    ;set the default drive to x
    mov ah,0eh
    mov dl, X
    int 21h
    jmp final

error2:
    ;print error message
    mov ah, 09h
    mov dx, offset msgerror2
    int 21h
    jmp final

final:
    mov ax,4c00h
    int 21h

code ends
end start