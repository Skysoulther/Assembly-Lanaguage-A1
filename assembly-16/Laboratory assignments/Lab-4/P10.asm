;10. A string of bytes is given. Obtain the mirror image of the binary representation of this string of bytes. 
;Ex: The byte string is given: s db 01011100b, 10001001b, 11100101b 
;The result is the string: d db 10100111b, 10010001b, 00111010b.
Assume CS:code,DS:data

data segment

s db 01011100b, 10001001b, 11100101b
len EQU $-s
dest db len dup (?)

data ends

code segment
start:

push data
pop DS
mov cx, len ;put in cx the number of elements of the string
mov si, OFFSET s[len-1] ;put in si the offset of s
mov di, OFFSET dest ;put in di the offset of dest
mov ax, SEG dest
mov es, ax ; put in es the segment address of 
jcxz sfarsit
Repeta:
    std ;set a descending parse of the string of bytes
    lodsb ;load in AL the content of DS:SI
    mov ah, 8
    oglinda: ;label for mirror string
        ror al,1
        rcl bl,1
        dec ah
        cmp ah,0
        jne oglinda
    mov al, bl
    cld ;set an ascending parse for the string dest
    stosb ;store in ES:DI the content of AL
    loop Repeta

sfarsit:
    mov ax,4C00h
    int 21h

code ends
end start

