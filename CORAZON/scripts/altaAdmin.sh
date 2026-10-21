
#!/bin/bash

BASE="$HOME/CORAZON"
ARCHIVO="$BASE/datos/admins"
INFO="$BASE/datos/infoEmpleados"

if [ ! -s "$ARCHIVO" ]; then
    echo "admin:admin123" >> "$ARCHIVO"
    echo "1:ADMIN:INICIAL:00000000" >> "$INFO"
    echo "Administrador inicial creado"
    echo "Usuario: admin"
    echo "Contrasena: admin123"
    exit
fi

echo "===== ALTA DE ADMINISTRADOR ====="
echo

read -p "Nombre: " nombre
read -p "Apellido: " apellido
read -p "Documento: " documento
read -p "Numero de empleado: " numero

nombre=$(echo "$nombre" | tr 'a-z' 'A-Z')
apellido=$(echo "$apellido" | tr 'a-z' 'A-Z')

if [ -z "$nombre" ] || [ -z "$apellido" ] || [ -z "$documento" ] || [ -z "$numero" ]; then
    echo "Todos los campos son obligatorios."
    exit
fi

if grep -q "^$numero:" "$INFO"; then
    echo "Ese numero de empleado ya existe."
    exit
fi

usuario=$(echo "$nombre" | cut -c1 | tr 'A-Z' 'a-z')
usuario="${usuario}$(echo "$apellido" | tr 'A-Z' 'a-z')"

if grep -q "^$usuario:" "$ARCHIVO"; then
    echo "Ese usuario ya existe. No se registro el administrador."
    exit
fi

contrasena="${usuario}123"

echo "$usuario:$contrasena" >> "$ARCHIVO"
echo "$numero:$nombre:$apellido:$documento" >> "$INFO"

echo
echo "Administrador creado correctamente."
echo "Usuario: $usuario"
echo "Contrasena: $contrasena"
