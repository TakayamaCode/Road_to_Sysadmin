#!/bin/bash

echo "Actualizando sistema..."
sudo apt update && sudo apt upgrade -y

echo "Instalando herramientas base"
sudo apt install -y git curl vim

echo "Entorno base listo!"