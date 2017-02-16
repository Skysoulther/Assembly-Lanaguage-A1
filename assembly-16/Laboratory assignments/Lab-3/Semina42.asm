Assume CS:code,DS:data

data segment

s db 'abcd'
len EQU $-s
d db len dup (?)

data ends

code segment
start:

push data
pop DS
mov bx, 0

Repeat:

mov AL,s[bx]
sub AL,'a'-'A'
mov d[bx],AL
inc bx
cmp bx,len
JB Repeat

mov AX,4C00h
int 21h

code ends
end start