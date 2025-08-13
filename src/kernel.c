/**
 * @file kernel.c
 * @author Vff
 * @brief Fichero para kernel de prueba de OS
 */

#include "kernel.h"
#include "idt.h"

#include <stdint.h>
#include <stddef.h>

extern void problem();
extern void call_int_nr();

uint16_t* video_mem = 0;

uint16_t terminal_make_char(char c, char colour)
{
    return (colour << 8) | c;
}

size_t strlen(const char* str)
{
    size_t len = 0;
    while(str[len])
    {
        len++;
    }
    return len;
}

void terminal_putchar(int x, int y, char c, char colour)
{
    video_mem[(y * VGA_WIDTH) + x] = terminal_make_char(c, colour);
}

void terminal_write_char(char c, char colour)
{
    static int terminal_row = 0;
    static int terminal_col = 0;

    if(c == '\r') // Retorno de carro
    {
        terminal_col = 0;
        return;
    }

    if(c == '\n') // Caracter de nueva línea
    {
        terminal_row++;
        terminal_col = 0;
        return;
    }

    terminal_putchar(terminal_col, terminal_row, c, colour);
    terminal_col++;
    if(terminal_col >= VGA_WIDTH)
    {
        terminal_row++;
        terminal_col = 0;
    }
}

void terminal_initalize()
{
    video_mem = (uint16_t*) VIDEO_MEMORY_ASCII_START_ADDR;
    for(int y = 0; y < VGA_HEIGHT; y++)
    {
        for(int x = 0; x < VGA_WIDTH; x++)
        {
            terminal_putchar(x, y, ' ', 0);
        }
    }
}

void printk(const char* str)
{
    size_t len = strlen(str);
    for(int i = 0; i < len; i++)
    {
        terminal_write_char(str[i], 15);
    }
}

void kernel_main()
{
    terminal_initalize();
    printk("Hola mundo\nEsto es una prueba\n");

    // Inicializa la tabla de descriptor de interrupciones
    idt_init();

    // [TEST LECCION 12] - Inyecta un error definido en kernel.asm para probar la división por cero
    //problem();

    // [TEST LECCION 12] - Llamada a interrupción 0
    //call_int_nr();
}