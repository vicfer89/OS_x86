/**
 * @file idt.h
 * @author Vff
 * @brief Fichero para manejo de interrupciones
 */

#ifndef __IDT_H__
#define __IDT_H__

#include <stdint.h>

#define OFFSET_1_MASK 0x0000FFFFU /**< Máscara para offset 1 en idt */
#define OFFSET_2_DISPLACEMENT 16U /**< Bits de desplazamiento para offset 2 */  
#define OFFSET_2_MASK 0xFFFF0000U /**< Máscara para offset 2 en idt */

/**
 * @brief Descriptor para IDT (Interrupt Descriptor Table)
 */
struct idt_desc
{
    uint16_t offset_1; // Offset bits 0 - 15
    uint16_t selector; // Selector que está en nuestro GDT
    uint8_t zero;      // Sin uso
    uint8_t type_arr;  // Descriptor de tipo y atributos
    uint16_t offset_2; // Boffset bits 16 - 31
} __attribute__((packed));

/**
 * @brief Descriptor para registro de IDT (Interrupt Descriptor Table Register)
 */
struct idtr_desc
{
    uint16_t limit; // Tamaño de la tabla de descriptores -1
    uint32_t base;  // Dirección base del comienzo de tabla de descripción de interrupciones
}__attribute__((packed));

/**
 * @brief Inicializa la Interrupt Descriptr Table (idt)
 */
void idt_init();

#endif /* __IDT_H__ */