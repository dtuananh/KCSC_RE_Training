.386
.model flat, stdcall
.stack 4096
option casemap: none

include D:\masm32\include\windows.inc
include D:\masm32\include\kernel32.inc
include D:\masm32\include\masm32.inc
includelib D:\masm32\lib\kernel32.lib
includelib D:\masm32\lib\masm32.lib


MAXBUF equ 256
NULL equ 0

.data
	msg BYTE "Enter your name: ", 0
	Buffer BYTE MAXBUF DUP(?)
	
	StdInHandle HANDLE ?
	StdOutHandle HANDLE ?

.code
main proc
	call GetHandle
	
	push offset msg
	call WriteString
	
	push offset Buffer
	call ReadString
	
	push offset Buffer
	call WriteString
	
	push 0
	call ExitProcess
main endp

	
GetHandle proc
	push STD_INPUT_HANDLE
	call GetStdHandle
	mov StdInHandle, eax
	
	push STD_OUTPUT_HANDLE
	call GetStdHandle
	mov StdOutHandle, eax
	ret
GetHandle endp

	
ReadString proc
	push ebp
	mov ebp, esp
	sub esp, 4		;allocate space on stack for variable
	pushad			;push eax, ecx, edx, ebx, esp (original value), ebp, esi, edi on stack
	
	;Use WinAPI ReadConsole
	push NULL			;pInputControl = NULL
	lea ebx, DWORD ptr [ebp - 4]
	push ebx			;lpNumberOfCharsRead = ebp - 4
	push MAXBUF			;nNumberOfCharsToRead = MAXBUF
	push DWORD ptr [ebp + 8]	;lpBuffer = offset string
	push StdInHandle		;hConsoleInput = StdInHandle
	call ReadConsole
	
	popad
	add esp, 4		
	leave
	ret
ReadString endp


WriteString proc
	push ebp
	mov ebp, esp
	sub esp, 4
	pushad
	
	push DWORD ptr [ebp + 8]
	call Strlen		;eax = length of string
	
	;Use WinAPI WriteConsole
	push NULL			;lpReserved = NULL
	lea ebx, DWORD ptr [ebp - 4]
	push ebx			;lpNumberOfCharsWritten = [ebp - 4]
	push eax			;nNumberOfCharsToWrite = length of string = eax
	push DWORD ptr [ebp + 8]	;lpBuffer = [ebp + 8]
	push StdOutHandle		;hConsoleOutput = StdOutHandle
	call WriteConsole
	
	popad
	add esp, 4
	leave
	ret
WriteString endp


Strlen proc
	push ebp
	mov ebp, esp
	push edi
	
	mov edi, DWORD ptr [ebp + 8]
	xor eax, eax
L1:
	cmp BYTE ptr [edi], NULL
	je L2
	inc edi
	inc eax
	jmp L1
L2:
	leave
	ret
	
Strlen endp


end main
