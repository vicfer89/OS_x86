ENTRY(_start)
OUTPUT_FORMAT(binary)
SECTIONS
{
    . = 1M; /* El kernel será cargado a partir del primer MB de memoria (dirección 0x100000 de inicio) */
    /* Seccion de codigo */
    .text : ALIGN(4096)
    {
        *(.text)
    }
    /*Sección para datos RO */
    .rodata : ALIGN(4096)
    {
        *(.rodata)
    }
    /* Sección de datos genérica */
    .data : ALIGN(4096)
    {
        *(.data)
    }
    /* Sección para datos no inicializados */
    .bss : ALIGN(4096)
    {
        *(COMMON)
        *(.bss)
    }

    .asm :
    {
        *(.asm)
    }
}
