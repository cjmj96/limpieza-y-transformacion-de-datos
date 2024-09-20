--  Clonar tabla listing para propósitos de reproducción
CREATE TABLE listing_prepared AS
SELECT *
FROM listing;
--
--  Clonar tabla calendar para propósitos de reproducción
CREATE TABLE calendar_prepared AS
SELECT *
FROM calendar;
--
--  Clonar tabla review para propósitos de reproducción
CREATE TABLE review_prepared AS
SELECT *
FROM review;
--
--  Cambiar tipo de dato de id de la tabla listing_prepared
ALTER TABLE listing_prepared
ALTER COLUMN id TYPE BIGINT USING id::BIGINT;
--
--  Cambiar tipo de dato de scrape_id de la tabla listing_prepared
ALTER TABLE listing_prepared
ALTER COLUMN scrape_id TYPE BIGINT USING id::BIGINT;
--
--  Cambiar tipo de dato de host_id de la tabla listing_prepared
ALTER TABLE listing_prepared
ALTER COLUMN host_id TYPE BIGINT USING host_id::BIGINT;
--
--  Cambiar tipo de dato de last_scraped de la tabla listing_prepared
ALTER TABLE listing_prepared
ALTER COLUMN last_scraped TYPE DATE USING (last_scraped::DATE);
--
--  Cambiar tipo de dato de host_since de la tabla listing_prepared
ALTER TABLE listing_prepared
ALTER COLUMN host_since TYPE DATE USING (host_since::DATE);

--  Cambiar tipo de dato de host_response_rate de la tabla listing_prepare
--  Paso 1: Agregar una nueva columna con el tipo de dato apropiado (numérico)
ALTER TABLE listing_prepared ADD COLUMN new_host_response_rate NUMERIC;
--
--  Paso 2: Actualizar la nueva columna basado en los valores de la columna original
UPDATE listing_prepared SET new_host_response_rate =
	CASE
		WHEN host_response_rate = 'N/A' THEN NULL
		ELSE CAST(REPLACE(host_response_rate, '%', '') AS NUMERIC) / 100
	END;
--
--  Paso 3: Eliminar la columna antigua
ALTER TABLE listing_prepared DROP COLUMN host_response_rate;
--
--  Paso 4: Renombrar la nueva columna al nombre original
ALTER TABLE listing_prepared RENAME COLUMN new_host_response_rate TO host_response_rate;
--
--  Cambiar tipo de dato de host_acceptance_rate de la tabla listing_prepare
--  Paso 1: Agregar una nueva columna con el tipo de dato apropiado (numérico)
ALTER TABLE listing_prepared ADD COLUMN new_host_acceptance_rate NUMERIC;
--
--  Paso 2: Actualizar la nueva columna basado en los valores de la columna original
UPDATE listing_prepared SET new_host_acceptance_rate =
	CASE
		WHEN host_acceptance_rate = 'N/A' THEN NULL
		ELSE CAST(REPLACE(host_acceptance_rate, '%', '') AS NUMERIC) / 100
	END;
--
--  Paso 3: Eliminar la columna antigua
ALTER TABLE listing_prepared DROP COLUMN host_acceptance_rate;
--
--  Paso 4: Renombrar la nueva columna al nombre original
ALTER TABLE listing_prepared RENAME COLUMN new_host_acceptance_rate TO host_acceptance_rate;
--
--  Cambiar tipo de dato de host_is_superhost de la tabla listing_prepare
--  Paso 1: Agregar una nueva columna BOOLEAN
ALTER TABLE listing_prepared ADD COLUMN new_host_is_superhost BOOLEAN;
--
--  Paso 2: Actualizar la nueva columna basado en los valores de la columna original
UPDATE listing_prepared SET new_host_is_superhost =
	CASE
		WHEN host_is_superhost = 't' THEN TRUE
		WHEN host_is_superhost = 'f' THEN FALSE
		WHEN host_is_superhost IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Manejar valores inesperados configurándolos como NULL
	END;
