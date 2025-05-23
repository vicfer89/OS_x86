# Sistema opeativo para X86
Repo de curso para [SO x86 de Udemy](https://www.udemy.com/course/developing-a-multithreaded-kernel-from-scratch/)

## Enlaces de interés
1. Lista de interrupciones de Ralf Brown [Ralf Brown's Interrupt List](https://www.ctyme.com/rbrown.htm)
2. Wiki para desarrollo de sistemas operativos [OSDev.org](https://wiki.osdev.org/Expanded_Main_Page)
3. Instrucciones para x86 [x86 Assembly Lnaguage](https://en.wikipedia.org/wiki/X86_assembly_language)


## Generación de ISO para Virtual Box:
Creación de ISO desde .bin siguiendo tutorial de [Converting BIN to ISO](https://www.youtube.com/watch?v=QGE0fyH6I7A)
Necesarias las dependencias de _genisoimage_ para ejecutar _mkisofs_ (```sudo apt install genisoimage```)

Pasos a seguir:
1. Truncamos el fichero a 1200k: ```truncate boot.bin -s 1200k```
2. Generamos la iso con _mkisofs_: ```mkisofs -o os.iso -b boot.bin ./```

## Ejecución en GDB para QUEMU:
1. Lanzamos gdb en la consola ```gdb```
2. En GDB, lanzamos en remoto QUEMU redirigiendo la salida: ```target remote | qemu-system-x86_64 -hda ./boot.bin -S -gdb stdio```