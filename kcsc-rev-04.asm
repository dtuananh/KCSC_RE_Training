%include 'funcs.asm'

section .data
	msg1 db "Enter a string: ", 0x0
	len1 equ $- msg1
	msg2 db "Reverse string: ", 0x0
	len2 equ $- msg2
	
section .bss
	string resb 255
	len resb 1
	
section .text
	global _start

_start:
	
; Displaying msg1
	mov eax, msg1
	call _sPrint

; Read stdin
	mov eax, string
	call _scanStr

; Displaying msg2
	mov eax, msg2
	call _sPrint

	xor eax, eax		; eax = 0	
	mov eax, string
	call _strlen
	mov [len], eax
	
	xor eax, eax
	mov eax, string
	call _revStr
	
; Print rev-string
	xor eax, eax
	mov eax, string
	call _sPrint

; Exit	
	call _quit

_revStr:
	push ebx
	mov ebx, eax
	
	mov esi, 0
	mov edi, 0
	mov ecx, [len]
	mov esi, eax
	mov edi, eax
	add edi, [len]
	dec edi
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
