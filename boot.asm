; Fichero de ensamblador para bootloader y proceso de boot
ORG 0x7c00 ; Dirección definida por BIOS para carga de arranque
BITS 16    ; Forzamos instrucciones a 16 bits (modo de arranque de bios)

start:
    mov ah, 0eh     ; Instrucción de tipo Teletype a Bios (Ver 1. en enlaces)
    mov al, 'A'     ; Caracter a representar
    mov bx, 0       ; Número de página para representar la información
    int 0x10        ; Interrupción de BIOS para pantalla

    jmp $           ; Saltamos a la misma instrucción

; Ponemos la BOOT signature para el fichero
times 510 - ($ - $$) db 0 ; Llenamos 510 bytes de ceros hasta los últimos 2 bytes, que serán la firma
dw 0xAA55                 ; NOTA: Cambiados al ser Little Endian