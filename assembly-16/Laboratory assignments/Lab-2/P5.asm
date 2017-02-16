;5. The bytes A and B are given. Obtain the word C in the following way:
;- the bits 0-3 of C are the same as the bits 3-6 of B
;- the bits 4-7 of C have the value 0
;- the bits 8-10 of C have the value 110
;- the bits 11-15 of C are the same as the bits 0-4 of A

assume CS:code,DS:data

data segment

c dw ?
a db 10101111b 
b db 11011101b

data ends

code segment
start:

mov BX, 0

mov AL, b ;PROBLEM: b has not that value
and AL, 01111000b
mov CL, 3
ror AL, CL
or BL, AL

and BH, 00000110b

mov AL, a ;PROBLEM: a has not that value
and AL, 00011111b
mov CL, 3
rol AL, CL
or BH, AL

mov c, BX

mov AX, 4C00h
int 21h

code ends
end start