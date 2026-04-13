ls -a -l -h -t -r -s -S -x -X -v */ --color -1

| Opción   | ¿Qué hace?                                                                              | Tip Pro                                                    |     |
| -------- | --------------------------------------------------------------------------------------- | ---------------------------------------------------------- | --- |
| **`-a`** | **All**: Muestra todo, hasta los archivos ocultos (los que empiezan con `.`).           | Úsalo para ver archivos de configuración.                  |     |
| **`-l`** | **Long**: Formato de lista larga. Muestra permisos, dueño y fecha.                      | Es el estándar para administrar en serio.                  |     |
| **`-h`** | **Human**: Pone los tamaños en KB, MB, GB en lugar de bytes.                            | Imprescindible para no volverte loco contando ceros.       |     |
| **`-t`** | **Time**: Ordena por fecha de modificación (lo más nuevo arriba).                       | Útil para ver en qué estabas trabajando ayer.              |     |
| **`-r`** | **Reverse**: Invierte el orden de cualquier otro comando.                               | Si usas `-tr`, verás lo más nuevo al final de la lista.    |     |
| **`-s`** | **Size**: Muestra el tamaño de cada archivo en bloques.                                 | Te dice cuánto ocupa cada línea individualmente.           |     |
| **`-S`** | **Sort Size**: Ordena por tamaño (el archivo más pesado arriba).                        | **Mayúscula obligatoria** para ordenar por peso.           |     |
| **`-x`** | **Across**: Lista por líneas en lugar de columnas.                                      | Cambia la estética visual de cómo se acomodan los nombres. |     |
| **`-X`** | **Extension**: Ordena alfabéticamente por la extensión (.css, .html, .jpg).             | Ideal para organizar carpetas de diseño o fotos.           |     |
| **`-v`** | **Version**: Ordena por número de versión (ej: `file1.txt`, `file2.txt`, `file10.txt`). | Evita que el "10" aparezca justo después del "1".          |     |
| **`-1`** | **One**: Fuerza la salida a una sola columna.                                           | Muy útil si vas a pasar el resultado a otro comando.       |     |
| **`*/`** | **Wildcard**: Le dice a `ls` que solo mire **dentro de las carpetas**.                  | Ignora los archivos sueltos del directorio actual.         |     |
