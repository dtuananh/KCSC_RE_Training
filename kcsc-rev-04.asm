section .data
	msg1 db "Enter a string: ", 0h
	len1 equ $- msg1
	msg2 db "Reverse string: ", 0h
	len2 equ $- msg2
	
section .bss
	string resb 255
	len resb 1
	rev_str resb 255
	
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
	mov edx, 255
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
	mov [rev_str], eax
	
; Print rev-string
	mov edx, len
	mov ecx, rev_str
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
	mov ecx, len
	mov esi, eax
	add edi, rev_str
	dec edi
	
	.rev:
		cmp ecx, 0
		jz .finished
		mov al, [esi]
		mov ah, [edi]
		mov [esi], ah
		mov [edi], al
		inc esi
		dec edi
		dec ecx
		jmp .rev
	
	.finished:
		sub eax, ebx
		pop ebx
		ret
