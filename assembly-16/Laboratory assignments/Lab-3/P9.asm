;9. A byte string S is given. Obtain the string D1 which contains all the positive numbers of S and the string D2 which contains all the negative numbers of S.
;Exemple:
;S: 1, 3, -2, -5, 3, -8, 5, 0
;D1: 1, 3, 3, 5, 0
;D2: -2, -5, -8

Assume CS:code, DS:data
data segment

x dw ?
s db 1, 3, -2, -5, 3, -8, 5, 0; This array is not initialised well... CHECK IT
l EQU $-s
p db l dup (?)
n db l dup (?)

data ends

code segment
start:

mov AX, data
mov DS, AX
mov CX, l ;Put the length in CX
mov di, 0 ;Put the starting position
mov si, 0 ;Put the starting position
mov BX, 0
JCXZ Sfarsit
JMP Repeta

label2:
mov byte PTR n[BX], AL
inc BX
inc si
JMP Return

label1:
mov byte PTR p[di], AL
inc di
inc si
JMP Return

Repeta:
mov AL, byte PTR s[si]
cmp AL, 0
;JNS label1
;JS label2
mov byte PTR p[di], AL
inc si
inc di
JMP Return

Return:
loop Repeta

Sfarsit:
mov AX, 4C00h
int 21h

code ends
end start