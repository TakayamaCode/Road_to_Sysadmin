
# 1. Identificación de Datos Críticos para el Respaldo

Antes de crear una copia de seguridad, tu primera tarea es identificar qué datos son críticos. Un respaldo completo del sistema suele ser poco práctico. Para nuestro servidor de aplicaciones, los activos más importantes se encuentran en los directorios `data`, `config` y `logs`.

Para que nuestro proceso de respaldo sea limpio y manejable, crearemos un archivo que enumere todos los directorios que deseamos respaldar. Esta lista servirá como un manifiesto para nuestro script de respaldo.

## Tareas

- Crea un archivo llamado `backup-list.txt` en el directorio `~/project`.
- Este archivo debe contener las rutas relativas a los tres directorios críticos, con cada ruta en una línea nueva.  
# 2. Creación de un Archivo de Respaldo del Sistema

Con la lista de directorios críticos lista, es hora de crear el archivo de respaldo. La herramienta estándar de Linux para este trabajo es `tar` (Tape Archive). Puede agrupar múltiples archivos y directorios en un solo archivo. También comprimiremos el archivo para ahorrar espacio usando `gzip`.

## Tareas

- Usa el comando `tar` para crear un archivo de respaldo comprimido.
- El archivo debe llamarse `system-backup.tar.gz`.
- El archivo debe colocarse en el directorio `~/project/backups/`.
- El contenido del archivo debe determinarse mediante el archivo `backup-list.txt` que creaste en el paso anterior.  
# 3. Verificación de la Integridad del Respaldo

Un respaldo es inútil si está corrompido o incompleto. Un paso crucial en cualquier estrategia de respaldo es la verificación. Debes asegurarte de que el archivo que creaste contiene todos los archivos previstos y es legible.

## Tareas

- Usa el comando `tar` para listar el contenido del archivo `system-backup.tar.gz` sin extraerlo.
- Redirige la salida de este comando a un nuevo archivo llamado `backup-contents.txt` en el directorio `~/project`.
  
# 4. Restauración de Archivos desde un Respaldo

¡Ha ocurrido un desastre! Un desarrollador junior, intentando liberar espacio, ha borrado accidentalmente el archivo de configuración principal de la aplicación, `app.conf`. La aplicación está caída. Te toca a ti, el Centinela de los Respaldos, restaurar este archivo crítico desde tu respaldo y salvar el día.

## Tareas

1. Usa el comando `tar` para restaurar _únicamente_ el archivo `config/app.conf` desde tu archivo `system-backup.tar.gz`. El archivo debe restaurarse en su ubicación original.
  
## SOLUCIÓN 


#### 1.Creacion de archivo de datos criticos

Crearé el archivo txt que contendrá ennumerados los directorios importantes del ejemplo

![[Pasted image 20260309102240.png]]
![[Pasted image 20260309102218.png]]
#### 2.Creación de un Archivo de Respaldo del Sistema

Una vez creado mi archivo de ennumeración, crearé el comprimido usando el comando [tar] con las flags correspondientes a las notas de gestion de sistemas

![[Pasted image 20260309103521.png]]
#### 3.Verificación de la Integridad del Respaldo

Una vez creado el backup comprimido, verificaré el archivo con la opcion `-t` para listar el contenido del archivo comprimido y luego redirigir el resultado al nuevo archvio `backup-contents.txt`, verificando su contenido con `cat`

![[Pasted image 20260309101312.png]]

#### 4.Simualcion de accidente

Primero me piden borrar un archivo `app.conf`, para esto primero verifico usando los comandos aprendidos `find` para buscar el archivo y ver su ruta

Una vez encontrado ejecuto sobre el mismo comando `rm` con `-excec`, esto lo hago para tener mayor precision del nombre del archivo y evitar eliminar más contenido

Por ultimo reultilizo el mismo comando con el que busqué el archivo originalmente y verifico que ya no exista

![[Captura de pantalla 2026-03-09 103247.jpg]]

#### 5.Restauracion del backup

Ahora solo realizaré la restauracion del archivo `app.conf` para eso usare `-xzvf` la f me ayudara a apuntar al archivo que queiro restaurar y que ignore el resto. Verificando que en la carpeta exista el archivo nuevamente

![[Pasted image 20260309105649.png]]

# EXTRA

# Programación de Tareas de Respaldo Automatizadas

Has salvado el día, pero el trabajo de un héroe nunca termina. Confiar en respaldos manuales es arriesgado. El paso final es automatizar el proceso para que los respaldos se creen regularmente sin intervención humana. Para ello, utilizaremos `cron`, el programador de tareas estándar de Linux.

## Tareas

- Crea una tarea cron que ejecute automáticamente un comando de respaldo.
- La tarea debe ejecutarse **cada minuto** (para los fines de este desafío).
- El comando debe crear un nuevo archivo `tar` comprimido dentro del directorio `~/project/backups/`.
- Para evitar sobrescrituras, cada nuevo archivo de respaldo debe tener un nombre único que incluya una marca de tiempo (por ejemplo, `backup-2023-10-27_15-30-00.tar.gz`).
  
# SOLUCIÓN
  
Primero abriré `crontab` sin embargo directamente lo abriré con `nano` para no tener que elegir el editor y ser más rápido.
   ![[Pasted image 20260309110311.png]]
   
Ahora creare la linea a ejecutar

![[Pasted image 20260309111431.png]]
   
Usaré * * * * * el cual ndica que se ejecute cada minuto de cada día.
   
Tambien es obligatorio usar rutas absolutas, así que coloqué la ruta a donde quiero que haga el backup 
   `/home/labex/project/backups/backup-`

y como va a tener nombres de marcas de tiempo que cambian a cada rato, usare date para la marca de tiempo escapando los signos especiales

`$(date +\%Y-\%m-\%d_\%H-\%m-\%S)`

y por ultimo le indico de que quiero que haga el backup, por lo que usare la lista de lo que me pidieron

`-T /home/labex/project/backup-list.txt`

Verificamos con `crontab -l` 

![[Pasted image 20260309111510.png]]

Y ya podremos observar nuestros backups creandose

![[Pasted image 20260309112215.png]]

