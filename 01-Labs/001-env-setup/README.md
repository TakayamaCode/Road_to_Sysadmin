# Lab 001: Preparación inicial del entorno

## Problema
Cada vez que reinstalo Ubuntu, debo configurar manualmente el sistema base para empezar a trabajar.

## Diagnóstico
La configuración manual es repetitiva y consume tiempo, además de ser propensa a omitir herramientas esenciales.

## Solución
Se creó un script en Bash para automatizar:
- Actualización del sistema
- Instalación de herramientas básicas (git, curl, vim)

## Ejecución
chmod +x setup.sh
./setup.sh

## Aprendizajes
- Ejecución de scripts en Bash
- Uso de permisos (chmod)
- Automatización de tareas básicas

## Relación con siguientes labs
Este script sirve como base para ejecutar configuraciones más avanzadas en los siguientes laboratorios.