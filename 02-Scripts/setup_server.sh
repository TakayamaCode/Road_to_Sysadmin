#!/bin/bash

#=======================================
# VERSION 1.0
# Script: setup_server.sh
# Proposito: Automatizar la instalacion de Nginx y configurar el firewall
#=========================================

echo "Iniciando la automatizacion.."

# 1. Actualizar el sistema

echo "Actualizando repositorios.."

sudo apt update
sudo apt upgrade -y


# 2. Instalacion de Nginx

echo "Instalando Nginx..."

sudo apt install nginx -y

#==============================================================================
# 3. Ahora configurare el firewall para que me permita abrir los puertos necesarios
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

#==============================================================================
# 4. Aquí me percate que si quiero aprender a conectarme por SSH tengo que abrir 
# también el puerto 22, además si no lo configuro ahora, tendria que reiniciar
# la maquina para poder volver a entrar , por que el firewall no me dejaria 
# establecer una conexion
#==============================================================================

echo "Permitir conexion SSH con OpenSSH..."

sudo ufw allow OpenSSH

# 5. Activar el firewall

echo "Activando el firewall..."

sudo ufw enable

# 6. Verificacion de todo

echo "Verificando instalaciones...."

apt list --upgradable
which nginx
nginx -v
sudo systemctl status nginx
sudo ufw status

# 7. Hare una limpieza debido a que si acabo de instalar el S.O y todas las 
# dependencias y repositorios o programas, mantendré todo limpio y ahorraré 
# recursos

echo "Limpiando paquetes innecesarios..."

sudo apt autoremove -y
sudo apt autoclean
sudo apt clean


# 8. Mensaje final...

echo "Proceso de instalacion terminado."



