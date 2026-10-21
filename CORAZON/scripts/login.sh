
#!/bin/bash

BASE="$HOME/CORAZON"

echo "================================"
echo "       SISTEMA CORAZON"
echo "================================"
echo

read -p "Ingrese su nombre de usuario: " usuario
read -s -p "Ingrese su clave de acceso: " contrasena
echo

if grep -q "^$usuario:$contrasena$" "$BASE/datos/admins"; then
    fecha=$(date "+%d/%m/%Y %H:%M:%S")
    echo "$usuario:$fecha:INICIO DE SESION" >> "$BASE/datos/logAdmins"

    echo
    echo "Acceso autorizado."
    echo "Bienvenido, administrador."

    export usuarioActual="$usuario"
    bash "$BASE/scripts/menuAdmin.sh"

elif grep -q "^$usuario:$contrasena$" "$BASE/datos/clientes"; then
    fecha=$(date "+%d/%m/%Y %H:%M:%S")
    echo "$usuario:$fecha:INICIO DE SESION" >> "$BASE/datos/logClientes"

    echo
    echo "Acceso autorizado."
    echo "Bienvenido, cliente."

    export usuarioActual="$usuario"
    bash "$BASE/scripts/menuCliente.sh"

else
    echo
    echo "Usuario o contraseña incorrectos."
fi

echo
read -p "Presione ENTER para finalizar..."

