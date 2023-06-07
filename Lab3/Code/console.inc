includelib import32.lib
; имена используемых функций из kernel32.dll
 extrn ExitProcess:near
 extrn WriteConsoleA:near
 extrn GetStdHandle:near
 extrn _wsprintfA:near
 
; присваивания для облегчения читаемости кода
 WriteConsole equ WriteConsoleA
 ReadConsoleInput equ ReadConsoleInputA
 
; определения констант и типов
STD_OUTPUT_HANDLE equ -11
