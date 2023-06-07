includelib import32.lib
; имена используемых функций из kernel32.dll
 extrn ExitProcess:near
 extrn WriteConsoleA:near
 extrn GetStdHandle:near
 
 extern GetSystemInfo:near
 
 extrn GetCursorPos:near
 extrn SetCursorPos:near
 extrn GetAsyncKeyState:near
 extrn GetConsoleScreenBufferInfo:near
 extrn FillConsoleOutputCharacterA:near
 extrn _wsprintfA:near
 extrn SetConsoleCursorPosition:near
 extrn GetLastError:near
 extrn WriteConsoleOutputCharacterA:near
 extrn SetConsoleCursorInfo:near
 extrn GetConsoleCursorInfo:near
 extrn ReadConsoleA:near
; присваивания для облегчения читаемости кода
 WriteConsole equ WriteConsoleA
; имена используемых функций из mpr.dll
 extrn WNetGetUserA:near
 extrn WNetOpenEnumA:near
 extrn WNetEnumResourceA:near
 extrn WNetCloseEnum:near
; присваивания для облегчения читаемости кода
 WNetGetUser equ WNetGetUserA
 WNetOpenEnum equ WNetOpenEnumA
 WNetEnumResource equ WNetEnumResourceA
; определения констант и типов
NO_ERROR equ 0
ERROR_NO_MORE_ITEMS equ 259
RESOURCEUSAGE_CONNECTABLE equ 1
RESOURCETYPE_ANY equ 0
RESOURCE_CONNECTED equ 1
STD_OUTPUT_HANDLE equ -11
STD_INPUT_HANDLE equ -10
NTRESOURCE struc
 dwScope dd ?
 dwType dd ?
 dwDisplayType dd ?
 dwUsage dd ?
 lpLocalName dd ?
 lpRemoteName dd ?
 lpComment dd ?
 lpProvider dd ?
NTRESOURCE ends