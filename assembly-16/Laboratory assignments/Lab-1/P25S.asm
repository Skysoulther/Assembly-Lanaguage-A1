assume CS:code, DS:data

data segment

x DD ?
a DW -4
b DB -2
c DD 13

data ends
code segment
start:

mov AX, data
mov DS, AX
mov AX, a
imul a
mov BX, AX
mov CX, DX
mov AL, b
cbw
cwd
add BX, AX
adc DX, CX
mov AL, b
add AL, b
cbw
mov CX, AX
mov AX, BX
idiv CX
cwd
add AX, word PTR c
adc DX, word PTR c+2
mov word PTR x, AX
mov word PTR x+2, DX
mov AX, 4C00h
int 21H

code ends
end start


