# Limpieza y transformación de datos

![airbnb-logo](airbnb-logo.png)

<a href="https://www.flaticon.com/free-icons/airbnb" title="iconos de airbnb">Iconos de Airbnb creados por riajulislam - Flaticon

## **Tabla de contenido**

- [Introducción](#introduccion)
- [Comprensión de datos](#comprension-de-datos)
    - [Recolección inicial de datos](#recoleccion-de-datos-inicial)
    - [Descripción de los datos](#descripcion-de-los-datos)
    - [Exploración de datos](#exploracion-de-datos)-
    - [Verificar la calidad de los datos](#verificar-calidad-de-datos)
- [Preparación de datos](#preparacion-de-datos)
    - [Cambiar las columnas a sus tipos de datos apropiados](#cambiar-columnas-a-su-tipo-de-dato-apropiado)
    - [Selección de datos](#seleccion-de-datos)
    - [Limpieza de datos](#limpieza-de-datos)
    - [Construcción de datos](#construccion-de-datos)
- [Conclusión](#conclusion)
- [Referencias](#referencias)


<a id='introduccion'></a>
## **Introducción**

Este proyecto tiene como objetivo generar datos de alta calidad utilizando diferentes técnicas y métodos. Estos datos pueden ayudar a un analista de datos a comprender el actual mercado de alquileres a corto plazo para guiar la expansión de una empresa inmobiliaria o de un particular.

He seleccionado PostgreSQL como mi herramienta principal para aprovechar sus características y mostrar mi experiencia.

La metodología del proyecto se basa en CRISP-DM (Proceso Estándar Interindustrial para la Minería de Datos) [1], incorporando únicamente los componentes que se alinean con el objetivo del proyecto.


<a id='comprension-de-datos'></a>
## **Comprensión de datos**


<a id='recolección-de-datos-inicial'></a>
### **Recolección de datos inicial**


Recopilé los datos de Inside Airbnb [2], un proyecto con una misión que proporciona información sobre los anuncios de Airbnb para los próximos 12 meses, 
que se actualiza trimestralmente. Elegí específicamente datos de Boston, MA, los descargué manualmente y los guardé localmente.


<a id='descripcion-de-los-datos'></a>
### **Descripción de los datos**

Los datos de Airbnb de Boston están almacenados en formato .csv. Contiene 7 archivos que representan diferentes
 aspectos de los datos. Tres de ellos representan datos detallados sobre los anuncios (`listings.csv`), incluyendo
 su disponibilidad en los próximos 12 meses (`calendar.csv`) y las reseñas pasadas (`reviews.csv`). Los siguientes tres
 representan una versión resumida de los datos detallados. Los dos restantes representan información geográfica para los
 vecindarios (`neighbourhoods.csv`, `neighbourhoods.geojson`). Selecciono solo los primeros tres archivos que 
contienen datos que se alinean con el objetivo del proyecto.


 Los archivos tienen un número variable de campos y 
observaciones. `listings.csv` tiene 75 campos y 4,261 observaciones. `calendar.csv` contiene 7 campos
 y 1,554,256 observaciones. Y el archivo `reviews.csv` contiene 6 campos y 186,496 observaciones.


 El archivo `listing.csv`  contiene 4 tipos diferentes de información. El primer tipo está relacionado con la unicidad de los 
datos (`listing_id`). El segundo tipo está relacionado con la enumeración de métricas clave de rendimiento (KPI), 
con columnas como `number_of_reviews`, `number_of_reviews_ltm`, y así sucesivamente. El tercer tipo contiene información
 del anfitrión con columnas como `host_id`, `host_url` y demás. El último tipo de información está relacionado con la
 propiedad, como `bathrooms`, `bedrooms` y otros. La tabla a continuación proporciona información detallada sobre cada columna.


| Atributo | Descripción |
|-------------------------|-----------------------------------------------------------------------------------------------|
| id | Identificador único para cada registro |
| listing_url | URL de la página del anuncio en el sitio web de Airbnb |
| scrape_id | Identificador utilizado durante el proceso de extracción de datos |
| last_scraped | Marca de tiempo que indica la última vez que se extrajeron los datos |
| source | Fuente de los datos, por ejemplo, API de Airbnb, extracción web |
| name | Nombre del anuncio |
| description | Descripción detallada del anuncio |
| neighborhood_overview | Resumen del vecindario donde se encuentra el anuncio |
| picture_url | URL de la imagen principal asociada con el anuncio |
| host_id | Identificador único para el anfitrión |
| host_url | URL de la página de perfil del anfitrión en el sitio web de Airbnb |
| host_name | Nombre del anfitrión |
| host_since | Fecha desde que el anfitrión comenzó a hospedar en Airbnb |
| host_location | Ubicación del anfitrión |
| host_about | Sección "Acerca de" del perfil del anfitrión, proporcionando información sobre el anfitrión |
| host_response_time | Tiempo promedio de respuesta del anfitrión a las consultas |
| host_response_rate | Tasa de respuesta del anfitrión basada en los comentarios de los huéspedes |
| host_acceptance_rate | Porcentaje de reservas aceptadas por el anfitrión |
| host_is_superhost | Booleano que indica si el anfitrión es un Superhost |
| host_thumbnail_url | URL de la imagen en miniatura del anfitrión |
| host_picture_url | URL de la foto de perfil del anfitrión |
| host_neighbourhood | Vecindario donde reside el anfitrión |
| host_listings_count | Número de anuncios hospedados por el anfitrión |
| host_total_listings_count | Número total de anuncios hospedados por el anfitrión en todas las plataformas |
| host_verifications | Array de estados de verificación para el anfitrión |
| host_has_profile_pic | Booleano que indica si el anfitrión tiene una foto de perfil |
| host_identity_verified | Booleano que indica si la identidad del anfitrión ha sido verificada |
| neighbourhood | Nombre del vecindario donde se encuentra el anuncio |
| neighbourhood_cleansed | Versión limpia del nombre del vecindario |
| neighbourhood_group_cleansed | Nombre limpio del grupo del vecindario |
| latitude | Coordenada de latitud de la ubicación del anuncio |
| longitude | Coordenada de longitud de la ubicación del anuncio |
| property_type | Tipo de propiedad (por ejemplo, apartamento, casa) |
| room_type | Tipo de habitación dentro de la propiedad (por ejemplo, habitación privada, casa completa) |
| accommodates | Número máximo de huéspedes que puede acomodar el anuncio |
| bathrooms | Número de baños completos en el anuncio |
| bathrooms_text | Representación textual del conteo de baños (por ejemplo, "1 baño completo") |
| bedrooms | Número de dormitorios en el anuncio |
| beds | Número de camas disponibles en el anuncio |
| amenities | Array de comodidades ofrecidas por el anuncio |
| price | Precio por noche para el anuncio |
| minimum_nights | Número mínimo de noches para realizar una reserva |
| maximum_nights | Número máximo de noches para realizar una reserva |
| minimum_minimum_nights | Número mínimo de noches para realizar una reserva, considerando la política mínima de noches |
| maximum_minimum_nights | Número máximo de noches para realizar una reserva, considerando la política mínima de noches |
| minimum_maximum_nights | Número mínimo de noches para realizar una reserva, considerando la política máxima de noches |
| maximum_maximum_nights | Número máximo de noches para realizar una reserva, considerando la política máxima de noches |
| minimum_nights_avg_ntm | Promedio mínimo del número de noches reservadas durante el último año |
| maximum_nights_avg_ntm | Promedio máximo del número de noches reservadas durante el último año |
| calendar_updated | Marca de tiempo que indica la última actualización del calendario del anuncio |
| has_availability | Booleano que indica si actualmente hay disponibilidad en el anuncio |
| availability_30 | Número de días disponibles en los próximos 30 días |
| availability_60 | Número de días disponibles en los próximos 60 días |
| availability_90 | Número de días disponibles en los próximos 90 días |
| availability_365 | Número de días disponibles en los próximos 365 días |
| calendar_last_scraped | Marca de tiempo que indica la última vez que se extrajo información del anuncio |
| number_of_reviews | Número total de reseñas dejadas para el anuncio |
| number_of_reviews_ltm | Número de reseñas dejadas para el anuncio durante los últimos 12 meses |
| number_of_reviews_l30d | Número de reseñas dejadas para el anuncio durante los últimos 30 días |
| first_review | Fecha de la primera reseña recibida para el anuncio |
| last_review | Fecha de la reseña más reciente recibida para el anuncio |
| review_scores_rating | Puntuación general del anuncio, sobre 5 |
| review_scores_accuracy | Puntuación por precisión del anuncio, sobre 5 |
| review_scores_cleanliness | Puntuación por limpieza del anuncio, sobre 5 |
| review_scores_checkin | Puntuación por experiencia en check-in del anuncio, sobre 5|
| review_scores_communication | Puntuación por comunicación del anuncio, sobre 5|
| review_scores_location | Puntuación por ubicación del anuncio, sobre 5|
| review_scores_value | Puntuación por relación calidad-precio del anuncio, sobre 5|
| license | Tipo de licencia para el anuncio|
| instant_bookable | Booleano que indica si el anuncio permite reservas instantáneas|
| calculated_host_listings_count | Número total calculado de anuncios hospedados por el anfitrión en todas las plataformas|
| calculated_host_listings_count_entire_homes |		Número total calculado de casas enteras hospedadas por el anfitrión|
|calculated_host_listings_count_private_rooms |		Número total calculado de habitaciones privadas hospedadas por el anfitrión|
|calculated_host_listings_count_shared_rooms |		Número total calculado habitaciones compartidas hospedadas por el anfitrión|
|reviews_per_month |	Promedio mensual número total reseñas recibidas|

El archivo `calendar.csv` contiene 2 tipos diferentes de información. El primer tipo está relacionado con fechas. El segundo tipo
 contiene información de listados con variables como `price`, `minimum_nights`, y así sucesivamente. La tabla a continuación
 proporciona información detallada sobre cada columna.

| Atributo         | Descripción                                                                                   |
|------------------|-----------------------------------------------------------------------------------------------|
| listing_id       | Identificador único para cada anuncio                                                        |
| date             | Fecha en la que se registró o actualizó la información del anuncio                           |
| available        | Valor booleano que indica si el anuncio está actualmente disponible para reservar            |
| price            | Precio original por noche para el anuncio                                                    |
| adjusted_price   | Precio ajustado por noche para el anuncio, teniendo en cuenta descuentos u ofertas especiales |
| minimum_nights   | Número mínimo de noches que se puede reservar                                                 |
| maximum_nights   | Número máximo de noches que se puede reservar                                                |

El archivo `reviews.csv` solo contiene información relevante de reseñas pasadas para un listado en particular. La tabla 
a continuación proporciona información detallada sobre cada columna.

| Atributo         | Descripción                                                                                   |
|------------------|-----------------------------------------------------------------------------------------------|
| listing_id       | Identificador único para cada anuncio                                                         |
| id               | Identificador interno para la entrada de la reseña                                            |
| date             | Fecha en la que se envió la reseña                                                            |
| reviewer_id      | Identificador único para el revisor que escribió la reseña                                    |
| reviewer_name    | Nombre del revisor que escribió la reseña                                                      |
| comments         | Comentarios o retroalimentación proporcionados por el revisor sobre el anuncio               |

Los datos de la fuente se organizaron en tablas dentro de una base de datos robusta, estableciendo relaciones
 entre los diferentes conjuntos de datos. La siguiente ilustración (ERD) proporciona una representación de la
 estructura de la base de datos.

![erd-boston-airbnb-data](./erd-boston-airbnb-data.png)


<a id='exploracion-de-datos'></a>

### **Exploración de datos**

El conjunto de datos tiene 4102 anuncios activos hasta del 24 de marzo de 2024. Están distribuidos en 121 barrios y pertenecen a 1,228 anfitriones. De estos anfitriones, 522 (42.50%) están clasificados como superanfitriones, mientras que 706 (57.49%) son anfitriones regulares. Es importante señalar que un factor a considerar al evaluar una propiedad para inversión en alquiler a corto plazo es evitar ubicaciones con muchos anfitriones profesionales. Hay 28 de ellos que representan el 2.04% de todos los anfitriones, y poseen el 42.63% de los anuncios.

Si analizamos más a fondo cómo se configuran las propiedades, la mayoría de ellas son unidades de alquiler completas (49.26%). Estos alojamientos en su mayoría son para dos huéspedes (42.05%), tienen un baño (61.18%) y una cama (49.24%). Las cinco comodidades más populares, presentes en más del 90% de los anuncios, incluyen alarmas de humo, alarmas de monóxido de carbono, Wifi, artículos esenciales y agua caliente.


El conjunto de datos muestra características prometedoras para una buena inversión a corto plazo. Estos atributos podrían llevar a un mayor ingreso anual al mantener el estatus de superanfitrión. Al mantener este estatus, podríamos tener un potencial de ingresos anuales un 13% más alto que el de los anfitriones regulares [4]. En el último año, los superanfitriones de Boston recibieron un promedio de 21 reseñas, con una puntuación media de 4.86 y una tasa de respuesta promedio de más del 90%. Estos criterios son cruciales para mantener el estatus de superanfitrión [5].


Los superanfitriones y los anfitriones regulares tienen tarifas promedio por noche similares. Las tarifas nocturnas promedio son de 194.05 para superanfitriones y 186.43 para anfitriones regulares.


Exploré la conexión entre variables cuantitativas y cualitativas y la tarifa nocturna, dado que este indicador puede ser valioso para calcular los indicadores clave de rendimiento. (KPI). El análisis reveló una correlación positiva moderada (0.5 < r < 0.7) entre el precio y el número de camas, dormitorios, baños y alojamientos. Esto indica que a medida que aumenta la cantidad de estas variables, también aumenta la tarifa nocturna.

<a id='verificar-calidad-de-datos'></a>
### **Verificar la calidad de los datos**

El conjunto de datos presenta algunos problemas:

1. Tipos de datos inapropiados: Presentes en cada tabla.
2. Valores atípicos: Presentes en la tabla de listado y en el calendario.
3. Valores inválidos: Presentes en la tabla de listado.
4. Valores en blanco: Presentes en cada tabla.
5. Valores faltantes: Presentes en la tabla de listados y en el calendario. Su presencia varía de grado bajo, alto o absoluto en algunas variables.

<a id='preparacion-de-datos'></a>
## **Preparación de datos**


<a id='cambiar-columnas-a-sus-tipos-de-datos-apropiados'></a>
## **Cambia las columnas a sus tipos de datos apropiados**

Después de establecer un formato adecuado para los datos. La tabla `listing` tiene los siguientes tipos de datos para cada columna.


| Nombre de columna                     | Tipo de datos      |
| ------------------------------- | -------------- |
| id                              | bigint         |
| listing_url                     | texto          |
| scrape_id                       | bigint         |
| last_scraped                    | fecha          |
| source                          | texto          |
| name                            | texto          |
| description                     | texto          |
| neighborhood_overview           | texto          |
| picture_url                     | texto          |
| host_id                         | bigint         |
| host_url                        | texto          |
| host_name                       | texto          |
| host_since                      | fecha          |
| host_location                   | texto          |
| host_about                      | texto          |
| host_response_time              | texto          |
| host_thumbnail_url              | texto          |
| host_picture_url                | texto          |
| host_neighbourhood              | texto          |
| host_listings_count             | entero         |
| host_total_listings_count       | entero         |
| host_verifications               | ARRAY          |
| neighbourhood                   | texto          |
| neighbourhood_cleansed          | texto          |
| neighbourhood_group_cleansed    | texto          |
| latitude                        | doble precisión |
| longitude                       | doble precisión |
| property_type                   | texto          |
| room_type                       | texto          |
| accommodates                    | entero         |
| bathrooms                       | doble precisión |
| bathrooms_text                  | texto          |
| bedrooms                        | entero         |
| beds                            | entero         |
| amenities                       | ARRAY          |
| price                           | numérico       |
| minimum_nights                  | entero         |
| maximum_nights                  | entero         |
| minimum_minimum_nights          | entero         |
| maximum_minimum_nights          | entero         |
| minimum_maximum_nights          | entero         |
| maximum_maximum_nights          | entero         |
| minimum_nights_avg_ntm          | doble precisión |
| maximum_nights_avg_ntm          | doble precisión |
| calendar_updated                | fecha          |
| availability_30                 | entero         |
| availability_60                 | entero         |
| availability_90                 | entero         |
| availability_365                | entero         |
| calendar_last_scraped           | fecha          |
| number_of_reviews               | entero         |
| number_of_reviews_ltm           | entero         |
| number_of_reviews_l30d          | entero         |
| first_review                    | fecha          |
| last_review                     | fecha          |
| review_scores_rating            | doble precisión |
| review_scores_accuracy           | doble precisión |
| review_scores_cleanliness        | doble precisión |
| review_scores_checkin           | doble precisión |
| review_scores_communication     | doble precisión |
| review_scores_location          | doble precisión |
| review_scores_value             | doble precisión |
| license                         | texto          |
| calculated_host_listings_count  | entero         |
| calculated_host_listings_count_entire_homes 	| entero       |
| calculated_host_listings_count_private_rooms 	| entero       |
| calculated_host_listings_count_shared_rooms 	| entero       |
| reviews_per_month               | doble precisión |

La tabla `calendar` ahora tiene los tipos de datos apropiados para cada columna, como se ve a continuación.

| Nombre de columna       | Tipo de datos      |
|---------------------|----------------|
| listing_id          | bigint         |
| date                | fecha          |
| price               | numérico       |
| adjusted_price      | texto          |
| minimum_nights      | entero         |
| maximum_nights      | entero         |
| available           | booleano       |

La tabla `review` ahora tiene tipos de datos apropiados para cada columna, como se puede ver a continuación.

| Nombre de columna         | Tipo de datos      |
|---------------------|----------------|
| listing_id          | bigint         |
| id                  | bigint         |
| date                | fecha          |
| reviewer_id         | bigint         |
| reviewer_name       | texto          |
| comments            | texto          |

<a id='seleccion-de-datos'></a>

### **Selección de datos**

Seleccioné cuidadosamente solo las características más relevantes que coinciden con el objetivo del proyecto. Como resultado, reduje el número de columnas en todas las tablas. La tabla de listado disminuyó a nivel de columnas, pasando de 75 a 32 columnas. De manera similar, la tabla del calendario solo disminuyó a nivel de columnas, pasando de 7 a 4 columnas. De la misma manera, la tabla de revisión pasó de 6 a 4 columnas.

Las columnas seleccionadas para la tabla `listing` son las siguientes:

| Nombre de columna               | Tipo de datos        |
|---------------------------|------------------|
| id                        | bigint           |
| name                      | texto            |
| host_id                   | bigint           |
| host_name                 | texto            |
| host_response_time        | texto            |
| host_neighbourhood        | texto            |
| host_listings_count       | entero           |
| host_total_listings_count | entero           |
| latitude                  | doble precisión   |
| longitude                 | doble precisión   |
| property_type             | texto            |
| room_type                 | texto            |
| accommodates              | entero           |
| bathrooms                 | doble precisión   |
| bedrooms                  | entero           |
| beds                      | entero           |
| amenities                 | ARRAY            |
| price                     | numérico         |
| minimum_nights            | entero           |
| maximum_nights            | entero           |
| calendar_last_scraped     | fecha            |
| number_of_reviews         | entero           |
| number_of_reviews_ltm     | entero           |
| number_of_reviews_l30d    | entero           |
| first_review              | fecha            |
| last_review               | fecha            |
| review_scores_rating      | doble precisión   |
| reviews_per_month         | doble precisión   |
| host_response_rate        | numérico         |
| host_acceptance_rate      | numérico         |
| host_is_superhost         | booleano         |
| has_availability          | booleano         |

Las columnas seleccionadas para la tabla `calendar` son las siguientes:

| column_name        | data_type     |
|--------------------|---------------|
| listing_id         | bigint        |
| date               | fecha         |
| price              | numérico      |
| available          | booleano      |

Y las columnas seleccionadas para la tabla `review` son las siguientes:

| column_name        | data_type     |
|--------------------|---------------|
| listing_id         | bigint        |
| id                 | bigint        |
| date               | fecha         |
| reviewer_id        | bigint        |


<a id='limpieza-de-datos'></a>
### **Limpieza de datos**

Todos los errores presentes en los datos fueron corregidos con éxito para garantizar la calidad
 de los datos. La metodología seguida es la propuesta por Ilyas et al. [6]. Esta metodología asegura
 que las dimensiones relevantes de los datos cumplan con los requisitos de nuestra situación
 específica. El proceso de selección de dimensiones se realizó utilizando el enfoque DAMA. Las 
dimensiones son las siguientes: actualidad, validez, precisión, unicidad y completitud.  Estos están
 listados por orden de prioridad para alcanzar nuestro objetivo y su relación costo-beneficio 
en los pasos de detección y reparación de errores [7].


La técnica utilizada en la verificación de las dimensiones de actualidad fue la limpieza de datos
 basada en reglas. La columna `date` en la tabla de calendario y reseñas fue crucial para hacer esto.

La técnica utilizada en la verificación de dimensiones sobre la validez y precisión de los datos fue
 basada en reglas y detección de valores atípicos. El más afectado fue la tabla `listing`, que ahora se redujo un 
56.77% menos de observaciones, sumando un total de 1,842. En esta tabla en particular, lo que se ajustó fue
 el `host_response_time`, reemplazando los valores 'N/A' por 'NULL'. Esto también ocurre en
 la columna `host_neighbourhood`, donde existían 124 vecindarios diferentes y, sin embargo, solo hay 24. La 
identificación de vecindarios utilizó las coordenadas espaciales aproximadas de los datos de listado [9]. Las 
columnas restantes en esta tabla y otras columnas en las tablas restantes utilizaron técnicas simples basadas
 en reglas y detección de valores atípicos. Como tal, la tabla de calendario se redujo en un 9.51% con 
1,406,431 observaciones, mientras que la tabla de revisión permaneció igual con 186,496 observaciones.

El conjunto de datos no presenta entradas duplicadas. La llave primaria ha sido efectiva para garantizar
 que cada observación sea única, apareciendo solo una vez en el conjunto de datos.

La integridad de los datos se verificó utilizando el método de análisis de casos completos. Faltaban datos
 en la tabla de listado, particularmente en dos columnas: `host_neighbourhood` y `host_is_superhost`, con
 un 2% y un 3% de las observaciones, respectivamente. La columna `host_neighbourhood` se completó de acuerdo
 con el método de identificación de vecindarios que se utilizaría de antemano. Se realizó una columna que 
trata `host_is_superhost` con un análisis de casos completos debido a la baja cantidad de valores faltantes. Ahora
 contiene 1,805 observaciones, que son listados, una disminución del 2 por ciento.


<a id='construccion-de-datos'></a>
### **Construcción de datos**

Cre una nueva columna llamada `total_potential_revenue` derivada de la cantidad de noches del próximo
 año (tabla de calendario) y el precio por noche. (listing table). Otros indicadores clave de rendimiento (KPI)
 como la tarifa diaria promedio (ADR) y la tasa de ocupación no se calcularon debido a limitaciones de datos.


<a id='conclusion'></a>
## **Conclusión**

Nuestros datos cumplen con los requisitos expresados como dimensiones de datos, asegurando así la calidad de
 los mismos. Utilicé una variedad de técnicas implementadas en PostgreSQL para lograr esto. Para asegurar
 un análisis prescriptivo más preciso, es crucial incorporar otras fuentes de datos actualizadas.


<a id='referencias'></a>
## **Referencias**

[1] N. Hotz, “What is CRISP DM?,” Data Science Project Management, Jan. 19, 2023. https://www.datascience-pm.com/crisp-dm-2/ (accessed May 14, 2024).
‌

[2] Airbnb, “Inside Airbnb” Inside Airbnb. https://insideairbnb.com/ (Accedido: 14 de mayo de 2024).

[3] Airdna, “How to find a good short-term rental investment location | AirDNA,” airdna. https://www.airdna.co/guides/find-good-short-term-rental-locations (Accedido: 30 de mayo de 2024).

[4] Airdna, "Airbnb Superhost: How to Become One in 2024”, AirDNA - Short-Term Vacation Rental Data and Analytics, Apr. 7, 2024. https://www.airdna.co/blog/airbnb_superhost_status (Accedido: 30 de mayo de 2024).

[5] Airbnb, “How to become a Superhost - Airbnb Help Center,” Airbnb. https://www.airbnb.com/help/article/829 (Accedido: 30 de mayo de 2024)

[6] I. F. Ilyas and X. Chu, “Data Cleaning,” Jul. 2019, doi: https://doi.org/10.1145/3310205.

[7] DAMA, “Dimensions of Data Quality | Stichting DAMA NL.” https://dama-nl.org/dimensions-of-data-quality-en/ (Accedido: 9 de junio de 2024)

[8] City of Boston, "Neighborhoods," boston.gov, Oct. 13, 2017. https://www.boston.gov/neighborhoods (Accedido: 18 de junio de 2024)

[9] Inside Airbnb, “Data Assumptions,” Inside Airbnb. https://insideairbnb.com/data-assumptions/ (Accedido: 19 de junio de 2024).