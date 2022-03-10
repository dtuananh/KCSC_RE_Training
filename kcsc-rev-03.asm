section .data
	msg1 db "Enter a string: "
	len1 equ $- msg1
	msg2 db "Length of string: "
	len2 equ $- msg2
	count dw 0
	size_count equ $- count
section .bss
	string resb 255

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
	
	mov eax, string
	call _strlen

	mov eax, 4
	mov ebx, 1
	mov ecx, count
	mov edx, size_count
	int 0x80
	
	mov eax, 1
	mov ebx, 0
	int 0x80

_strlen:
	push ebx
	mov ebx, eax

_nextChar:
	cmp byte [eax], 0
	jz _exit
	inc eax
	inc word [count]
	jmp _nextChar
	
_exit:	
	sub eax, ebx
	pop ebx
	ret
