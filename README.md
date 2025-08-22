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

## Ejecución en GDB para QEMU:
1. Lanzamos gdb en la consola ```gdb```
2. En GDB, lanzamos en remoto QEMU redirigiendo la salida: ```target remote | qemu-system-x86_64 -hda ./boot.bin -S -gdb stdio```

### Ejecución en GDB para sistema completo
1. Lanzamos gdb en la consola ```gdb```, a partir de ahora todo estará en la consola de GDB
2. Cargamos los simbolos de depuración ```add-symbol-file ../build/kernelfull.o 0x100000```
3. Pulsamos ```y``` para leer los símbolos cuando se solicite
4. Ponemos un breakpoint en el comienzo por medio de ```break _start```
5. Lanzamos QEMU, redirigiendo la salida ```target remote | qemu-system-x86_64 -S -gdb stdio -hda ./os.bin```
6. Podemos continuar la ejecución por medio de ```c```, lanzar el depurador de asm por medio de ```layout asm``` e ir instrucción a instrucción por medio de ```stepi```
para comprobar que se ha podido lanzar de forma correcta.

## Generación de documentación:
El proyecto incluye el fichero *Doxyfile* con información para doxygen. Para generarlo, necesita que Doxygen esté instalado mediante ```sudo apt-get install doxygen```, pudiendo generar documentación en html para el proyecto ejecutando ```doxygen``` en la carpeta raiz del mismo.