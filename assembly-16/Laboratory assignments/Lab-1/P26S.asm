assume CS:code, DS:data

data segment

x DD ?
a DW -4
b DB -8
c DW -5
d DD 17

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
idiv c
cwd
add BX, AX
adc CX, DX
mov AX, 1
cwd
sub BX, 1
sbb CX, DX
mov AL, b
cbw
add AX, c
mov DX, CX
mov CX, AX
mov AX, BX
idiv CX
cwd
add AX, word PTR d
adc DX, word PTR d+2
mov word PTR x, AX
mov word PTR x+2, DX
mov AX, 4C00h
int 21H

code ends
end start


