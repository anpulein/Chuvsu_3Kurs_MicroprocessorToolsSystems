include console.inc
.386
.model FLAT,STDCALL

.data
	nStdHandle dd 0
	oStdHandle dd 0
	result dw 0
	inword db "1222211", 0
	ouword db 20 dup(20h)
	nameout db 'CONOUT$',0
.data?

.code
_start:
	push STD_OUTPUT_HANDLE
	call GetStdHandle
	mov nStdHandle, eax
	push STD_INPUT_HANDLE
	call GetStdHandle
	mov oStdHandle, eax
	mov esi, offset inword
	mov edi, offset ouword
	dec edi
	
	while:
		inc edi
		mov al, byte ptr [esi]
		inc esi
		sub al, 30h
		cmp al, 1
		je state1
		cmp al, 2
		je state5
		jmp exit

	state1:
		mov byte ptr [edi], 31h
		jmp while

	state5:
		mov byte ptr [edi], 32h
		cmp al, 1
		je state3
		cmp al, 2
		je state4
		jmp exit

	state2:
		mov byte ptr [edi], 31h
		cmp al, 1
		je state5
		cmp al, 2
		je state3
		jmp exit
	
	state3:
		mov byte ptr [edi], 31h
		cmp al, 1
		je state2
		cmp al, 2
		je state3
		jmp exit
	
	state4:
		mov byte ptr [edi], 32h
		cmp al, 1
		je state1
		cmp al, 2
		je state2
		jmp exit
	
	; Выход с программы
	exit:
	mov byte ptr [edi], 20h
	call WriteConsoleA, nStdHandle, offset ouword, 20, offset result, 0
	call ExitProcess, 0
 end _start
