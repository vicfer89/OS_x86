/**
 * @file kernel.h
 * @author Vff
 * @brief Fichero para kernel de prueba de OS
 */

#ifndef __KERNEL_H__
#define __KERNEL_H__

#define VIDEO_MEMORY_ASCII_START_ADDR 0xB8000
#define VGA_WIDTH  80
#define VGA_HEIGHT 20

/**
 * @brief Función de entrada de Kernel
 * 
 */
void kernel_main();

/**
 * @brief Imprime a nivel de kernel
 * 
 * @param [in] str Cadena a imprimir por pantalla 
 */
void printk(const char* str);

#endif