; Fichero de ensamblador para bootloader y proceso de boot
ORG 0x7c00 ; Dirección definida por BIOS para carga de arranque
BITS 16    ; Forzamos instrucciones a 16 bits (modo de arranque de bios)

start:
    mov si, message ; Mueve la dirección de message al registro 'si'
    call print
    jmp $           ; Saltamos a la misma instrucción

print:
    mov bx, 0
.loop:
    lodsb           ; Carga el carácter de 'si' en el registro AL e incrementa el puntero de 'si' en 1
    cmp al, 0       ; Comparamos el valor de 'al' con 0
    je .done        ; En caso de que sea 0, saltamos a .done (sub-etiqueta)
    call print_char ; Imprimimos el carácter en al.
    jmp .loop       ; Saltamos a .loop para la siguiente instrucción
.done:
    ret

print_char:
    mov ah, 0eh     ; Instrucción de tipo Teletype a Bios (Ver 1. en enlaces)    
    int 0x10        ; Interrupción de BIOS para pantalla
    ret             ; Retorno de subrutina

message: db 'Hola mundo!', 0 ; Mensaje a representar en etiqueta

; Ponemos la BOOT signature para el fichero
times 510 - ($ - $$) db 0 ; Llenamos 510 bytes de ceros hasta los últimos 2 bytes, que serán la firma
dw 0xAA55                 ; NOTA: Cambiados al ser Little Endian