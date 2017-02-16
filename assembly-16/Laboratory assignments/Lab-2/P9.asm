;9. The word A and the byte B are given. Obtain the byte C in the following way:
;- the bits 0-3 of C are the same as the bits 6-9 of A
;- the bits 4-5 of C have the value 1
;- the bits 6-7 of C are the same as the bits 1-2 of B

assume CS:code, DS:data

data segment

c db ?
a dw 1100110011111111b
b db 10101010b

data ends

code segment
start:

mov AX, data
mov DS, AX

mov BL, 0

mov AX, a
and AX, 0000001111000000b
mov CL, 6
ror AX, CL
or BL, AL

or BL, 00110000b

mov AL, b
and AL, 00000011b
mov CL, 6
rol AL, CL
or BL, AL

mov c, BL
mov AX, 4C00h
int 21h

code ends
end start