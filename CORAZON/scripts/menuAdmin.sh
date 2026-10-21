
#!/bin/bash

BASE="$HOME/CORAZON"
opcion=0

while [ "$opcion" != "7" ]
do
    clear

    echo "================================"
    echo "     ADMINISTRACION CORAZON"
    echo "================================"
    echo "1. Registrar un administrador"
    echo "2. Dar de alta un cliente"
    echo "3. Dar de baja un cliente"
    echo "4. Consultar clientes"
    echo "5. Consultar actividad"
    echo "6. Ver estadisticas"
    echo "7. Cerrar sesion"
    echo

    read -p "Seleccione una opcion: " opcion

    case "$opcion" in
        1)
            bash "$BASE/scripts/altaAdmin.sh"
            read -p "Presione ENTER para volver al menu..."
            ;;
        2)
            bash "$BASE/scripts/altaClientes.sh"
            read -p "Presione ENTER para volver al menu..."
            ;;
        3)
            bash "$BASE/scripts/bajaClientes.sh"
            ;;
        4)
            echo "1. Listar clientes"
            echo "2. Consultar un cliente"
            read -p "Seleccione una opcion: " consulta

            if [ "$consulta" = "1" ]; then
                bash "$BASE/scripts/listarClientes.sh"
            elif [ "$consulta" = "2" ]; then
                bash "$BASE/scripts/consultarCliente.sh"
            else
                echo "Opcion incorrecta."
                read -p "Presione ENTER para continuar..."
            fi
            ;;
        5)
            bash "$BASE/scripts/consultarActividad.sh"
            ;;
        6)
            bash "$BASE/scripts/estadisticas.sh"
            ;;
        7)
            echo "Sesion de administrador finalizada."
            ;;
        *)
            echo "Esa opcion no existe."
            read -p "Presione ENTER para intentar de nuevo..."
            ;;
    esac
done
