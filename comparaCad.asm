section .data
mensaje1 db "Ingrese la primera cadena: ", 0
mensaje2 db "Ingrese la segunda cadena: ", 0
resultado1 db "La primera cadena es mas larga", 10, 0
resultado2 db "La segunda cadena es mas larga", 10, 0
resultado3 db "Ambas cadenas tienen la misma longitud", 10, 0

section .bss
cadena1 resb 51
cadena2 resb 51
long1 resd 1
long2 resd 1

section .text
global _start

_start:
mov eax, 4
mov ebx, 1
mov ecx, mensaje1
mov edx, 27
int 0x80

mov eax, 3
mov ebx, 0
mov ecx, cadena1
mov edx, 50
int 0x80
mov [long1], eax

mov eax, 4
mov ebx, 1
mov ecx, mensaje2
mov edx, 27
int 0x80

mov eax, 3
mov ebx, 0
mov ecx, cadena2
mov edx, 50
int 0x80
mov [long2], eax

mov eax, [long1]
mov ebx, [long2]
cmp eax, ebx
jg primera_mas_larga
jl segunda_mas_larga

mov eax, 4
mov ebx, 1
mov ecx, resultado3
mov edx, 40
int 0x80
jmp salir

primera_mas_larga:
mov eax, 4
mov ebx, 1
mov ecx, resultado1
mov edx, 33
int 0x80
jmp salir

segunda_mas_larga:
mov eax, 4
mov ebx, 1
mov ecx, resultado2
mov edx, 33
int 0x80

salir:
mov eax, 1
xor ebx, ebx
int 0x80
