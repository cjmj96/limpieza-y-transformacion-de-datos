# Limpieza y transformación de datos (Case de estudio de Airbnb)

Este proyecto tiene como objetivo mostrar las habilidades de SQL a la hora de realizar las tareas de limpieza y transformación de datos dentro del modelo de proceso CRISP-DM para un conjunto de datos Airbnb de la ciudad de Boston. La estructura del repositorio es

datos: Contiene el conjunto de datos sin procesar en formato csv.
documentacion: Contiene el informe que documenta todas las tareas realizadas.
codigo: Contiene código de PostgreSQL para cada fase de CRISP-DM relacionado con la limpieza y transformación de datos. Se divide
en dos directorios, preparacion_de_datos y comprension_de_datos con archivos con código PostgreSQL que representa la tarea realizada en esas
fases. Y el archivo de volcado de datos para recrear la base de datos en el mismo estado en que estaba en el momento del volcado.


## Cómo utilizarlo
Para reproducir los resultados, puede cargar el archivo de volcado de datos utilizando el siguiente comando:

'''bash
-- Crear nueva base de datos con el estándar PostgreSQL
-- catálogos del sistema, sin modificar por ninguna acción anterior
createdb -T template0 dbname

-- Restaurar un fichero de volcado
psql --set ON_ERROR_STOP=on dbname < dumpfile
'''

O crear la base de datos y luego ejecutar cada script. Recordar instalar psql (16.2). [Los archivos estan almacenados en la nube](https://drive.google.com/drive/folders/16q4xgEGPM-RoK31yX8wkQwENX2kmSOQA?usp=sharing). Se
 necesita colocar los archivos descargados en el directorio/carpeta temporal de su sistema operativo o en datos. El archivo de volcado es `boston_airbnb_data_backup.sql`.