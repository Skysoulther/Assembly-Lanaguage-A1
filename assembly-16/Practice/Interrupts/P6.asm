;6. Implement an authentication program. The program has the string 'password' defined in its data segment. 
;The program repeatedly asks the user to input the password at the keyboard and verifies if the password given by the user 
;is identical with the string 'password' from the data segment and prints a suitable message on the screen. 
;The program exits when the user guessed the password.

assume cs:code,ds:data
data segment

    msg db 10,'Please enter the password: $'
    well db 10,'Well Done!','$'
    password db '123456789ddl'
    len EQU $-password
    maxGuess db 16
    lenGuess db ?
    guess db 16 dup (?) 

data ends
code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax
    
validation:
    ;set the addresses of the strings
    mov si, offset guess
    lea di, password
    cld
    ;print message
    mov ah,09h
    mov dx, offset msg
    int 21h
    ;read guess
    mov ah, 0ah
    mov dx, offset maxGuess
    int 21h
    ;checks the length
    mov cx, len
    cmp lenGuess,len
    je validation2
    jmp validation

validation2:
    ;validate letter by letter
    repeat:
        cmpsb
        jne validation
        loop repeat
    ;print message for guessing
    mov ah, 09h
    mov dx, offset well
    int 21h

    mov ax, 4c00h
    int 21h

code ends
end start