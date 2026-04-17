# Lab 001: Preparación inicial del entorno

## Problema
Cada vez que reinstalo Ubuntu, debo configurar manualmente el sistema base, lo que comunmente son las configuraciones de actualizaciones, paquetes y actualizacion de listas de paquetes, para empezar a usar el entorno.

## Diagnóstico
La configuración manual es repetitiva y consume tiempo, además de ser propensa a omitir herramientas esenciales, o omitir actualizaciones del sistema que pueden dejar vulnerable mi maquina desde un principio.

## Solución
Se creó un script en Bash para automatizar:
- Actualización del sistema
- Instalación de herramientas básicas (git, curl, vim)

## Ejecución
chmod +x setup.sh
./setup.sh

## Aprendizaje
- Ejecución de scripts en Bash
- Uso de permisos (chmod)
- Automatización de tareas básicas

## Relación con siguientes labs
Este script sirve como base para ejecutar configuraciones más avanzadas en los siguientes laboratorios.