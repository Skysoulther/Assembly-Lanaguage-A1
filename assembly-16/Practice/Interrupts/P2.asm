;2. Read a character from the keyboard without echo. If the character is a digit, print it on the screen. 
;If the character is '$', end the current program.
;In any other situation, the character is added to a buffer (i.e. a string) which will be printed on the screen when the program exits.

assume cs:code,ds:data
data segment

    buffer db 10,100 dup ('$')

data ends
code segment

start:
    mov ax, data
    mov ds, ax
    ;prepare es:di
    mov es, ax
    mov di, offset buffer+1
    cld
    ;start pressing keys
    repeat:
        mov ah, 08h
        int 21h
        cmp al,'$'
        je ending
        cmp al,'0'
        jb nondigit
        cmp al,'9'
        jbe digit
        jmp nondigit

nondigit:
    ;add the chracter to the buffer
    stosb
    jmp repeat

digit:
    ;print digit on the screen and repeat
    mov ah, 02h
    mov dl, al
    int 21h
    jmp repeat

ending:
    ;print buffer on the screen
    mov ah,09h
    lea dx, buffer
    int 21h

    mov ax, 4c00h
    int 21h

code ends
end start