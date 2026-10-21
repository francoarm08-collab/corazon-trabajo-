
#!/bin/bash

BASE="$HOME/CORAZON"
CLIENTES="$BASE/datos/clientes"
INFO="$BASE/datos/infoClientes"
BAJAS="$BASE/datos/bajaClientes"

echo "================================"
echo "       BAJA DE CLIENTES"
echo "================================"
echo

read -p "Ingrese el usuario del cliente: " usuario

if ! grep -q "^$usuario:" "$CLIENTES"; then
    echo "No se encontro un cliente activo con ese usuario."
    read -p "Presione ENTER para continuar..."
    exit
fi

if grep -q "^$usuario:" "$INFO"; then
    grep "^$usuario:" "$INFO" >> "$BAJAS"

    grep -v "^$usuario:" "$INFO" > "$BASE/datos/infoClientes.tmp"
    mv "$BASE/datos/infoClientes.tmp" "$INFO"
fi

grep -v "^$usuario:" "$CLIENTES" > "$BASE/datos/clientes.tmp"
mv "$BASE/datos/clientes.tmp" "$CLIENTES"

if [ -d "$BASE/dirUsuarios/$usuario" ]; then
    rm -r "$BASE/dirUsuarios/$usuario"
fi

fecha=$(date "+%d/%m/%Y %H:%M:%S")

if [ -n "$usuarioActual" ]; then
    echo "$usuarioActual:$fecha:BAJA DE CLIENTE $usuario" >> "$BASE/datos/logAdmins"
else
    echo "admin:$fecha:BAJA DE CLIENTE $usuario" >> "$BASE/datos/logAdmins"
fi

echo
echo "El cliente fue dado de baja correctamente."

read -p "Presione ENTER para continuar..."
