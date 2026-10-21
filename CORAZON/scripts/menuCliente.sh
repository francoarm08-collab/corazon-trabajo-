
#!/bin/bash

BASE="$HOME/CORAZON"
opcion=0

while [ "$opcion" != "3" ]
do
    clear

    echo "================================"
    echo "          MENU DE CLIENTE"
    echo "================================"
    echo "1. Consultar mis datos"
    echo "2. Modificar mis datos"
    echo "3. Cerrar sesion"
    echo

    read -p "Seleccione una opcion: " opcion

    case "$opcion" in
        1)
            bash "$BASE/scripts/consultarCliente.sh"
            ;;
        2)
            bash "$BASE/scripts/modificarCliente.sh"
            ;;
        3)
            echo "Sesion finalizada."
            ;;
        *)
            echo "Opcion incorrecta."
            read -p "Presione ENTER para continuar..."
            ;;
    esac
done
