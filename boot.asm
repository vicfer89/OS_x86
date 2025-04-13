; Fichero de ensamblador para bootloader y proceso de boot
; Por defecto, la BIOS al encontrar la firma (0x55AA) al final del primer bloque de disco, copiará ese primer bloque en la dirección
; 0x7c00 de memoria, comenzando a ejecutarla a partir de ahí.

;   Al usar las tablas de GDT, podemos poner el origen de nuevo a 0x7c00, ya que ahora configuraremos la memoria virtual en base a estas tablas, de forma que el acceso
; a memoria vendrá definido por ellas.
ORG 0x7c00      ; Dirección de origen de datos, tomado como offset para segmentos de datos
BITS 16         ; Forzamos instrucciones a 16 bits (modo de arranque de bios)

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

_start:    
    jmp short start ; Saltamos a start
    nop             ; Requerido por bloque de parámetros de BIOS

times 33 db 0 ; Bloque de parámetros de la BIOS

start:
    jmp 0x0:step2 

step2:
    cli             ; Deshabilitamos interrupciones    
    mov ax, 0x00    
    mov ds, ax      
    mov es, ax      
    mov ax, 0x00 
    mov ss, ax                        
    mov sp, 0x7c00  
    sti             ; Habilitamos interrupciones

.load_protected:
    cli 
    lgdt[gdt_descriptor] ; Carga el descriptor de GDT que hemos definido con el tamaño y la GDT
; Activamos el uso de paginación:
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:load32 ; Saltamos a la parte de 32 bits, poniendo como offset gdt_data (definido en CODE_SEG)

; GDT (Global Descriptor Table):
; GDT es un registro de 64 bits:
; bits 0 - 15   -> Limite 0:15
; bits 16 - 31  -> Base 0:15
; bits 32 - 39  -> Base 16:23
; bits 40 - 47  -> Bits de acceso
; bits 48 - 51  -> Limite 16:19
; bits 52 - 55  -> Flags
; bits 56 - 63  -> Base 24:31

; offset 0x00
gdt_start:    
gdt_null:
    dd 0 ; 4 bytes
    dd 0 ; 4 bytes

; offset 0x08
gdt_code:           ; El registro 'cs' ha de apuntar aquí
    dw 0xffff       ; (0  - 15) Límite del segmento 0:15
    dw 0            ; (16 - 31) Base para el segmento 0:15
    db 0            ; (32 - 39) Base para el segmento 16:23
    db 0x9a         ; (40 - 47) Bits de acceso [0x9a = 1001.1010]
    db 11001111b    ; (48 - 51) Limite del segmento 16:23 (1111) // (52 - 55) Flags (1100)
    db 0            ; (52 - 55) Base 24:31
; offset 0x10
gdt_data:           ; Los registros 'ds', 'ss', 'es', 'fs', 'gs' han de apuntar aquí
    dw 0xffff       ; (0  - 15) Límite del segmento 0:15
    dw 0            ; (16 - 31) Base para el segmento 0:15
    db 0            ; (32 - 39) Base para el segmento 16:23
    db 0x92         ; (40 - 47) Bits de acceso [0x9a = 1001.1010]
    db 11001111b    ; (48 - 51) Limite del segmento 16:23 (1111) // (52 - 55) Flags (1100)
    db 0            ; (52 - 55) Base 24:31

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; Longitud de GDT
    dd gdt_start               ; Dirección de origen de GDR

[BITS 32] ; Todo el código a partir de aquí será de 32 bits
load32:
    mov ax, DATA_SEG
    mov ds, ax          ; Segmento de datos
    mov es, ax          ; Segmento extra
    mov fs, ax          ; Segmento extra
    mov gs, ax          ; Segmento extra
    mov ss, ax          ; Segmento de Stack
    mov ebp, 0x00200000 ; Puntero base para el stack
    mov esp, ebp        ; Apuntamos el stack a su base
    jmp $

; Ponemos la BOOT signature para el fichero
times 510 - ($ - $$) db 0 ; Llenamos 510 bytes de ceros hasta los últimos 2 bytes, que serán la firma
dw 0xAA55                 ; NOTA: Cambiados al ser Little Endian