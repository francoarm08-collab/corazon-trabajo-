#!/bin/bash

BASE="$HOME/CORAZON"

mkdir -p "$BASE/datos"
mkdir -p "$BASE/dirUsuarios"
mkdir -p "$BASE/scripts"

touch "$BASE/datos/clientes"
touch "$BASE/datos/admins"
touch "$BASE/datos/infoClientes"
touch "$BASE/datos/infoEmpleados"
touch "$BASE/datos/bajaClientes"
touch "$BASE/datos/logClientes"
touch "$BASE/datos/logAdmins"

if [ ! -s "$BASE/datos/admins" ]; then
    echo "admin:admin123" >> "$BASE/datos/admins"
    echo "1:ADMIN:INICIAL:00000000" >> "$BASE/datos/infoEmpleados"
    echo "Administrador inicial creado."
    echo "Usuario: admin"
    echo "Contrasena: admin123"
fi

chmod 700 "$BASE/datos"
chmod 700 "$BASE/dirUsuarios"
chmod 755 "$BASE/scripts"
chmod 600 "$BASE/datos/"*
chmod +x "$BASE/scripts/"*.sh

echo "Sistema CORAZON instalado correctamente."
