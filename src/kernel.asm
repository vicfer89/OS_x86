[BITS 32] ; Todo el código a partir de aquí será de 32 bits
global _start

CODE_SEG equ 0x08 ; Segmento para código
DATA_SEG equ 0x10 ; Segmento para datos

_start:
    mov ax, DATA_SEG
    mov ds, ax          ; Segmento de datos
    mov es, ax          ; Segmento extra
    mov fs, ax          ; Segmento extra
    mov gs, ax          ; Segmento extra
    mov ss, ax          ; Segmento de Stack
    mov ebp, 0x00200000 ; Puntero base para el stack
    mov esp, ebp        ; Apuntamos el stack a su base

    ; Activamos línea A2
    in al, 0x92   ; Leemos registro
    or al, 2      ; Aplicamos la máscara
    out 0x92, al  ; Escribimos registro

    jmp $