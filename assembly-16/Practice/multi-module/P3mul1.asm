;3. Two character strings are given. 
;Compute and print on the screen the result of the concatenation of the second string after the first one, 
;and also of the first string after the second one.
data segment

    s1 db 'Marte ',0
    s2 db 'Merge pe ',0
    s3 db 'Jupiter ',0
    finalS db 50 dup (?)
    public finalS

data ends
code segment
extrn Concat:far
extrn Print:far
start:
    mov ax, seg data
    mov ds, ax

    push offset s1
    push offset s2
    call Concat
    
    push offset finalS
    call Print

    mov ah, 02h
    mov dl, 10
    int 21h

    push offset s2
    push offset s1
    call Concat

    push offset finalS
    call Print

    mov ah, 02h
    mov dl, 10
    int 21h

    push offset s2
    push offset s3
    call Concat

    push offset finalS
    call Print

    mov ax,4c00h
    int 21h

code ends
end start