assume CS:code,DS:data
data segment

c db ?
b db 11001100b
a dw 1010101010101010b

data ends
code segment
start:

mov AX, data
mov DS, AX
mov AX, a
and AX, 0000111100000000b
mov CL, 8
ror AX, CL
mov BL, b
and BL, 11110000b
or BL, AL
mov c, BL
mov AX, 4C00h
int 21h

code ends
end start