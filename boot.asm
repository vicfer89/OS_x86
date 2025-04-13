; Fichero de ensamblador para bootloader y proceso de boot
ORG 0      ; Dirección de origen de datos, tomado como offset para segmentos de datos
BITS 16    ; Forzamos instrucciones a 16 bits (modo de arranque de bios)

; Para el cálculo del origen de datos tenemos que:
;   Segmento de origen: 0x7c00
;   Dirección:  Segmento * 16 + offset
;   En nuestro caso: 0x7c0 * 16 + ORG = 0x7c00 + 0 = 0x7c00
jmp 0x7c0:start     ; Hace que el segmento de código sera el 0x7c00 (0x7c0 * 16 + 0)
start:
    cli             ; Deshabilitamos interrupciones    
    mov ax, 0x7c0   ; Ponemos en 'ax' el origen de datos que queremos (0x7c0)
    mov ds, ax      ; ponemos el segmento de datos 'ds' en el valor de origen de bios (ds = 0x7c0 * 16 + 0 = 0x7c00)
    mov es, ax      ; Ponemos el segmento extra 'ex' en el valor de origen de bios    (es = 0x7c0 * 16 + 0 = 0x7c00)
    mov ax, 0x00 
    mov ss, ax      ; Ponemos el segmento del stack 'ss' a cero.                      
    mov sp, 0x7c00  ; Situamos el puntero de Stack en la dirección de origen de bios
    sti             ; Habilitamos interrupciones
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