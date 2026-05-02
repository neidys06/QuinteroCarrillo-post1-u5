; src/entrada.asm — Programa 2: leer carácter del teclado y mostrar eco
; Ensamble: nasm -f bin entrada.asm -o ../bin/entrada.com
org 0x100
section .data
 prompt db "Ingrese una letra (se mostrara su codigo ASCII): $"
 msg_ok db 0Dh, 0Ah, "Caracter recibido: $"
 msg_cod db 0Dh, 0Ah, "Codigo ASCII (hex): $"
 nl db 0Dh, 0Ah, "$"
section .text
 ; Mostrar prompt
 mov ah, 09h
 mov dx, prompt
 int 21h
 ; Leer un carácter del teclado (sin eco automático)
 mov ah, 07h ; función 07h: leer carácter sin eco
 int 21h ; AL = código ASCII del carácter leído
 mov bl, al ; guardar el carácter en BL
 ; Mostrar el carácter leído
 mov ah, 09h
 mov dx, msg_ok
 int 21h
 mov ah, 02h ; función 02h: mostrar carácter en DL
 mov dl, bl
 int 21h
 ; Mostrar el código ASCII en hexadecimal
 mov ah, 09h
 mov dx, msg_cod
 int 21h
 ; Separar nibbles alto y bajo del código ASCII
 mov al, bl
 shr al, 4 ; nibble alto → AL
 call print_hex_nibble
 mov al, bl
 and al, 0Fh ; nibble bajo → AL
 call print_hex_nibble
 ; Nueva línea y terminar
 mov ah, 09h
 mov dx, nl
 int 21h
 mov ax, 4C00h
 int 21h
; Subrutina: imprime el nibble en AL como dígito hexadecimal
print_hex_nibble:
 cmp al, 9
 jle .digito
 add al, 7 ; A-F: offset adicional para ASCII A=41h
.digito:
 add al, 30h ; convertir a ASCII (0=30h, A=41h)
 mov ah, 02h
 mov dl, al
 int 21h
 ret
