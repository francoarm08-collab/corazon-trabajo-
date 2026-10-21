
#!/bin/bash

BASE="$HOME/CORAZON"
ARCHIVO="$BASE/datos/infoClientes"

echo "================================"
echo "     ESTADISTICAS CORAZON"
echo "================================"
echo

if [ ! -s "$ARCHIVO" ]; then
    echo "Todavia no hay clientes registrados."
    read -p "Presione ENTER para continuar..."
    exit
fi

echo "----- TIPO DE CONEXION -----"

fijo=$(cut -d ':' -f 6 "$ARCHIVO" | grep -cx "FIJO")
inalambrico=$(cut -d ':' -f 6 "$ARCHIVO" | grep -cx "INALAMBRICO")

echo "Clientes con conexion fija: $fijo"
echo "Clientes con conexion inalambrica: $inalambrico"

echo
echo "----- TIPO DE PLAN -----"

limitado=$(cut -d ':' -f 7 "$ARCHIVO" | grep -cx "LIMITADO")
plano=$(cut -d ':' -f 7 "$ARCHIVO" | grep -cx "PLANO")

echo "Clientes con plan limitado: $limitado"
echo "Clientes con plan plano: $plano"

echo
echo "----- MEDIO DE PAGO -----"

efectivo=$(cut -d ':' -f 8 "$ARCHIVO" | grep -cx "EFECTIVO")
credito=$(cut -d ':' -f 8 "$ARCHIVO" | grep -cx "CREDITO")

echo "Clientes que pagan en efectivo: $efectivo"
echo "Clientes que pagan con credito: $credito"

echo
read -p "Presione ENTER para continuar..."
