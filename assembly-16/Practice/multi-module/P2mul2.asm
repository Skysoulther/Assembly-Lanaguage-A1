assume cs:code

extrn Number:byte
extrn buffer:byte
extrn len:word
code segment

public checkNumber
checkNumber proc

    mov si, ax
    cld
    bucla:
        lodsb
        test al, al
        jz cont
        sub al, '0'
        cmp al, 0
        jb notNumber
        cmp al, 9
        ja notNumber
        jmp bucla
    
    cont:
        mov ax, -1
        jmp final

    notNumber:
        mov ax, 0
    
    final:
        ret

checkNumber endp
public save
save proc

    mov di, seg buffer
    mov es, di
    mov di, offset buffer
    add di,len
    mov si, offset Number
    cld

    repeat:
        lodsb
        test al, al
        jz saver
        stosb
        jmp repeat
    
    saver:
        mov al,' '
        stosb
        sub di,offset buffer
        ret

save endp

code ends
end