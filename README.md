# Limpieza y transformación de datos (Caso de estudio de Airbnb)

Este proyecto tiene como objetivo realizar las tareas de limpieza y transformación de datos para un conjunto de datos de Airbnb de la ciudad de Boston.  Estas tareas aseguran que los
datos usados para la toma de decisiones es preciso, confiable y accionable. 

## Resumen de descubrimientos

- Consistencia de datos: El conjunto de datos presentaba valores inconsistentes en diferentes tablas como 'listing' y 'calendar'. La tabla 'listing' presentaba a la columna 'host_response_time' con
valores 'N/A' en vez de NULL. En la columna 'host_neighbourhood', se presentaba 124 vecindarios diferentes cuando en realidad, solo hay 24. El proceso de la identificación correcta de los vecindarios
 se llevó acabo usando las coordenadas espaciales aproximadas de cada
listado. Como resultado de eso se redujo la cantidad de vecindarios a 24. Otras columnas de la misma tabla y las tablas 'calendar' antes listada, presentaba datos con valores anómalos. Al realizar
operaciones para filtrar estos datos las tablas 'listing', 'calendar' fueron reducidas en un 56.77% y 9.51%, respectivamente. Las tablas 'listing' y 'calendar' quedaron con 1,842 y 1,406,431 observaciones
respectivamente.
- Completitud de datos: El conjunto de datos  presentaba datos faltantes en la tabla `listing`, especificamente en dos columnas: `host_neighbourhood` y `host_is_superhost`, con un 2% y 3% de presencia
en las observaciones, respectivamente. Al aplicar análisis de casos completos, la cantidad de observaciones con valores faltantes se redujo a cero, resultando en una
reducción en el conjunto de datos (tabla  `listing`) de un 2%, ahora conteniendo 1,805 observaciones.

## Recomendaciones y pasos futuros

En función de los conocimientos adquiridos al descubrir datos faltantes e inconsistentes en el conjunto de datos de Airbnb, a continuación se ofrecen algunas recomendaciones prácticas:
- Implementar un protocolo de entrada de datos estandarizado: para evitar inconsistencias futuras, establecer pautas claras para la entrada de datos. Esto puede ayudar a mantener
 la integridad de los datos y facilitar el análisis.
- Auditorías de datos periódicas: Programar auditorías periódicas del conjunto de datos para identificar y abordar los datos faltantes o inconsistentes de inmediato. Esto podría
 implicar secuencias de comandos automatizadas que marquen anomalías o desviaciones de los patrones esperados, lo que permite tomar medidas correctivas más rápidas.
- Métodos mejorados de recopilación de datos: si ciertos campos muestran constantemente datos faltantes (por ejemplo, información del anfitrión), considerar revisar el proceso
 de recopilación de datos. Por ejemplo, implemente campos obligatorios durante la creación de anuncios en la plataforma para garantizar que se capture información crítica.
- Informes de calidad de datos: cree un dashboard o informe que resuma periódicamente las métricas de calidad de los datos, como el porcentaje de valores faltantes, las
 inconsistencias identificadas y las acciones tomadas para resolver estos problemas. Esta transparencia puede ayudar a las partes interesadas a comprender el estado
 del conjunto de datos y priorizar las áreas que necesitan atención.
- Capacitación para anfitriones: brinde capacitación o recursos para anfitriones sobre cómo completar sus anuncios con precisión. Esto podría incluir tutoriales sobre
 las mejores prácticas para ingresar información sobre servicios, precios y disponibilidad, lo que puede reducir los errores y mejorar la calidad general de los datos.

Al implementar estas recomendaciones, puede mejorar significativamente la calidad de su conjunto de datos de Airbnb, lo que genera análisis más confiables y decisiones comerciales mejor informadas.


## Estructura 

La estructura del repositorio es:

- datos: Contiene el conjunto de datos sin procesar en formato csv.

- documentacion: Contiene el informe que documenta todas las tareas realizadas.

- codigo: Contiene código de PostgreSQL para cada fase de CRISP-DM relacionado con la limpieza y transformación de datos. Se divide
en dos directorios, preparacion_de_datos y comprension_de_datos con archivos con código PostgreSQL que representa la tarea realizada en esas
fases. Y el archivo de volcado de datos para recrear la base de datos en el mismo estado en que estaba en el momento del volcado.
 

## ¿Cómo utilizarlo?

Para reproducir los resultados, puede cargar el archivo de volcado de datos utilizando el siguiente comando:

```bash
-- Crear nueva base de datos con el estándar PostgreSQL
-- catálogos del sistema, sin modificar por ninguna acción anterior
createdb -T template0 dbname

-- Restaurar un fichero de volcado
psql --set ON_ERROR_STOP=on dbname < dumpfile
```

O crear la base de datos y luego ejecutar cada script. Recordar instalar psql (16.2). [Los archivos estan almacenados en la nube](https://drive.google.com/drive/folders/16q4xgEGPM-RoK31yX8wkQwENX2kmSOQA?usp=sharing). Se
 necesita colocar los archivos descargados en el directorio/carpeta temporal de su sistema operativo o en datos. El archivo de volcado es `boston_airbnb_data_backup.sql`.