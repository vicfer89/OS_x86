/**
 * @file idt.c
 * @author Vff
 * @brief Fichero para manejo de interrupciones
 */

#include "idt.h"
#include "config.h"
#include "memory.h"
#include "kernel.h"

struct idt_desc idt_descriptors[PEACHOS_TOTAL_INTERRUPTS];
struct idtr_desc idtr_descriptor;

/**
 * @brief Carga la tabla idt en memoria, empleando idt.asm para ello
 * 
 * @param [in] ptr puntero para registro de descriptores de interrupciones 
 */
extern void idt_load(struct idtr_desc* ptr);

/**
 * @brief Manejador para interrupción de división por cero (interrupt_no = 0)
 * 
 */
static void idt_zero()
{
    printk("Error de division por cero\n");
}

/**
 * @brief Establece un descriptor de interrupción
 * 
 * @param [in] interrupt_no Número de interrpción a configurar
 * @param [in] address Dirección de la interrupción
 */
static void idt_set(int interrupt_no, void* address)
{
    struct idt_desc* desc = &idt_descriptors[interrupt_no];
    desc->offset_1 = (uint16_t) ((uint32_t) address & OFFSET_1_MASK);
    desc->selector = KERNEL_CODE_SELECTOR;
    desc->zero = 0x00U; // Se puede omitir, pero es una buena práctica ponerlo
    desc->type_arr = 0xEE; // Corresponde a Type = 0xE (80386 32-bit interrupt gate), 
                           // S = 0 (interupt and trap gate), DPL = 3 (Nivel de privilego 3), P = 1 (Presente)
    desc->offset_2 = (uint16_t) (((uint32_t) address & OFFSET_2_MASK) >> OFFSET_2_DISPLACEMENT);
}

void idt_init()
{
    memset(idt_descriptors, 0, sizeof(idt_descriptors));
    idtr_descriptor.limit = sizeof(idt_descriptors) - 1;
    idtr_descriptor.base = (uint32_t) idt_descriptors;

    idt_set(0, idt_zero);

    idt_load(&idtr_descriptor);
}
