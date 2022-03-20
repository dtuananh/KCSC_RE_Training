%include 'funcs.asm'

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
	mov eax, msg1
	call _sPrint

; Read stdin
	mov eax, string
	call _scanStr

; Displaying msg2
	mov eax, msg2
	call _sPrint

; Calculated 	
	xor eax, eax		; eax = 0	
	mov eax, string
	call _strlen
	mov [count], eax

	xor eax, eax
	mov eax, [count]
	call _iPrint
	
	call _quit
