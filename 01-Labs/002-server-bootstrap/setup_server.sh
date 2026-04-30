#!/bin/bash

#==============================================================================
#
# SCRIPT: setup_server.sh
# VERSION: 4.0.0
# DESCRIPCION: Ubuntu Desktop - Auditor inicial del sistema (Lab 002).
# AUTOR: Brayan Nicolas Barrera Monroy - TakayamaCode
# FECHA: 2026-04-24
#
#==============================================================================
# Modo estricto de Bash

set -euo pipefail

#Validacion de usuario root 

if [ "$EUID" -eq 0 ]; then

#==============================================================================
# 1. REPORTE INICIAL
#==============================================================================

echo "========================================================================="
echo "                          REPORTE DE INICIO                              "
echo "========================================================================="

# Informacion basica del sistema
# Se ha agrupado la mayoria de la informacion a reportar, se usa awk para filtrar y
# obtener solo la informacion necesaria para el reporte, y se formatea el texto para
# una experiencia de usuario final mas amena y claridad de lectura

echo "||  "
echo -e "||    [+] Identidad del Sistema: "
echo "||  " 
echo "-------------------------------------------------------------------------"
echo "||  " 
ip_local=$(hostname -I | awk '{print $1}')
fecha_actual=$(date +"%Y-%m-%d %T")
usuario=$(whoami)
disco=$(df -h | awk '$NF == "/" {print $3 " de " $2 " ( | Disponible: " $4 ")" }')
ram=$(free -h | awk '/^Mem:/ {print $3 " de " $2 " (Libre: " $4 ")"}')
up=$(uptime -p | sed 's/up //')

hostnamectl | awk -v d="$fecha_actual" -v ip="$ip_local" -v u="$usuario" -F': ' '
/Operating System/ {os=$2} 
/Kernel/           {k=$2} 
/Architecture/     {a=$2} 
/Static hostname/  {h=$2} 
/Hardware Model/   {hm=$2} 
/Virtualization/   {v=$2} 
END {
    printf "%-22s %s\n", "|| Fecha y hora:", d;
    printf "%-22s %s\n", "|| Usuario actual:", u;
    printf "%-22s %s\n", "|| Hostname:", h;
    printf "%-22s %s\n", "|| IP Local:", ip;
    printf "%-22s %s\n", "|| S.O:", os;
    printf "%-22s %s\n", "|| Kernel:", k;
    printf "%-22s %s\n", "|| Arquitectura:", a;
    printf "%-22s %s\n", "|| Modelo:", hm;
    printf "%-22s %s\n", "|| Virtualizacion:", (v ? v : "Physical");
}'
echo "||  " 
# Recursos
echo "-------------------------------------------------------------------------" 
echo "||  " 
echo -e "||     [+] Estado de recursos: "
echo "||  " 
echo "-------------------------------------------------------------------------"
echo "||  " 
awk -v disco="$disco" -v ram="$ram" -v up="$up" 'BEGIN {
    printf "%-22s %s\n", "|| Espacio en disco:", disco;
    printf "%-22s %s\n", "|| Memoria Ram:", ram;
    printf "%-22s %s\n", "|| Tiempo encendido:", up;
}' 
echo "||  " 
echo "---------------------------"

else
    # Si no es root, solo imprime el error y NO hace nada más
    echo "Error: Este script debe ejecutarse con privilegios de root."
    echo "Saliendo..." >&2
fi

# 2. Quiero primero comprobar actualizaciones para decidir o no instalar

echo "1. Verificando Actualizaciones..."

sudo apt update
apt list --upgradable

echo "✅ Repositorios consultados."

echo "Iniciando la automatizacion.."

# 3. Actualizar el sistema

echo "Actualizando repositorios.."

sudo apt update
sudo apt upgrade -y


# 9. Verificacion de todo

echo "Verificando instalaciones...."

# Añadí verificaiones mas visualmente
# Verificacion del S.O
# Actualizar nuevamente el índice local de paquetes

echo " --- Sistema operativo --- "

hostnamectl
sudo apt update -y
apt list --upgradable

echo " --- Salud de Nginx ---"

# Eliminacion de comando menos detallado 
# sudo systemctl is-active nginx

which nginx
nginx -v
sudo systemctl status nginx


# Vamos a verificar el firewall 

echo "--- Estado de firewall ---"

sudo ufw status

# Verificare los puertos 

echo " --- Puertos abiertos en el Firewall ---"

sudo ufw status numbered

echo " --- Estado de los puertos ---"

sudo ss -tunlp

# 7. Hare una limpieza debido a que si acabo de instalar el S.O y todas las 
# dependencias y repositorios o programas, mantendré todo limpio y ahorraré 
# recursos

echo "--- Espacio de disco actual ---"

df -h 

echo "Limpiando paquetes innecesarios..."

sudo apt autoremove -y


sudo apt autoclean

sudo apt clean

echo "--- Espacio de disco con proceso de limpieza ---"

df -h

# 8. Mensaje final...

echo "----------------------------------"
echo "Proceso de instalacion terminado."
echo ""
echo "IP del servidor Nginx"
echo ""
hostname -I
echo ""
echo "URL Local para probar:
http://$(hostname -I | awk '{print $1}')"
echo "----------------------------------"



