assume cs:code
extrn number:byte
extrn sixteen:word
extrn hexa:byte
extrn locali:word
code segment
public base16

base16 proc

    mov si,offset number
    mov di,seg hexa
    mov es, di
    mov locali,0
    cld
    
checkDigit:
    lodsb
    test al,al
    jz far ptr final
    ;check hexa digit
    mov di, offset hexa
    mov cx, 16
    again:
        scasb
        je cont
        loop again

notHexa:
    mov locali, -1
    jmp final

cont:
    cmp al,'9'
    jbe numbernum
    jmp letter

numbernum:
    sub al,'0'
    jmp cont2

letter:
    sub al,'A'
    add al,10

cont2:
    mov bl, al
    mov bh, 0
    mov ax,locali
    mul sixteen
    add ax, bx
    mov locali,ax
    jmp checkDigit

final:
    ret 2

base16 endp

code ends
end