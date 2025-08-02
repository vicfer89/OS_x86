ENTRY(_start)
OUTPUT_FORMAT(binary)
SECTIONS
{
    . = 1M; /* El kernel será cargado a partir del primer MB de memoria (dirección 0x100000 de inicio) */
    /* Seccion de codigo */
    .text : 
    {
        *(.text)
    }
    /*Sección para datos RO */
    .rodata : 
    {
        *(.rodata)
    }
    /* Sección de datos genérica */
    .data : 
    {
        *(.data)
    }
    /* Sección para datos no inicializados */
    .bss : 
    {
        *(COMMON)
        *(.bss)
    }
}