--
--  Paso 3: Eliminar la columna antigua
ALTER TABLE listing_prepared DROP COLUMN host_is_superhost;
--
--  Paso 4: Renombrar la nueva columna al nombre original
ALTER TABLE listing_prepared RENAME COLUMN new_host_is_superhost TO host_is_superhost;
--
--  Cambiar tipo de dato de host_verifications de la tabla listing_prepare
ALTER TABLE listing_prepared
ALTER COLUMN host_verifications
TYPE TEXT[]
USING ARRAY[REPLACE(REPLACE(host_verifications, '[', ''), ']', '')];
--
--  Cambiar tipo de dato de host_has_profile_pic de la tabla listing_prepare
--  Paso 1: Agregar una nueva columna BOOLEAN
ALTER TABLE listing_prepared ADD COLUMN new_host_has_profile_pic BOOLEAN;
--
--  Paso 2: Actualizar la nueva columna basado en los valores de la columna original
UPDATE listing_prepared SET new_host_has_profile_pic =
	CASE
		WHEN host_has_profile_pic = 't' THEN TRUE
		WHEN host_has_profile_pic = 'f' THEN FALSE
		WHEN host_has_profile_pic IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Manejar valores inesperados configurándolos como NULL
	END;
--
--  Paso 3: Eliminar la columna antigua
ALTER TABLE listing_prepared DROP COLUMN host_has_profile_pic;
--
--  Paso 4: Renombrar la nueva columna al nombre original
ALTER TABLE listing_prepared RENAME COLUMN new_host_has_profile_pic TO host_has_profile_pic;
--
--  Cambiar tipo de dato de host_identity_verified de la tabla listing_prepare
--  Paso 1: Agregar una nueva columna BOOLEAN
ALTER TABLE listing_prepared ADD COLUMN new_host_identity_verified BOOLEAN;
--
--  Paso 2: Actualizar la nueva columna basado en los valores de la columna original
UPDATE listing_prepared SET new_host_identity_verified =
	CASE
		WHEN host_identity_verified = 't' THEN TRUE
		WHEN host_identity_verified = 'f' THEN FALSE
		WHEN host_identity_verified IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Manejar valores inesperados configurándolos como NULL
	END;
--
--  Paso 3: Eliminar la columna antigua
ALTER TABLE listing_prepared DROP COLUMN host_identity_verified;
--
--  Paso 4: Renombrar la nueva columna al nombre original
ALTER TABLE listing_prepared RENAME COLUMN new_host_identity_verified TO host_identity_verified;
--
--  Cambiar tipo de dato de amenities de la tabla listing_prepare
ALTER TABLE listing_prepared
ALTER COLUMN amenities
TYPE TEXT[]
USING ARRAY[REPLACE(REPLACE(amenities, '[', ''), ']', '')];
--
--  Cambiar tipo de dato de price de la tabla listing_prepare
ALTER TABLE listing_prepared
ALTER COLUMN price
TYPE NUMERIC(10, 2)
USING REPLACE(SUBSTR(price, 2), ',', '')::NUMERIC(10,2);
--
-- Cambiar tipo de dato de calendar_updated de la tabla listing_prepared
ALTER TABLE listing_prepared
ALTER COLUMN calendar_updated TYPE DATE USING (calendar_updated::DATE);
--
--  Cambiar tipo de dato de has_availability de la tabla listing_prepare
--
--  Paso 1: Agregar una nueva columna BOOLEAN
ALTER TABLE listing_prepared ADD COLUMN new_has_availability BOOLEAN;
--
--  Paso 2: Actualizar la nueva columna basado en los valores de la columna original
UPDATE listing_prepared SET new_has_availability =
	CASE
		WHEN has_availability = 't' THEN TRUE
		WHEN has_availability = 'f' THEN FALSE
		WHEN has_availability IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Manejar valores inesperados configurándolos como NULL
	END;
