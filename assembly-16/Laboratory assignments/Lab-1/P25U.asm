assume CS:code, DS:data
data segment

x DD ?
a DW 4
b DB 4
c DD 18

data ends
code segment
start:

mov AX, data
mov DS, AX
mov AX, a
mul a
mov BL, b
mov BH, 0
add AX, BX
adc DX, 0
add BL, b
adc BH, 0
div BX
mov DX, 0
add AX, word PTR c
adc DX, word PTR c+2
mov word PTR x,AX
mov word PTR x+2,DX
mov AX, 4C00h
int 21h

code ends
end start

