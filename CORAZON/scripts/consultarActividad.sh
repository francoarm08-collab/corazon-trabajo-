#!/bin/bash

BASE="$HOME/CORAZON"

echo "===== REGISTRO DE ACTIVIDAD ====="
echo
echo "1. Actividad de administradores"
echo "2. Actividad de clientes"
read -p "Seleccione una opcion: " opcion

case "$opcion" in
    1)
        ARCHIVO="$BASE/datos/logAdmins"
        ;;
    2)
        ARCHIVO="$BASE/datos/logClientes"
        ;;
    *)
        echo "La opcion ingresada no es valida."
        read -p "Presione ENTER para continuar..."
        exit
        ;;
esac

echo
read -p "Ingrese el nombre de usuario: " usuario

echo
echo "===== ACTIVIDAD DE $usuario ====="

if grep -q "^$usuario:" "$ARCHIVO"; then
    grep "^$usuario:" "$ARCHIVO" | awk -F ':' '{
        split($2, fecha, " ")
        split(fecha[1], f, "/")
        split(fecha[2], h, ":")
        print f[3] f[2] f[1] h[1] h[2] h[3] "|" $0
    }' | sort -r | cut -d '|' -f 2-
else
    echo "No hay registros para ese usuario."
fi

echo
read -p "Presione ENTER para continuar..."
