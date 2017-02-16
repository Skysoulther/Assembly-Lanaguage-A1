assume DS:data,CS:code

data segment

c DB ?
a DB 11101110b
b DW 1010101011001100b

data ends

code segment
start:

mov AX, data
mov DS, AX
mov BL, 0
mov AL, a
and AL, 00111100b
mov CL, 2
ror AL, CL
or BL,AL
mov AX, b
and AX, 0000001111000000b
mov CL, 2
ror AX, CL
or BL, AL
mov c, BL
mov AX, 4C00h
int 21h

code ends
end start
