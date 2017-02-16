;13. A character string S is given. Obtain the string D which contains all the digit characters of S.
;Exemple:
;S: '+', '4', '2', 'a', '8', '4', 'X', '5'
;D: '4', '2', '8', '4', '5'

assume CS:code, DS:data
data segment

s db '+', '4', '2', 'a', '8', '4', 'X', '5'
l EQU $-s
d db l dup (?)

data ends
code segment
start:

mov AX, data 
mov DS, AX
mov CX, l ;choose the number of repetitive instrsuctions
mov SI, 0 ;set the index in the first string
mov DI, 0 ;set the index in the second string
JCXZ Sfarsit ;Tests if CX is 0 or not
JMP Repeta ; Jump to Repeta

label1:
inc si
loop Repeta

Repeta: 
mov AL, byte PTR s[si]
cmp AL, '0'
JB label1
cmp AL, '9'
JNB label1
mov byte PTR d[di], AL
inc di
inc si
loop Repeta

Sfarsit: ;end of program
mov AX,4C00h
int 21h
code ends
end start