--
--  Paso 3: Eliminar la columna antigua
ALTER TABLE listing_prepared DROP COLUMN has_availability;
--
--  Paso 4: Renombrar la nueva columna al nombre original
ALTER TABLE listing_prepared RENAME COLUMN new_has_availability TO has_availability;
--
-- Cambiar tipo de dato de calendar_last_scraped de la tabla listing_prepared
ALTER TABLE listing_prepared
ALTER COLUMN calendar_last_scraped TYPE DATE USING (calendar_last_scraped::DATE);
--
-- Cambiar tipo de dato de first_review de la tabla listing_prepared
ALTER TABLE listing_prepared
ALTER COLUMN first_review TYPE DATE USING (first_review::DATE);
--
-- Cambiar tipo de dato de last_review de la tabla listing_prepared
ALTER TABLE listing_prepared
ALTER COLUMN last_review TYPE DATE USING (last_review::DATE);
--
--  Cambiar tipo de dato de instant_bookable de la tabla listing_prepare
--  Paso 1: Agregar una nueva columna BOOLEAN
ALTER TABLE listing_prepared ADD COLUMN new_instant_bookable BOOLEAN;
--
--  Paso 2: Actualizar la nueva columna basado en los valores de la columna original
UPDATE listing_prepared SET new_instant_bookable =
	CASE
		WHEN instant_bookable = 't' THEN TRUE
		WHEN instant_bookable = 'f' THEN FALSE
		WHEN instant_bookable IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Manejar valores inesperados configurándolos como NULL
	END;
--
--  Paso 3: Eliminar la columna antigua
ALTER TABLE listing_prepared DROP COLUMN instant_bookable;
--
--  Paso 4: Renombrar la nueva columna al nombre original
ALTER TABLE listing_prepared RENAME COLUMN new_instant_bookable TO instant_bookable;
--
--  Cambiar tipo de dato de listing_id de la tabla calendar_prepared
ALTER TABLE calendar_prepared
ALTER COLUMN listing_id TYPE BIGINT USING listing_id::BIGINT;
--
--  Cambiar tipo de dato de date de la tabla calendar
ALTER TABLE calendar_prepared
ALTER COLUMN date TYPE DATE USING (date::DATE);
--
--  Cambiar tipo de dato de available de la tabla calendar_prepared
--  Paso 1: Agregar una nueva columna BOOLEAN
ALTER TABLE calendar_prepared ADD COLUMN new_available BOOLEAN;
--
--  Paso 2: Actualizar la nueva columna basado en los valores de la columna original
UPDATE calendar_prepared SET new_available =
	CASE
		WHEN available = 't' THEN TRUE
		WHEN available = 'f' THEN FALSE
		WHEN available IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Manejar valores inesperados configurándolos como NULL
	END;
--
--  Paso 3: Eliminar la columna antigua
ALTER TABLE calendar_prepared DROP COLUMN available;
--
--  Paso 4: Renombrar la nueva columna al nombre original
ALTER TABLE calendar_prepared RENAME COLUMN new_available TO available;
--
--  Cambiar tipo de dato de price de la tabla calendar_prepared
ALTER TABLE calendar_prepared
	ALTER COLUMN price
TYPE NUMERIC(10, 2)
USING REPLACE(SUBSTR(price, 2), ',', '')::NUMERIC(10,2);
--
--  Cambiar tipo de dato de listing_id de la tabla review_prepared
ALTER TABLE review_prepared
ALTER COLUMN listing_id TYPE BIGINT USING listing_id::BIGINT;
--
--  Cambiar tipo de dato de id de la tabla review_prepared
ALTER TABLE review_prepared
ALTER COLUMN id TYPE BIGINT USING id::BIGINT;
--
-- Cambiar tipo de dato de date de la tabla calendar
ALTER TABLE review_prepared
ALTER COLUMN date TYPE DATE USING (date::DATE);
--
--  Cambiar tipo de dato de reviewer_id de la tabla review_prepared
ALTER TABLE review_prepared
ALTER COLUMN reviewer_id TYPE BIGINT USING reviewer_id::BIGINT;