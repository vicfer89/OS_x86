section .asm

global idt_load
idt_load:
    push ebp
    mov ebp, esp

    mov ebx, [ebp+8] ; El +8 se emplea según la llamada estándar para apuntar al primer elemento de entrada de la función
    lidt [ebx]

    pop ebp
    ret
