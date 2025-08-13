/**
 * @file memory.h
 * @author Vff
 * @brief Cabecera para manejo de memoria
 */

#ifndef __MEMORY_H__
#define __MEMORY_H__

#include <stddef.h>

/**
 * @brief Funcion para setear memoria a un valor dado
 * 
 * @param [in] ptr Puntero a dirección de memoria a setear
 * @param [in] c Valor a setear en memoria 
 * @param [in] size Tamaño de memoria a setear 
 * @return void* Puntero a memoria seteada
 */
void * memset(void *ptr, int c, size_t size);

#endif