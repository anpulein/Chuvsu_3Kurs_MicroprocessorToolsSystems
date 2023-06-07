include console.inc
.386
.model FLAT,STDCALL

; Объявления данных
.data
	one db 1b
	x1  db 0b
	x2  db 1b
	x3  db 1b
	x4  db 1b
	f1  db 0b
	f2  db 0b
	y   dd 0b
	hconsOUT dd ?
	real dd ?
	message db 1 dup (0)
	msg db "%d", 0
	
	
	
; Программа
.code
_start:
    call GetStdHandle, STD_OUTPUT_HANDLE
    mov hconsOUT, eax 
	xor eax, eax

	; Вычисляем x1 and x2 and x3 and not(x4)
	mov al, x1  ; al = x1
	and al, x2  ; al = x1 and x2
	and al, x3	; al = x1 and x2 and x3

	mov ah, x4
	not ah
	and ah, one ; ah = not(x4)

	and al, ah  ; al = x1 and x2 and x3 and not(x4)
	mov f1, al  ; f1 = x1 and x2 and x3 and not(x4)

	; Вычисляем x1 and not(x2) and not(x3) and not(x4)
	xor al, al
	xor ah, ah

	mov al, x1  ; al = x1

	mov ah, x2
	not ah
	and ah, one ; ah = not(x2)
	and al, ah  ; al = x1 and not(x2)

	mov ah, x3
	not ah
	and ah, one ; ah = not(x3)
	and al, ah  ; al = x1 and not(x2) and not(x3)
	
	mov ah, x4
	not ah
	and ah, one ; ah = not(x4)
	and al, ah  ; al = x1 and not(x2) and not(x3) and not(x4)

	mov f2, al  ; f2 = x1 and not(x2) and not(x3) and not(x4)

	mov al, f1
	or  al, f2	; al = (x1 and x2 and x3 and not(x4)) or (x1 and not(x2) and not(x3) and not(x4))

	mov y, eax  ; y = (x1 and x2 and x3 and not(x4)) or (x1 and not(x2) and not(x3) and not(x4))
	
	
	call _wsprintfA, offset message, offset msg, y
	call WriteConsole, hconsOUT, offset message, 1, offset real, 0
	
	call ExitProcess, 0
end _start
	
	
	
	
	
	
	
	
	
	
	
	
	
	