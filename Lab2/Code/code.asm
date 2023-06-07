includelib import32.lib
	extrn ExitProcess:near
	extrn GetStdHandle:near


.386
.model FLAT,STDCALL

.data
	a1 dd 1;
	a2 dd 2;
	res_a dd 0
	
	s1 dd 1; 
	s2 dd 2; 
	res_s dd 0
	
	m1 dd 1; 
	m2 dd 2; 
	res_m dd 0


	STD_OUTPUT_HANDLE equ -11
	hout dd ?	
	outBuffer db 10 dup(0)

.data?

.code
_start:
	finit

	; Загрузка операндов в регистры сопроцессора
	fld a1
	fld a2
	; Сложение операндов
	faddp st(1), st(0)
	; Сохранение результата
	fstp res_a

	; Загрузка операндов в регистры сопроцессора
	fld s1
	fld s2
	; Вычитание операндов
	fsubp st(1), st(0)
	; Сохранение результата
	fstp res_s

	; Загрузка операндов в регистры сопроцессора
	fld m1
	fld m2
	; Умножение операндов
	fmulp st(1), st(0)
	; Сохранение результата
	fstp res_m

	call ExitProcess, 0
 end _start