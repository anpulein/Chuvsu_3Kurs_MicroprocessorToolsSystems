include console.inc
.386
.model FLAT,STDCALL

; Объявления данных
.data
	num8 dw 6571
	num10 dw 0
	base dw 8
	weight dw 1
	number dw 10
	check dw ?
	result dd ?
	zero dw 0
	lenWord dw 1111111111111111b
    OUT dd ?
	real dd ?
	message db 20 dup (0)
	msg db "Result %d ", 0
	
	
	
; Программа
.code
_start:
    call GetStdHandle, STD_OUTPUT_HANDLE
    mov OUT, eax 
	
	; вычисления
	finit			; инициализация сопроцессора
	fldcw lenWord	
	
	; Стек данных
	
	fild number	; st(7)
	fild base	; st(6)
	fild weight	; st(5)
	fild num10	; st(4)
	fild num8	; st(3)
	fldz		; st(2)
	fldz		; st(1)
	fldz		; st(0)
	
processing:
	fimul zero
	fadd st, st(7)
	fxch st(1)
	fimul zero
	fadd st, st(3) ; st(0) = число, st(1) = 10
	fprem			; st(0) = число mod 10 => число
	fmul st, st(5)	; st(0) 
	fadd st, st(4)	; st(0) 
	fst st(4)		; st(4) 
	;-----------------------------
	fimul zero
	fadd st, st(5)  ; st(0) 
	fmul st, st(6)	; st(0) 
	fst st(5)		; st(5) 
	;-----------------------------
	fimul zero
	fadd st, st(3)	; st(0) = число		
	fidiv number	; st(0) = число div 10 => следующая итерация
	FRNDINT			; округляю число 
	fst st(3)		
	;-----------------------------
	fist check		; число div 10
	cmp check, 0
	jne processing	; если check != 0
	
	; обработка завершена
	; Результат
	fimul zero
	fadd st, st(4)	; st(0) = результат
	fist result		; result = st(0)
	
	fninit  
	
	call _wsprintfA, offset message, offset msg, result
	call WriteConsole, OUT, offset message, 20, offset real, 0
	
	call ExitProcess,0
end _start
	
	
	
	
	
	
	
	
	
	
	
	
	
	