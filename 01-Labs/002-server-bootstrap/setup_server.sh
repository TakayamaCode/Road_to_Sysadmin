#!/bin/bash

#==============================================================================
#
# SCRIPT: setup_server.sh
# VERSION 4.0
# DESCRIPCION: Bootstrap inicial para Ubuntu Desktop () 
# AUTOR: Brayan Nicolas Barrera Monroy - TakayamaCode
#
#==============================================================================

# Función para verificar si el comando anterior falló

verificar() {
    
    if [ $? -eq 0 ]; then
        echo "Paso completado con éxito."
    else
        echo "ERROR: Algo salió mal en este punto. Abortando..."
        exit 1
    fi
}

#==============================================================================
# 1. REPORTE INICIAL DETALLADO (Versión 4)
#==============================================================================
echo "========================================================================="
echo "                          REPORTE DE INICIO                           "
echo "========================================================================="

# Informacion basica del sistema
# Se ha agrupado la mayoria de la informacion a reportar, se usa awk para filtrar y
# obtener solo la informacion necesaria para el reporte, y se formatea el texto para
# una experiencia de usuario final mas amena y claridad de lectura

echo " [+] Identidad del Sistema: "
echo "Fecha y hora: $(date +"%Y-%m-%d %T")"
hostnamectl | awk -F': ' '
/Operating System/ {os=$2} 
/Kernel/           {k=$2} 
/Architecture/     {a=$2} 
/Static hostname/  {h=$2} 
/Hardware Model/   {hm=$2} 
/Virtualization/   {v=$2} 
END {
    printf "%-18s %s\n", "S.O:", os;
    printf "%-18s %s\n", "Kernel:", k;
    printf "%-18s %s\n", "Arquitectura:", a;
    printf "%-18s %s\n", "Hostname:", h;
    printf "%-18s %s\n", "Modelo:", hm;
    printf "%-18s %s\n", "Virtualizacion:", v;
}'
echo "IP Local:     $(hostname -I | awk '{print $1}')"
# Recursos
echo "--- Recursos ---"
echo "Ram libre:    $(free -h | awk '/^Mem:/ {print $4 } " de " $2')"
echo "Disco libre:  $(dh -f | awk '/^\/dev/ {print $4 " de " $2 " %-Uso: " $5}')"
echo "Tiempo activo:    $(uptime -p)"
# 
echo "---------------------------"

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
verificar


# 4. Instalacion de Nginx

echo "Instalando Nginx..."

sudo apt install nginx -y
verificar

#==============================================================================
# 5. Ahora configurare el firewall para que me permita abrir los puertos necesarios
# para usar nginx. Usaré Nginx full, esto abrirá por defecto los siguientes 
# puertos:
#
# Puerto 80: Para tráfico HTTP (sin cifrar).
# Puerto 443: Para tráfico HTTPS (seguro/cifrado con SSL)
#
# NOTA: Me documentaré mejor por si hay buenas practicas para esto y haré una 
# segunda version. dejo abierto 443 para un posible certificado SSL
#==============================================================================

echo "Configurando el firewall.."

sudo ufw allow 'Nginx Full'
verificar

#==============================================================================
# 6. Aquí me percate que si quiero aprender a conectarme por SSH tengo que abrir 
# también el puerto 22, además si no lo configuro ahora, tendria que reiniciar
# la maquina para poder volver a entrar , por que el firewall no me dejaria 
# establecer una conexion
#==============================================================================

echo "Permitir conexion SSH con OpenSSH..."

sudo ufw allow OpenSSH
verificar

# 7. Activar el firewall

echo "Activando el firewall..."

sudo ufw enable
verificar

# 8.Actualizando reglas

echo "Actualizando reglas de firewall..."

sudo ufw reload

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
verificar

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



