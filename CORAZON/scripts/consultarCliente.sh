
#!/bin/bash

BASE="$HOME/CORAZON"
ARCHIVO="$BASE/datos/infoClientes"

echo "===== CONSULTA DE CLIENTES ====="
echo

if grep -q "^$usuarioActual:" "$BASE/datos/admins"; then
    read -p "Ingrese el usuario del cliente: " usuario
else
    usuario="$usuarioActual"
fi

if ! grep -q "^$usuario:" "$ARCHIVO"; then
    echo "No se encontraron los datos del cliente."
    read -p "Presione ENTER para continuar..."
    exit
fi

echo
echo "1. Mostrar todos los datos"
echo "2. Mostrar un dato especifico"
read -p "Seleccione una opcion: " opcion

case "$opcion" in
    1)
        grep "^$usuario:" "$ARCHIVO"
        ;;
    2)
        echo
        echo "1. Documento"
        echo "2. Nombre completo"
        echo "3. Direccion"
        echo "4. Telefono"
        echo "5. Tipo de conexion"
        echo "6. Tipo de plan"
        echo "7. Medio de pago"
        read -p "Que dato desea consultar: " dato

        case "$dato" in
            1) campo=2 ;;
            2) campo=3 ;;
            3) campo=4 ;;
            4) campo=5 ;;
            5) campo=6 ;;
            6) campo=7 ;;
            7) campo=8 ;;
            *)
                echo "Opcion incorrecta."
                read -p "Presione ENTER para continuar..."
                exit
                ;;
        esac

        grep "^$usuario:" "$ARCHIVO" | cut -d ':' -f "$campo"
        ;;
    *)
        echo "Opcion incorrecta."
        ;;
esac

echo
read -p "Presione ENTER para continuar..."

