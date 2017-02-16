

[bits 32]

section .text 

extern  _printf
extern _exit
extern __time32
extern _getchar

_generate:
	push ebp
	mov ebp, esp
	mov eax, [ebp+8]
	
	and eax, 00ffff00h
	mov cl,8
	shr eax,cl
	mul ax
	mov cl, 16
	ror eax,cl
	mov ax, dx
	ror eax, 16
	add eax, [k]
	mov ebx, eax
	
	push eax
	push format
	call _printf
	add esp, 8
	
	mov eax, ebx
	
	pop ebp
	ret
	

global  _main 

_main: 
		push 0
		call __time32
		add esp,4
		
		mov ebx, eax
		
		push    DWORD text 
		call    _printf
		add     esp, 4
		
		bucla:
		
			call _getchar
			cmp eax, -1
			je final
		
			;mov cl,7
			;shl ebx,cl
			
			mov eax,ebx
			
			push eax
			call _generate
			add esp, 4
			
			jmp bucla
		
        final:
			push    0
			call    _exit
			ret 

section .data

text:   db 'Press something(Ctrl+z to stop): ',0
format db "%d",0
k dd 137