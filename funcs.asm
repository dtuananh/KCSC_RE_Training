; Scan a string
_scanStr:
	push edx
	push ecx
	push ebx
	push eax
	
	mov edx, 255
	pop eax
	
	mov ecx, eax
	mov ebx, 0
	mov eax, 3
	int 0x80
	
	pop ebx
	pop ecx
	pop edx
	ret

; Print interger
_iPrint:
	push eax
	push ecx
	push edx
	push esi
	mov ecx, 0
	
loopDivide:
	inc ecx
	mov edx, 0
	mov esi, 10
	idiv esi
	add edx, 48
	push edx
	cmp eax, 0
	jnz loopDivide
	
loopPrint:
	dec ecx
	mov eax, esp	
	call _sPrint
	pop eax
	cmp ecx, 0
	jnz loopPrint
		
	pop esi
	pop edx
	pop ecx
	pop eax
	ret

; Calculated len of string	
_strlen:
  push ebx
  mov ebx, eax
 
  .nextChar:
     	  cmp byte [eax], 0
    	  jz .finished
    	  inc eax
    	  jmp .nextChar
 
  .finished:
    	sub eax, ebx
    	pop ebx
    	ret

; Print string	
_sPrint:
	push edx
	push ecx
	push ebx
	push eax
	call _strlen
	
	mov edx, eax
	pop eax
	
	mov ecx, eax
	mov ebx, 1
	mov eax, 4
	int 0x80
	
	pop ebx
	pop ecx
	pop edx
	ret
	
; End program
_quit:
	xor ebx, ebx
	mov eax, 1
	int 0x80
	ret
