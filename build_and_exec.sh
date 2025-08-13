#!/bin/bash

BINDIR=bin
BUILDIR=build

# Comprobamos is no existe el directorio de binarios, y lo creamos
if [ ! -d "$BINDIR" ]; then
  echo "$BINDIR no existe, creando directorio..."
  mkdir $BINDIR
fi

# Comprobamos is no existe el directorio de build, y lo creamos
if [ ! -d "$BUILDIR" ]; then
  echo "$BUILDIR no existe, creando directorio..."
  mkdir $BUILDIR
fi

make clean && ./build.sh && qemu-system-x86_64 -hda ./bin/os.bin