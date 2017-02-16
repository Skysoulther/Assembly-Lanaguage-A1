;9. Print the name and content of the current directory (the name of all files and subdirectories).
assume CS:code,DS:data

data segment

file_spec db "*.*",0
filename db 13 dup (?)
directory db 65 dup ('$')
DTA db 128 dup (0)
errorDrive db "Invalid drive specified! $"
errorFile db "File not found! $"
errorPath db "Path not found! $"
errorFiles db "No more files to be found! $"

data ends

code segment
start:
    ;
    mov ax, data
    mov ds, AX
    mov es, AX
    ;
    mov ah, 1ah
    mov dx, offset DTA
    int 21h
    ;
    mov ah, 47h
    mov dl, 0
    mov si, offset directory
    int 21h
    jc error
    ;
    mov ah, 09h
    mov dx, offset directory
    int 21h
    ;
    mov dx, offset file_spec
    mov cx, 10h
    mov ah, 4eh
    int 21h
    jc error
    ;
    cld
    printName:
        lea si, DTA + 30
        mov di, offset filename
        ;
        repeat:
            lodsb
            stosb
            test al, al
            jnz repeat
        ;
        dec di
        mov al,' '
        stosb
        mov al, '$'
        stosb
        mov ah, 09h
        mov dx, offset filename
        int 21h
        mov ah, 4fh
        int 21h
        jc error
        jmp printName
    
    ;
    ;mov di, offset file_spec
    ;cld
    ;repeat:
        ;lodsb
        ;stosb
        ;cmp al, 0
        ;jne repeat
    ;

    jmp sfarsit

error:
    cmp ax, 15
    je error1
    cmp ax, 2
    je error2
    cmp ax, 3
    je error3
    cmp ax, 18
    je error4

error1:
    mov ah, 09h
    mov dx, offset errorDrive
    int 21h
    jmp sfarsit

error2:
    mov ah, 09h
    mov dx, offset errorFile
    int 21h
    jmp sfarsit

error3:
    mov ah, 09h
    mov dx, offset errorPath
    int 21h
    jmp sfarsit

error4:
    mov ah, 09h
    mov dx, offset errorFiles
    int 21h

sfarsit:
    mov ax, 4C00h
    int 21h

code ends
end start