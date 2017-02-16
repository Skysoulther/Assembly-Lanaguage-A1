;15. Read from the standard input (keyboard) two directory names, dir1 and dir2. Create the new directory dir1\dir2.
assume CS:code,DS:data

data segment

msg1 db 'Enter first directory: $'
maxDir1Length db 15
lDir1 db ?
Dir1 db 15 dup (?)
msg2 db 'Enter second directory: $'
maxDir2Length db 15
lDir2 db ?
Dir2 db 15 dup (?)
pathErrorMsg db 'Path not found!$'
accessErrorMsg db 'Access denied!$'

data ends

code segment
start:

push data
pop DS
; print message 1 from msg 1
mov ah, 09h
mov dx, offset msg1
int 21h
; Read the name of first directory
mov ah, 0ah
mov dx, offset maxDir1Length
int 21h
; convert string Dir1 to ASCIIZ
mov al, lDir1
xor ah, ah ;mov ah, 0
mov si, ax
mov Dir1[si],0
; create directory with the name saved at Dir1
mov ah,39h
mov dx, offset Dir1
int 21h
jc Error; Errors set CF to 1
; change directory... go to Dir1
mov ah,3Bh
mov dx, offset Dir1
int 21h
jc Error; errors set CF to 1
; print the second message msg2
mov ah, 09h
mov dx, offset msg2
int 21h
; read the name of the second directory Dir2
mov ah, 0ah
mov dx, offset maxDir2Length
int 21h
; convert string Dir1 to ASCIIZ
mov al, lDir2
mov ah, 0
mov si, ax
mov Dir2[si],0
; create directory with the name saved at Dir2
mov ah, 39h
mov dx, offset Dir2
int 21h
jc Error; errors set CF to 1
jmp sfarsit

Error:
	; Find the type of error
	cmp ax,3
	jz pathError
	cmp ax,5
	jz accessError
	jmp sfarsit 

pathError:
	; print path error message
	mov ah, 09h
	mov dx, offset pathErrorMsg
	int 21h
	jmp sfarsit

accessError:
	; print access error message
	mov ah, 09h
	mov dx, offset accessErrorMsg
	int 21h
	jmp sfarsit

sfarsit:
	mov ax,4C00h
	int 21h

code ends
end start 