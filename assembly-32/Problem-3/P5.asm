;Functia main va citi string-ul needle de la tastatura (scanf/gets/fgets etc.) si va folosi un haystack hardcodat în sectiunea de date. Se va afisa pozitia de inceput a tuturor aparitiilor substringului: 
;Ex: pt. haystack=”banana”, needle=”ana”, strstr(haystack, needle) va returna haystack+3, sau “ana”, iar programul va afisa “[1,3]”.

[bits 32]

section .text 

extern _scanf
extern  _printf
extern _exit

_checkString:
	push ebp
	mov ebp, esp
	push esi
	push ebx
	
	repeta:
		mov al,[esi]
		mov ah,[ebx]
		cmp ah, 0
		je found
		cmp al, ah
		jne notFound
		inc esi
		inc ebx
		jmp repeta
		
		
	found:
		mov eax, -1
		jmp stop
	
	notFound:
		mov eax, 0
		jmp stop
		
	stop:
		pop ebx
		pop esi
		pop ebp
		ret
	
_convert10:
	push ebp
	mov ebp, esp
	
	mov eax, [ebp+8]
	mov edx,index+2
	mov cl,10
	bucla2:
		div cl
		add ah,30h
		mov [edx] ,ah
		dec edx
		mov ah, 0
		cmp al,0
		jne bucla2
	
	transfer:
		inc edx
		cmp edx, index+3
		je stop2
		mov cl,[edx]
		mov [edi],cl
		inc edi
		jmp transfer
	
	stop2:
		pop ebp
		ret

global  _main 

_main: 
        push    DWORD message 
        call    _printf
        add     esp, 4
		
		push needle
		push format
		call _scanf
		add esp, 8
		
		mov ebx, needle
		mov esi, haystack
		mov edi, result
		
		bucla:
			cmp esi, haystack+len
			je sfarsit
			call _checkString
			cmp eax, -1
			je save
			inc esi
			jmp bucla
		
		save:
			mov eax, esi
			sub eax, haystack
			push eax
			call _convert10
			add esp, 4
			mov eax, 2ch
			mov [edi] ,al
			inc edi
			inc esi
			jmp bucla
		
		sfarsit:
			dec edi
			mov cl, 0
			mov [edi],cl
			
			push dword result
			call _printf
			add esp, 4
			
			push    0
			call    _exit
			ret 

section .data

message db 'Enter a string (smaller than 5 characters): ',0
format db "%s",0
needle times 5 db 0
haystack db 'bananananannaaa',0
len equ $-haystack-1
result times len*2 db 0
index times 4 db 0
