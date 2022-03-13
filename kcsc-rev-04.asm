section .data
	msg1 db "Enter a string: ", 0h
	len1 equ $- msg1
	msg2 db "Reverse string: ", 0h
	len2 equ $- msg2
	
section .bss
	string resb 128
	len resb 1
	rev_str resb 128
	
section .text
	global _start

_start:
	
; Displaying msg1
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 0x80

; Read stdin
	mov eax, 3
	mov ebx, 0
	mov ecx, string
	mov edx, 128
	int 0x80

; Displaying msg2
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, len2
	int 0x80
	
	xor eax, eax		; eax = 0	
	mov eax, string
	call _strlen
	mov [len], eax
	
	xor eax, eax
	mov eax, string
	call _revStr
	
; Print rev-string
	mov edx, len
	mov ecx, eax
	mov ebx, 1
	mov eax, 4
	int 0x80

; Exit	
	mov eax, 1
	xor ebx, ebx
	int 0x80

_strlen:
    	push ebx
    	mov  ebx, eax
 
	.nextchar:
    		cmp byte [eax], 0xA
    		jz  .finished
    		inc eax
    		jmp .nextchar
 
	.finished:
    		sub eax, ebx
    		pop ebx
    		ret

_revStr:
	push ebx
	mov ebx, eax
	
	mov esi, 0
	mov edi, 0
	mov ecx, [len]
	mov esi, eax
	mov edi, eax
	add edi, [len]
	dec edi		; bỏ qua null
	.rev:
		cmp esi, edi
		jg .finished
		mov cl, [esi]
		mov ch, [edi]
		mov [esi], ch
		mov [edi], cl
		inc esi
		dec edi
		jmp .rev
	
	.finished:		
		sub eax, ebx
		inc edi
		sub edi, [len]
		mov eax, edi
		pop ebx
		ret
