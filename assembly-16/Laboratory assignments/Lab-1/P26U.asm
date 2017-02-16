assume CS:code, DS:data

data segment

x DD ?
a DW 4
b DB 8
c DW 5
d DD 15

data ends
code segment
start:

mov AX, data
mov DS, AX
mov AX, a
mul a
mov BX, AX
mov CX, DX
mov AL, b
mov AH, 0
mov DX, 0
div c
mov DX, 0
add AX, BX
adc DX, CX
sub AX, 1
sbb DX, 0
mov BL, b
mov BH, 0
add BX, c
div BX
mov DX, 0
add AX, word PTR d
adc DX, word PTR d+2
mov word PTR x, AX
mov word PTR x+2, DX
mov AX, 4C00h
int 21H

code ends
end start


