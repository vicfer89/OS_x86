section .asm

global insb
global insw
global outb
global outw

insb:
    push ebp
    mov ebp, esp

    xor eax, eax        ; Pone a cero el registro eax
    mov edx, [ebp+8]    ; toma el argumento de la función
    in al, dx           ; Realiza la operación in

    pop ebp
    ret

insw:
    push ebp
    mov ebp, esp

    xor eax, eax        ; Pone a cero el registro eax
    mov edx, [ebp+8]    ; toma el argumento de la función
    in ax, dx           ; Realiza la operación in

    pop ebp
    ret

outb:
    push ebp
    mov ebp, esp

    mov eax, [ebp+12]
    mov edx, [ebp+8]
    out dx, al

    pop ebp
    ret

outw:
    push ebp
    mov ebp, esp

    mov eax, [ebp+12]
    mov edx, [ebp+8]
    out dx, ax

    pop ebp
    ret