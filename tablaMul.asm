section .data
    mensaje db "Ingrese un numero (1-9): ", 0
    salto db 10
    signomul db " x ", 0
    igual db " = ", 0

section .bss
    numero resb 2
    buffer resb 16

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, 26
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, numero
    mov edx, 2
    int 0x80

    movzx eax, byte [numero]
    sub eax, '0'
    mov esi, eax

    mov ecx, 1

bucle:
    cmp ecx, 11
    jge salir

    push ecx
    push esi

    mov eax, esi
    call imprimir_num
    mov eax, 4
    mov ebx, 1
    mov ecx, signomul
    mov edx, 3
    int 0x80

    pop eax
    push eax
    call imprimir_num

    mov eax, 4
    mov ebx, 1
    mov ecx, igual
    mov edx, 3
    int 0x80

    pop ebx
    pop eax
    mul ebx
    call imprimir_num

    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 0x80

    inc ecx
    jmp bucle

salir:
    mov eax, 1
    xor ebx, ebx
    int 0x80

imprimir_num:
    push eax
    push ebx
    push ecx
    push edx
    mov ecx, 10
    mov edi, buffer + 15
    mov byte [edi], 0
    mov ebx, 10
.convertir:
    xor edx, edx
    div ebx
    add dl, '0'
    dec edi
    mov [edi], dl
    test eax, eax
    jnz .convertir
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, buffer + 16
    sub edx, edi
    int 0x80
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
