
# COMPRESION Y DESCOMPRESION

Para crear archivos comprimidos tenemos que ejecutar el comando  `tar`

***NOTA: importante especificar el nombre del archivo con la extension final, agregar siempre .tar.gz***

**Flags:**

`-c`: Crear comprimido
`-x`: Descomprimir
`z`: Usa el motor gzip (el estándar).
`j`: Usa el motor bzip (comprime mejor).
`v`: Verbose (te muestra qué está guardando).
`f:` File (indica que lo siguiente es el nombre del archivo).
`-T`: Obtener los nombres de los archivos a comprimir desde un archivo

Ejemplos:

Crea un archivo comprimido usando el motor estandar

>`tar -czvf nombre_final.tar.gz carpeta_o_archivos_a_comprimir`

>`tar -cjvf nombre_final.tar.bz carpeta_o_archivos/`


Comando para "chismosear" qué hay dentro del paquete sin soltar nada en el disco:(La -t es de list)

# tar -tvf archivo.tar.gz

Para extraer solo un archivo específico dentro de un comprimido grande:

# tar -xzvf backup.tar.gz ruta/del/archivo_que_quieres.txt


============= VISUALIZACION EN VIVO =====================

Deja la terminal "escuchando" en tiempo real. Si algo pasa, aparece en tu pantalla al instante:

# tail -f /var/log/auth.log | grep "Failed password"

~ -F: Follow, deja la terminal "escuchando" en tiempo real. Si algo pasa, aparece en tu pantalla al instante.
~ |: Toma cada línea nueva que aparece.
~ grep: Revisa esa línea. Si dice "Failed password", te la muestra en pantalla. Si no, la ignora.

+ tail -f archivo1 archivo2
(Te pone el nombre del archivo arriba cada vez que entra una línea nueva en cualquiera de los dos).

============= COMANDO WACTH =====================

El número cambia en el mismo lugar, no se crean líneas nuevas, Es decir te muestra el estado actual actualizado.

# watch -n 2 "grep 'Failed password' /var/log/auth.log | wc -l"

~ watch -n 2: Ejecuta lo que sigue cada 2 segundos.
~ "grep 'Failed password' /var/log/auth.log: busca las lineas coincidentes en el archivo
~ wc -l: cuenta las lineas

============= LESS PARA LOGS =====================

A veces el log es gigante y no quieres verlo en tiempo real, sino navegarlo con calma.Si usas less puedes:

1. Puedes bajar con las flechas o el espacio.
2. Puedes buscar una palabra escribiendo / (diagonal) seguido de la palabra.
3. Sales presionando la tecla q.

PROCESOS Y MONITOREO

-top: (El tablero en vivo)

-htop: Es mucho más visual, tiene barritas de colores para el CPU/RAM y te permite matar procesos seleccionándolos con las flechas y F9. Pero hay que instalarlo.

-ps aux (La foto fija): Te da una lista detallada de todos los procesos que están corriendo en ese preciso instante. Ideal para filtrar con grep.

-kill (El verdugo): Sirve para detener un proceso que se quedó trabado. Solo necesitas su número de identificación (PID).

+ Kill -15 [PID]: cierre amigable
+ kill -9 [PID]: El hachazo

Número 	Nombre	 	Uso común
-1	SIGHUP	 	Recargar configuración
-2	SIGINT	 	Interrumpir (Ctrl+C)
-3	SIGQUIT	 	Salir con reporte de error
-9	SIGKILL	 	Muerte forzada (No se ignora)
-10/12	SIGUSR1/2	Definidos por el usuario/programador
-15	SIGTERM		Cierre limpio (Por defecto)
-19	SIGSTOP		Pausar proceso
