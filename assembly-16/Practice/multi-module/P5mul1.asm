;5. Read the numbers a, b and c and compute and print on the screen a+b-c.
assume cs:code,ds:data
data segment

    finalResult db 10,"result: $"
    current db 0
    result dw 0
    errormsg db 10 ,'Error: not a valid number! Program ends here!$'
    msg db 10,'Read 3 numbers a, b, c :',10,'$'
    readMax db 5
    lenMax db ?
    read db 5 dup (?)
    print db 5 dup (?),10,'$'
    public read
    public lenMax
    public print

data ends
code segment
extrn toNumber:far
extrn base10:far
start:
    mov ax, data
    mov ds, ax
    ;print message 
    mov ah, 09h
    mov dx, offset msg
    int 21h

bucla:
    inc current
    ;read
    mov ah,0ah
    mov dx, offset readMax
    int 21h
    ;convert to asciiz
    mov ah, 02h
    mov dl,10
    int 21h

    call toNumber;result in ax
    cmp ax, -1
    je error

    cmp current, 3
    je difference
    
    add result, ax

    jmp bucla

difference:
    
    sub result,ax

    mov ax, result
    cmp ax, 0
    jl change
    mov bx, 0
    jmp cont

change:
    neg ax
    mov bx,-1

cont:
    call base10
    inc di

    mov ah,09h
    lea dx, finalResult
    int 21h

    cmp bx,-1
    je print1
    jmp print2

print1:
    mov ah, 02h
    mov dl,'-'
    int 21h

print2:
    mov ah,09h
    mov dx, di
    int 21h

    jmp final

error:
    mov ah, 09h
    lea dx, errormsg
    int 21h

final:
    mov ax, 4c00h
    int 21h


code ends
end start