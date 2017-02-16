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
    ; initialize DS and ES
    mov ax, data
    mov ds, AX
    mov es, AX
    ; Create Data Transfer Address
    mov ah, 1ah
    mov dx, offset DTA
    int 21h
    ; Get the current directory
    mov ah, 47h
    mov dl, 0
    mov si, offset directory
    int 21h
    jc error
    ; print curreent directory name
    mov ah, 09h
    mov dx, offset directory
    int 21h
    ; set the file_spec and find the first file from current directory
    mov dx, offset file_spec
    mov cx, 10h
    mov ah, 4eh
    int 21h
    jc error; jump if error occurs
    ; set direction flag to 0 and set the values of si and di
    cld
    printName:
        lea si, DTA + 30
        mov di, offset filename
        ; start copying the filename to ES:DI in order to be printed
        repeat:
            lodsb
            stosb
            test al, al
            jnz repeat ;repeat until we find a 0 in the string
        ; Add a space and '$' at the end of the filename
        dec di
        mov al,' '
        stosb
        mov al, '$'
        stosb
        ; print the name of the file
        mov ah, 09h
        mov dx, offset filename
        int 21h
        ; find the next file
        mov ah, 4fh
        int 21h
        jc error
        jmp printName ; repeat the printing until there are no files and an error occurs

error:
    ; Find what kind of error occurs
    cmp ax, 15
    je error1
    cmp ax, 2
    je error2
    cmp ax, 3
    je error3
    cmp ax, 18
    je error4

error1:
    ; Print a specific message for Drive Error
    mov ah, 09h
    mov dx, offset errorDrive
    int 21h
    jmp sfarsit

error2:
    ; Print a specific message for File Error
    mov ah, 09h
    mov dx, offset errorFile
    int 21h
    jmp sfarsit

error3:
    ; Print a specific message for Path Error
    mov ah, 09h
    mov dx, offset errorPath
    int 21h
    jmp sfarsit

error4:
    ; Print a specific message if there are no more files
    mov ah, 09h
    mov dx, offset errorFiles
    int 21h

sfarsit:
    ; finish the program
    mov ax, 4C00h
    int 21h

code ends
end start