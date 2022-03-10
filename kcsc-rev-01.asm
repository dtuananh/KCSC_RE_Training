section .data
	msg1 db "Enter your name: "
	len1 equ $-msg1
	msg2 db "Name: "
	len2 equ $-msg2

section .bss
	name resb 100
	
section	.text
	global _start
	
_start:
	; Displaying 'Enter your name: '
	mov eax, 4	;sys_write
	mov ebx, 1	;stdout
	mov ecx, msg1
	mov edx, len1
	int 0x80	;call kernel

	; Read stdin
	mov eax, 3	;sys_read
	mov ebx, 0	;stdin
	mov ecx, name
	mov edx, 100
	int 0x80

	; Displaying 'Name: '
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, len2
	int 0x80

	; Displaying name you entered
	mov eax, 4
	mov ebx, 1
	mov ecx, name
	mov edx, 100
	int 0x80
	
	; Exit
	mov eax, 1	;sys_exit
	int 0x80
