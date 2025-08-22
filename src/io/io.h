/**
 * @file io.h
 * @author Vff
 * @brief Cabecera para manejo de IO
 */

#ifndef __IO_H__
#define __IO_H__

/**
 * @brief Función para leer byte de un puerto dado
 * 
 * @param [in] port puerto a leer
 * @return byte leido del puerto 
 */
unsigned char insb(unsigned short port);

/**
 * @brief Función para leer una palabra de un puerto dado
 * 
 * @param [in] port puerto a leer
 * @return palabra leida del puerto 
 */
unsigned short insw(unsigned short port);

/**
 * @brief Función para escribir un byte en un puerto dado
 * 
 * @param [in] port puerto a escribir 
 * @param [in] val valor para escribir en el puerto
 */
void outb(unsigned short port, unsigned char val);

/**
 * @brief Funcion para escribir una palabra en un puerto dado
 * 
 * @param [in] port puerto a escribir
 * @param [in] val valor para escribir en el puerto
 */
void outw(unsigned short port, unsigned short val);

#endif /* __IO_H__ */