assume cs:code
extrn read:byte
extrn lenMax:byte
extrn print:byte
code segment
public toNumber

toNumber proc

    mov si, offset read
    mov cl, lenMax
    mov ch, 0
    mov di,0
    cld
    jcxz final

bucla:

    lodsb
    sub al, '0'
    cmp al, 0
    jb notNumber
    cmp al, 9
    ja notNumber
    mov bl,al
    mov bh,0

    mov ax, di
    mov dx,10
    mul dx
    add ax, bx
    mov di, ax
    loop bucla

    mov ax, di
    jmp final

notNumber:
    mov ax,-1

final:
    ret

toNumber endp
public base10
base10 proc

    mov di, seg print
    mov es, di
    mov di, offset print+4
    mov cx, 10
    std

repeat:
    mov dx, 0
    div cx
    xchg ax, dx
    add al,'0'
    stosb
    xchg ax, dx
    cmp ax, 0
    je ending
    jmp repeat

ending:
    ret

base10 endp

code ends
end