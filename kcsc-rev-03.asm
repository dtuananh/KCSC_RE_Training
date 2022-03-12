section .data
	msg1 db "Enter a string: ", 0h
	len1 equ $- msg1
	msg2 db "Length of string: ", 0h
	len2 equ $- msg2
	
section .bss
	string resb 255
	count resb 1
	
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
	mov [count], eax

	mov ecx, [count]
	add ecx, 48		; convert to string
	mov [count], ecx
	
; Print [count]	
	mov edx, eax
	mov ecx, count
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
