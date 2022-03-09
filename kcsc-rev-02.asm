section .data
	msg1 db "Enter a string: "
	len1 equ $-msg1

	msg2 db "Uppercase: "
	len2 equ $-msg2

section .bss
	string resb 100

section .text
	global _start

_start:
	; Displaying 'Enter a string: '
	mov eax, 4	;sys_write
	mov ebx, 1	;stdout
	mov ecx, msg1
	mov edx, len1
	int 0x80	;call kernel

	; Read stdin
	mov eax, 3	;sys_read
	mov ebx, 0	;stdin
	mov ecx, string
	mov edx, 100
	int 0x80

	; Displaying 'Uppercase: '
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, len2
	int 0x80
	
	; to upper
	mov ecx, string
	mov edx, 100
	call _toUpper
	
	; Displaying string
	mov eax, 4
	mov ebx, 1
	mov ecx, string
	mov edx, 100
	int 0x80	

	; Exit
	mov eax, 1	;sys_exit
	mov ebx, 0
	int 0x80
	
_toUpper:
	mov al, [ecx]
	cmp al, 0x0
	je done
	cmp al, 'a'
	jb next
	cmp al, 'z'
	ja next
	sub al, 0x20	;to uppercase a char
	mov [ecx], al
	jmp next

done: 
	ret

next:
	inc ecx
	jmp _toUpper
