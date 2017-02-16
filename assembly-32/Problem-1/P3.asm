
[bits 32]

section .text 

extern _printf
extern _exit

_Modulus:
	push ebp
	mov ebp, esp
	
	mov eax, [ebp+8]
	dec eax
	not eax
	
	pop ebp
	ret

global  _main 

_main: 
		
        mov esi, sir
		bucla:
			cmp esi,final
			je sfarsit
			mov eax, [esi]
			cmp eax, 0
			jl negativ
			add [sum], eax
			add esi,4
			jmp bucla
		
		
		negativ:
			push eax
			call _Modulus
			add esp, 4
			add [sum], eax
			add esi, 4
			jmp bucla
			
		sfarsit:
			mov eax,[sum]
			push eax
			push message
			call _printf
			
			add esp,8
			
			push 0
			call    _exit
			ret 

section .data

sir dd 1,-10,5,2,5,0,-9,17,-1,50,-2
final dd 0
sum dd 0
message db "The sum is: %d",0