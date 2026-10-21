
#!/bin/bash

BASE="$HOME/CORAZON"

echo "================================"
echo "       LISTADO DE CLIENTES"
echo "================================"
echo

echo "----- CLIENTES ACTIVOS -----"

if [ -s "$BASE/datos/infoClientes" ]; then
    cut -d ':' -f 1,2,3 "$BASE/datos/infoClientes" | sort
else
    echo "No hay clientes activos."
fi

echo
echo "----- CLIENTES INACTIVOS -----"

if [ -s "$BASE/datos/bajaClientes" ]; then
    cut -d ':' -f 1,2,3 "$BASE/datos/bajaClientes" | sort
else
    echo "No hay clientes inactivos."
fi

echo
read -p "Presione ENTER para continuar..."
