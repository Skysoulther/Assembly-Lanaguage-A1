;4. A string of numbers is given. Print on the screen the values in base 16.
assume cs:code, ds:data
data segment

    string dw 13,234,350,16000
    len EQU ($-string)/2
    value db 4 dup (?),10,'$'
    hexa db '0123456789ABCDEF'
    sixteen dw 16
    public value
    public hexa
    public sixteen

data ends

code segment
extrn Base16:far
start:
    mov ax, data
    mov ds,ax

    mov si, offset string
    mov cx,len
    jcxz final
    
bucla:
    cld
    lodsw
    push ax
    call Base16
    inc di

    mov ah,09h
    mov dx,di
    int 21h

    loop bucla


final:
    mov ax, 4c00h
    int 21h

code ends
end start