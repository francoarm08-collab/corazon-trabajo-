
#!/bin/bash

BASE="$HOME/CORAZON"
ARCHIVO="$BASE/datos/infoClientes"

echo "================================"
echo "       MODIFICAR MIS DATOS"
echo "================================"
echo

if [ -n "$usuarioActual" ]; then
    usuario="$usuarioActual"
else
    read -p "Ingrese su usuario: " usuario
fi

if ! grep -q "^$usuario:" "$BASE/datos/clientes"; then
    echo "El usuario no existe o esta dado de baja."
    read -p "Presione ENTER para continuar..."
    exit
fi

linea=$(grep "^$usuario:" "$ARCHIVO" | head -n 1)

if [ -z "$linea" ]; then
    echo "No se encontraron los datos del cliente."
    read -p "Presione ENTER para continuar..."
    exit
fi

documento=$(echo "$linea" | cut -d ':' -f 2)
nombre=$(echo "$linea" | cut -d ':' -f 3)
direccion=$(echo "$linea" | cut -d ':' -f 4)
telefono=$(echo "$linea" | cut -d ':' -f 5)
conexion=$(echo "$linea" | cut -d ':' -f 6)
plan=$(echo "$linea" | cut -d ':' -f 7)
pago=$(echo "$linea" | cut -d ':' -f 8)

if [ -z "$documento" ] || [ -z "$nombre" ] || [ -z "$direccion" ] || [ -z "$telefono" ] || [ -z "$conexion" ] || [ -z "$plan" ] || [ -z "$pago" ]; then
    echo "La ficha del cliente tiene datos incompletos."
    echo "No se modifico nada."
    read -p "Presione ENTER para continuar..."
    exit
fi

echo "1. Modificar nombre completo"
echo "2. Modificar direccion"
echo "3. Modificar telefono"
echo "4. Modificar tipo de conexion"
echo "5. Modificar tipo de plan"
echo "6. Modificar medio de pago"

read -p "Seleccione una opcion: " opcion

case "$opcion" in
    1)
        read -p "Ingrese el nuevo nombre completo: " nombre
        nombre=$(echo "$nombre" | tr 'a-z' 'A-Z')
        ;;
    2)
        read -p "Ingrese la nueva direccion: " direccion
        direccion=$(echo "$direccion" | tr 'a-z' 'A-Z')
        ;;
    3)
        read -p "Ingrese el nuevo telefono: " telefono
        ;;
    4)
        echo "1. FIJO"
        echo "2. INALAMBRICO"
        read -p "Seleccione: " valor

        if [ "$valor" = "1" ]; then
            conexion="FIJO"
        elif [ "$valor" = "2" ]; then
            conexion="INALAMBRICO"
        else
            echo "Opcion incorrecta."
            read -p "Presione ENTER para continuar..."
            exit
        fi
        ;;
    5)
        echo "1. LIMITADO"
        echo "2. PLANO"
        read -p "Seleccione: " valor

        if [ "$valor" = "1" ]; then
            plan="LIMITADO"
        elif [ "$valor" = "2" ]; then
            plan="PLANO"
        else
            echo "Opcion incorrecta."
            read -p "Presione ENTER para continuar..."
            exit
        fi
        ;;
    6)
        echo "1. EFECTIVO"
        echo "2. CREDITO"
        read -p "Seleccione: " valor

        if [ "$valor" = "1" ]; then
            pago="EFECTIVO"
        elif [ "$valor" = "2" ]; then
            pago="CREDITO"
        else
            echo "Opcion incorrecta."
            read -p "Presione ENTER para continuar..."
            exit
        fi
        ;;
    *)
        echo "Opcion incorrecta."
        read -p "Presione ENTER para continuar..."
        exit
        ;;
esac

grep -v "^$usuario:" "$ARCHIVO" > "$BASE/datos/infoClientes.tmp"
echo "$usuario:$documento:$nombre:$direccion:$telefono:$conexion:$plan:$pago" >> "$BASE/datos/infoClientes.tmp"
mv "$BASE/datos/infoClientes.tmp" "$ARCHIVO"
chmod 600 "$ARCHIVO"

fecha=$(date "+%d/%m/%Y %H:%M:%S")
echo "$usuario:$fecha:MODIFICACION DE DATOS" >> "$BASE/datos/logClientes"

echo
echo "Los datos fueron actualizados."
read -p "Presione ENTER para continuar..."
