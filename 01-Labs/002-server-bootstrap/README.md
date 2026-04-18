## Lab 002: Bootstrap básico de servidor.

Este script automatiza la preparacion inicial para preparar una distribucion de Ubuntu Desktop para desplegar un servidor web en Ngin.

Escencialmente se recomienda la ejecucion del mismo en una instalacion limpia, ya que el script continua con el siguiente flujo de trabajo. 

Auditoria: Realiza una auditoria inicial, creando un informe del sistema actual, el cual destaca que esta instalado y que no para que nos demos una idea del entorno en el que estamos.

Actualizaciones: Realiza la ejecucion completa de la actualizacion del sistema y actualiza la lista de paquetes disponibles y sus versiones desde los repositorios configgurados en el sistema.

Despliegue de servicios: Realiza el proceso de instalacion de los servicios basicos para el proposito principal:

- Nginx: Realiza la instalacion de Nginx para deplegar el servidor web en un futuro.

- SSH Server: La instalacion de la version servidor manualmente se debe a que requerimos que otros equipos se conecten al equipo.

## Seguridad

Dentro del flujo de trabajo del script se realiza la instalacion del SSH, tanto la version cliente (preinstalada), como la version servidor.

Sin embargo hay que aclarar que por motivos de seguridad esto se habilita inmediatamente, ya que el proposito de esto es tener acceso justo despues de la instalacion para prevenir el bloqueo del acceso remoto.

Adicional al esto no se habilita el puerto 443 ya que  no se tiene un certificado SSL aun.

## Versatilidad

Cuando los procesos rigurosos de instalacion y configuacion terminan, el script ejecuta una funcion propia para limpiar el sistema de paquetes sin usar u obsoletos para ahorrar el espacio en el disco.

## Verificacion

Al finalizar el proceso, el script realiza la impresion en pantalla de un reporte de la salud del sistema, donde se incluyen aspectos como el estado de nginx, tabla de puestos y version del S.O ademas del espacio libre en el disco.

Finalmente proporciona la ip para tenerla a mano y el enlace para conectarnos por ssh si lo requerimos seguidamente.


#==============================================================================
# VERSION 3.0
# Script: setup_server.sh
# Proposito: Automatizar la instalacion de Nginx y configurar el firewall
#
# NOTAS DE ACTUALIZACIONES
#
# 1. Aprendí condicionales y bucles basicos, asi que implementaré un verificador
# de fallos de comandos
# 2. Me percaté de que primero me interesa saber el estado base de mi entorno,
# así que agregué un reporte inicial
# 3. Añadí un comprobador de actualizaciones
# 4. Añadí un comprobador de espacio al inicio y al final de la limpieza para
# comprobar resultados
# 5. Añadí un reporte final del proceso con informacion valiosa para el usuario
#
# NOTA: A medida que aprenda más, ejecutare comandos con lo aprendido, ejecutando
# con pipes, y otras opciones más detalaldas y informacion filtrada
#
#==============================================================================

# Función para verificar si el comando anterior falló