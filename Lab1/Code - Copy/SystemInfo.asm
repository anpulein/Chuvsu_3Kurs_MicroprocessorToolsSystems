include console.inc
.386
.model FLAT,STDCALL

.data
	readBuffer dw 10 dup(?)
	outBuffer db 10 dup(20h), 0
	lpWritten dd ?
	lpReser dw ?   
	system db 2
	
	szFmtdw db '%-12.lu', 0
	szFmtdd db '%-12.lu', 0
	szValue db 10 dup(0)
.data?

.code
_start:
	
	push STD_INPUT_HANDLE
call GetStdHandle
mov ebx, eax

call ReadConsoleA, ebx, offset readBuffer, 9, offset lpWritten


	xor eax, eax
	mov esi, offset readBuffer
	xor edx, edx
	sub lpWritten, 2
	return:
	cmp byte ptr [esi], 0Dh
	je exit
	mov ecx, lpWritten
	dec ecx
	mov al, byte ptr [esi]
	sub al, 30h
	cmp ecx, 0
	je exit
	stepen:
	mul system
	loop stepen
	dec lpWritten
	inc esi
	add edx, eax
	jmp return
	exit:
	add edx, eax
	
	mov esi, offset outBuffer
	return1:
	cmp byte ptr [esi], 0
	je exit3
	inc esi
	jmp return1
	dec esi
	
	exit3:
	mov eax, edx
	xor edx, edx
	mov ebx, 6
	return2:
	cmp eax, 6
	jl exit2
	div ebx
	cmp edx, 9
	jg jump
	add edx, 30h
	mov byte ptr [esi], dl
	dec esi
	xor edx, edx
	jmp return2
	jump:
	add edx, 37h
	mov byte ptr [esi], dl
	dec esi
	xor edx, edx
	jmp return2
	exit2:
	cmp eax, 9
	jg jump777
	add eax, 30h
	jmp exit777
	jump777:
	add eax, 37h
	exit777:
	
	mov byte ptr [esi], al
mov esi, eax

	push STD_OUTPUT_HANDLE
 call GetStdHandle
;возвращает идентификатор STDOUT в eax

 mov ebx,eax
 
	call WriteConsoleA, ebx, offset outBuffer, 12, offset lpWritten, offset lpReser

 
	;mov ax, outBuffer
	;call _wsprintfA, offset szValue, offset szFmtdd, eax
	;call WriteConsoleA, ebx, offset szValue , 10, offset lpWritten, offset lpReser


	call ExitProcess, 0
 end _start