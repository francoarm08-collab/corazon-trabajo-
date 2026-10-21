
#!/bin/bash

BASE="$HOME/CORAZON"

echo "===== ALTA DE CLIENTES ====="
echo

read -p "Nombre: " nombre
read -p "Apellido: " apellido
read -p "Documento: " documento
read -p "Direccion: " direccion
read -p "Telefono: " telefono

if [ -z "$nombre" ] || [ -z "$apellido" ] || [ -z "$documento" ] || [ -z "$direccion" ] || [ -z "$telefono" ]; then
    echo "Todos los campos son obligatorios."
    exit
fi

echo
echo "Tipo de conexion:"
echo "1. Fijo"
echo "2. Inalambrico"
read -p "Seleccione: " conexion

echo
echo "Tipo de plan:"
echo "1. Limitado"
echo "2. Plano"
read -p "Seleccione: " plan

echo
echo "Medio de pago:"
echo "1. Efectivo"
echo "2. Credito"
read -p "Seleccione: " pago

nombre=$(echo "$nombre" | tr 'a-z' 'A-Z')
apellido=$(echo "$apellido" | tr 'a-z' 'A-Z')
direccion=$(echo "$direccion" | tr 'a-z' 'A-Z')

if [ "$conexion" = "1" ]; then
    conexion="FIJO"
elif [ "$conexion" = "2" ]; then
    conexion="INALAMBRICO"
else
    echo "Tipo de conexion incorrecto."
    exit
fi

if [ "$plan" = "1" ]; then
    plan="LIMITADO"
elif [ "$plan" = "2" ]; then
    plan="PLANO"
else
    echo "Tipo de plan incorrecto."
    exit
fi

if [ "$pago" = "1" ]; then
    pago="EFECTIVO"
elif [ "$pago" = "2" ]; then
    pago="CREDITO"
else
    echo "Medio de pago incorrecto."
    exit
fi

usuario=$(echo "$nombre" | cut -c1 | tr 'A-Z' 'a-z')
usuario="${usuario}$(echo "$apellido" | tr 'A-Z' 'a-z')"
contrasena="${usuario}123"

if grep -q "^$usuario:" "$BASE/datos/clientes" || grep -q "^$usuario:" "$BASE/datos/bajaClientes"; then
    echo "Ese usuario ya existe o fue dado de baja."
    exit
fi

echo "$usuario:$contrasena" >> "$BASE/datos/clientes"
echo "$usuario:$documento:$nombre $apellido:$direccion:$telefono:$conexion:$plan:$pago" >> "$BASE/datos/infoClientes"

mkdir -p "$BASE/dirUsuarios/$usuario"

echo
echo "Cliente registrado correctamente."
echo "Usuario asignado: $usuario"
echo "Contrasena asignada: $contrasena"

fecha=$(date "+%d/%m/%Y %H:%M:%S")
echo "${usuarioActual:-admin}:$fecha:ALTA DE CLIENTE $usuario" >> "$BASE/datos/logAdmins"
