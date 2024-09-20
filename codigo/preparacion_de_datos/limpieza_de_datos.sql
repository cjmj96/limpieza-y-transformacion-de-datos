-- Identificar valores únicos de property_type para determinar
-- su validez y precisión (tabla listing_prepared)
SELECT DISTINCT property_type
FROM listing_prepared;

-- Identificar valores únicos de room_type para determinar
-- su validez y precisión (tabla listing_prepared)
SELECT DISTINCT room_type
FROM listing_prepared;

-- Identificar valores únicos de host_response_time para determinar
-- su validez y precisión (tabla listing_prepared)
SELECT DISTINCT host_response_time
FROM listing_prepared;

-- Asegurar validez y precisión de los valores de host_response_time
-- (tabla listing_prepared)
UPDATE listing_prepared
SET host_response_time = NULL
WHERE host_response_time = 'N/A';

-- Identificar valores únicos de host_neighbourhood para determinar
-- su validez y precisión (tabla listing_prepared)
SELECT DISTINCT host_neighbourhood
FROM listing_prepared;

-- Transformar datos para asegurar validez y precisión de los valores de host_neighbourhood
--  Paso 1: Crear una Tabla de Referencia para Nombres Estándar de Barrios
CREATE TABLE standard_neighborhoods (
    id SERIAL PRIMARY KEY,
    neighborhood_name VARCHAR(100) UNIQUE NOT NULL
);

--  Insertar los nombres estándar de barrios en esta tabla
INSERT INTO standard_neighborhoods (neighborhood_name)
VALUES
    ('Allston'),
    ('Back Bay'),
    ('Bay Vilage'),
	('Beacon Hill'),
	('Brighton'),
	('Charlestown'),
	('Chinatown-Leather District'),
	('Dorchester'),
	('Downtown'),
	('East Boston'),
	('Fenway-Kenmore'),
	('Hyde Park'),
	('Jamaica Plain'),
	('Mattapan'),
	('Mid-Dorchester'),
	('Mission Hill'),
	('North End'),
	('Roslindale'),
	('Roxbury'),
	('South Boston'),
	('South End'),
	('West End'),
	('West Roxbury'),
	('Wharf District');

-- Paso 2: Crear una Tabla de Mapeo para Variantes
CREATE TABLE neighborhood_mappings (
    variant_name TEXT PRIMARY KEY,
    standard_name TEXT NOT NULL REFERENCES standard_neighborhoods(neighborhood_name)
);

--  Insertar los mapeos en esta tabla
INSERT INTO neighborhood_mappings (variant_name, standard_name)
VALUES
  ('West Yarmouth', 'Brighton'),
  ('Valley Village', 'Roxbury'),
  ('Malden', 'East Boston'),
  ('Allston-Brighton', 'Brighton'),
  ('City Point', 'South Boston'),
  ('Jeffries Point', 'East Boston'),
  ('North Falmouth', 'South Boston'),
  ('Rockport', 'Charlestown'),
  ('Paradise Valley Village', 'Beacon Hill'),
  ('D Street / West Broadway', 'South Boston'),
  ('Chestnut Hill', 'West Roxbury'),
  ('Wellington-Harrington', 'Allston'),
  ('Franklin Field South', 'Dorchester'),
  ('South Medford', 'Dorchester'),
  ('East Falmouth', 'Roslindale'),
  ('Vineyard Haven', 'Beacon Hill'),
  ('Bowdoin North / Mount Bowdoin',  'Dorchester'),
  ('Codman Square', 'Dorchester'),
  ('Spring Hill', 'Roslindale'),
  ('Theater District', 'Downtown'),
  ('Oak Square', 'Brighton'),
  ('Brook Farm', 'Roslindale'),
  ('West Fens', 'Fenway-Kenmore'),
  ('Waban', 'Brighton'),
  ('Harwich Port', 'Charlestown'),
  ('Ward Two', 'East Boston'),
  ('Wellington Hill', 'Mattapan'),
  ('Fort Point', 'South Boston'),
  ('Columbus Park / Andrew Square', 'South Boston'),
  ('Eagle Hill', 'East Boston'),
  ('Newton Highlands', 'Beacon Hill'),
  ('East Otis', 'South Boston'),
  ('Hell''s Kitchen', 'Chinatown-Leather District'),
  ('Sun Bay South', 'Brighton'),
  ('Peoplestown', 'South Boston'),
  ('Islington', 'Allston'),
  ('Fairmount Hill', 'Hyde Park'),
  ('Blackstone Boulevard Realty Plat Historic District', 'Jamaica Plain'),
  ('Cape Neddick', 'Jamaica Plain'),
  ('Brewster', 'Jamaica Plain'),
  ('Cambridgeport', 'Beacon Hill'),
  ('Gateway District', 'Downtown'),
  ('Boston Theater District', 'Downtown'),
  ('Newton', 'Fenway-Kenmore'),
  ('Popponesset', 'Fenway-Kenmore'),
  ('Cambridge', 'West End'),
  ('Nolita', 'Charlestown'),
  ('East Somerville', 'Charlestown'),
  ('Back Bay West', 'Roxbury'),
  ('Watertown', 'Fenway-Kenmore'),
  ('Dudley / Brunswick King', 'Dorchester'),
  ('Downtown Crossing', 'Chinatown-Leather District'),
  ('Cedar Grove', 'Dorchester'),
  ('Southern Mattapan', 'Mattapan'),
  ('Orient Heights', 'East Boston'),
  ('Noe Valley', 'West Roxbury'),
  ('Lower Washington / Mount Hope', 'Roslindale'),
  ('Barney Circle', 'North End'),
  ('Belmar', 'Fenway-Kenmore'),
  ('Dennis Port', 'Dorchester'),
  ('Boylston Street', 'Jamaica Plain'),
  ('Mid-Cambridge', 'Brighton'),
  ('Brookline', 'Brighton'),
  ('Financial District', 'Downtown'),
  ('Riverside', 'Dorchester'),
  ('Longwood Medical and Academic Area', 'Fenway-Kenmore'),
  ('Burbank Gardens Neighborhood Association', 'Charlestown'),
  ('South Scottsdale', 'Jamaica Plain'),
  ('Metropolitan Hill / Beech Street', 'Roslindale'),
  ('Fenway/Kenmore', 'Fenway-Kenmore'),
  ('Chinatown', 'Chinatown-Leather District'),
  ('Coolidge Corner', 'Fenway-Kenmore'),
  ('South Beach', 'Jamaica Plain'),
  ('Stony Brook / Cleary Square', 'Hyde Park'),
  ('South Sanford', 'South Boston'),
  ('Franklin Field North', 'Dorchester'),
  ('Newport East', 'Mission Hill'),
  ('Leather District', 'Downtown'),
  ('East Downtown', 'Back Bay'),
  ('Harbor View / Orient Heights', 'East Boston'),
  ('Midtown - Downtown', 'South Boston'),
  ('Medford Street / The Neck', 'Charlestown'),
  ('White Rock East', 'North End'),
  ('Williamsburg', 'Brighton'),
  ('Prudential / St. Botolph', 'Back Bay'),
  ('Lower Allston', 'Allston'),
  ('Harvard Square', 'Beacon Hill'),
  ('Tribeca', 'South Boston'),
  ('Whitney', 'Roxbury'),
  ('Upper East Side', 'Downtown'),
  ('Central City', 'Dorchester'),
  ('Commonwealth', 'Allston'),
  ('Hawthorne', 'Roxbury'),
  ('Redondo Beach', 'Charlestown'),
  ('West Street / River Street', 'Hyde Park'),
  ('St. Elizabeth''s', 'Brighton'),
  ('Dorchester Center', 'Dorchester'),
  ('Government Center', 'Beacon Hill'),
  ('Wanskuck', 'Dorchester');

--  Paso 3: Actualizar la columna host_neighborhood
UPDATE listing_prepared AS lp
SET host_neighbourhood = nm.standard_name
FROM neighborhood_mappings AS nm
WHERE lp.host_neighbourhood = nm.variant_name;

-- Paso 4: Verificar la actualización
SELECT DISTINCT host_neighborhood
FROM listing_prepared
ORDER BY host_neighborhood;

-- Crear CTE que contiene Q1, Q3 e IQR para la columna price en la tabla calendar_prepared
WITH central_tendency_measures_price_calendar_prepared_cte AS (
	SELECT PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY price) AS Q1_price,
	  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY price) AS Q3_price
	  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY price) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY price) AS IQR_price
	FROM calendar_prepared
);

-- Crear CTE que contiene Q1, Q3 e IQR para la columna minimum_nights en la tabla listing_prepared
WITH central_tendency_measures_minimum_nights_listing_prepared_cte AS (
    SELECT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY minimum_nights) AS Q1_minimum_nights,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY minimum_nights) AS Q3_minimum_nights,
        ((PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY minimum_nights)) - (PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY minimum_nights))) AS IQR_minimum_nights
    FROM listing_prepared
),
-- Crear CTE que contiene Q1, Q3 e IQR para la columna maximum_nights en la tabla listing_prepared
central_tendency_measures_maximum_nights_listing_prepared_cte AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY maximum_nights) AS Q1_maximum_nights,
      PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY maximum_nights) AS Q3_maximum_nights,
      ((PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY maximum_nights)) - (PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY maximum_nights))) AS IQR_maximum_nights
    FROM listing_prepared
),
-- Crear CTE que contiene Q1, Q3 e IQR para la columna price en la tabla listing_prepared
central_tendency_measures_price_listing_prepared_cte AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS Q1_price,
      PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS Q3_price,
      ((PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price)) - (PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price))) AS IQR_price
    FROM listing_prepared
)

-- Reparar datos en la tabla listing_prepared usando limpieza de datos basada en reglas
SELECT *
INTO listing_prepared_cleaned
FROM listing_prepared lp
WHERE
  -- Asegurar validez de host_listings_count
  lp.host_listings_count > 0
  -- Asegurar validez de host_total_listings_count
  AND lp.host_total_listings_count > 0
  -- Asegurar validez de latitude
  AND (lp.latitude BETWEEN 42.227859 AND 42.397259)
  -- Asegurar validez de longitude
  AND (lp.longitude BETWEEN -71.191208 AND -70.923042)
  -- Asegurar validez de accommodates
  AND lp.accommodates > 0
  -- Asegurar validez de bathrooms
  AND lp.bathrooms > 0
  -- Asegurar validez de bedrooms
  AND lp.bedrooms > 0
  -- Asegurar validez de beds
  AND lp.beds > 0
  -- Asegurar validez de price usando el método IQR para detección de valores atípicos
  AND lp.price BETWEEN ((SELECT Q1_price FROM central_tendency_measures_price_listing_prepared_cte) - 1.5 * (SELECT IQR_price FROM central_tendency_measures_price_listing_prepared_cte)) AND ((SELECT Q3_price FROM central_tendency_measures_price_listing_prepared_cte) + 1.5 * (SELECT IQR_price FROM central_tendency_measures_price_listing_prepared_cte))
  -- Asegurar actualidad de los datos
  AND (lp.calendar_last_scraped BETWEEN '2024-03-24' AND '2024-03-25')
  -- Asegurar validez de number_of_reviews
  AND lp.number_of_reviews >= 0
  -- Asegurar validez de number_of_reviews_ltm
  AND lp.number_of_reviews_ltm >= 0
  -- Asegurar validez de number_of_reviews_l30d
  AND lp.number_of_reviews_l30d >= 0
  -- Asegurar validez de first_review
  AND (lp.first_review BETWEEN '2008-08-01' AND '2024-03-24')
  -- Asegurar validez de last_review
  AND (lp.last_review BETWEEN '2008-08-01' AND '2024-03-24')
  -- Asegurar validez de review_scores_rating
  AND (lp.review_scores_rating BETWEEN 0 AND 5)
  -- Asegurar validez de reviews_per_month
  AND lp.reviews_per_month >= 0
  -- Asegurar validez de host_response_rate
  AND lp.host_response_rate BETWEEN 0 AND 1
  -- Asegurar validez de host_acceptance_rate
  AND lp.host_acceptance_rate BETWEEN 0 AND 1
  -- Asegurar validez de minimum_nights usando el método IQR para detección de valores atípicos
  AND lp.minimum_nights BETWEEN ((SELECT Q1_minimum_nights FROM central_tendency_measures_minimum_nights_listing_prepared_cte) - 1.5 * (SELECT IQR_minimum_nights FROM central_tendency_measures_minimum_nights_listing_prepared_cte)) AND ((SELECT Q3_minimum_nights FROM central_tendency_measures_minimum_nights_listing_prepared_cte) + 1.5 * (SELECT IQR_minimum_nights FROM central_tendency_measures_minimum_nights_listing_prepared_cte))
  -- Asegurar validez de maximum_nights usando el método IQR para detección de valores atípicos
  AND lp.maximum_nights BETWEEN ((SELECT Q1_maximum_nights FROM central_tendency_measures_maximum_nights_listing_prepared_cte) - 1.5 * (SELECT IQR_maximum_nights FROM central_tendency_measures_maximum_nights_listing_prepared_cte)) AND ((SELECT Q3_maximum_nights FROM central_tendency_measures_maximum_nights_listing_prepared_cte) + 1.5 * (SELECT IQR_maximum_nights FROM central_tendency_measures_maximum_nights_listing_prepared_cte));

-- Identificar datos duplicados en la tabla listing_prepared_cleaned
SELECT id, COUNT(*)
FROM listing_prepared_cleaned
GROUP BY id
HAVING COUNT(*) > 1;

-- Identificar y contar valores faltantes en la tabla listing_prepared_cleaned
SELECT
  COUNT(*) FILTER (WHERE id IS NULL) AS id_nulls,
  COUNT(*) FILTER (WHERE name IS NULL) AS name_nulls,
  COUNT(*) FILTER (WHERE host_id IS NULL) AS host_id_nulls,
  COUNT(*) FILTER (WHERE host_name IS NULL) AS host_name_nulls,
  COUNT(*) FILTER (WHERE host_response_time IS NULL) AS host_response_time_nulls,
  COUNT(*) FILTER (WHERE host_response_rate IS NULL) AS host_response_rate_nulls,
  COUNT(*) FILTER (WHERE host_acceptance_rate IS NULL) AS host_acceptance_rate_nulls,
  COUNT(*) FILTER (WHERE host_is_superhost IS NULL) AS host_is_superhost_nulls,
  COUNT(*) FILTER (WHERE host_neighbourhood IS NULL) AS host_neighbourhood_nulls,
  COUNT(*) FILTER (WHERE host_listings_count IS NULL) AS host_listings_count_nulls,
  COUNT(*) FILTER (WHERE host_total_listings_count IS NULL) AS host_total_listings_count_nulls,
  COUNT(*) FILTER (WHERE latitude IS NULL) AS latitude_nulls,
  COUNT(*) FILTER (WHERE longitude IS NULL) AS longitude_nulls,
  COUNT(*) FILTER (WHERE property_type IS NULL) AS property_type_nulls,
  COUNT(*) FILTER (WHERE room_type  IS NULL) AS room_type_nulls,
  COUNT(*) FILTER (WHERE accommodates  IS NULL) AS accommodates_nulls,
  COUNT(*) FILTER (WHERE bathrooms IS NULL) AS bathrooms_nulls,
  COUNT(*) FILTER (WHERE bedrooms IS NULL) AS bedrooms_nulls,
  COUNT(*) FILTER (WHERE beds IS NULL) AS beds_nulls,
  COUNT(*) FILTER (WHERE amenities IS NULL) AS amenities_nulls,
  COUNT(*) FILTER (WHERE price IS NULL) AS price_nulls,
  COUNT(*) FILTER (WHERE minimum_nights IS NULL) AS minimum_nights_nulls,
  COUNT(*) FILTER (WHERE maximum_nights IS NULL) AS maximum_nights_nulls,
  COUNT(*) FILTER (WHERE calendar_last_scraped IS NULL) AS calendar_last_scraped_nulls,
  COUNT(*) FILTER (WHERE has_availability IS NULL) AS has_availability_nulls,
  COUNT(*) FILTER (WHERE number_of_reviews IS NULL) AS number_of_reviews_nulls,
  COUNT(*) FILTER (WHERE number_of_reviews_ltm IS NULL) AS number_of_reviews_ltm_nulls,
  COUNT(*) FILTER (WHERE number_of_reviews_l30d IS NULL) AS number_of_reviews_l30d_nulls,
  COUNT(*) FILTER (WHERE first_review IS NULL) AS first_review_nulls,
  COUNT(*) FILTER (WHERE last_review IS NULL) AS last_review_nulls,
  COUNT(*) FILTER (WHERE review_scores_rating IS NULL) AS review_scores_rating_nulls,
  COUNT(*) FILTER (WHERE reviews_per_month IS NULL) AS reviews_per_month_nulls
FROM listing_prepared_cleaned;

-- Rellenar valores faltantes en la columna host_neighbourhood
UPDATE listing_prepared_cleaned
SET host_neighbourhood = CASE
    WHEN id = 633889528816089164 AND host_neighbourhood IS NULL THEN 'Fenway-Kenmore'
	WHEN id = 18305618 AND host_neighbourhood IS NULL THEN 'Hyde Park'
	WHEN id = 29739809  AND host_neighbourhood IS NULL THEN 'South End'
	WHEN id = 13797162  AND host_neighbourhood IS NULL THEN 'Roxbury'
	WHEN id = 6609546  AND host_neighbourhood IS NULL THEN 'Downtown'
	WHEN id = 6248970  AND host_neighbourhood IS NULL THEN 'Jamaica Plain'
	WHEN id = 8483020  AND host_neighbourhood IS NULL THEN 'Hyde Park'
	WHEN id = 28912741  AND host_neighbourhood IS NULL THEN 'South Boston'
	WHEN id = 5782221  AND host_neighbourhood IS NULL THEN 'South Boston'
	WHEN id = 6914622  AND host_neighbourhood IS NULL THEN 'Jamaica Plain'
	WHEN id = 8170181  AND host_neighbourhood IS NULL THEN 'Beacon Hill'
	WHEN id = 10132073  AND host_neighbourhood IS NULL THEN 'East Boston'
	WHEN id = 16892278  AND host_neighbourhood IS NULL THEN 'Roslindale'
	WHEN id = 17523133  AND host_neighbourhood IS NULL THEN 'Dorchester'
	WHEN id = 19373388  AND host_neighbourhood IS NULL THEN 'Dorchester'
	WHEN id = 24971621  AND host_neighbourhood IS NULL THEN 'West Roxbury'
	WHEN id = 28915006  AND host_neighbourhood IS NULL THEN 'East Boston'
	WHEN id = 29082416  AND host_neighbourhood IS NULL THEN 'Brighton'
	WHEN id = 34936983  AND host_neighbourhood IS NULL THEN 'Brighton'
	WHEN id = 36622810  AND host_neighbourhood IS NULL THEN 'Charlestown'
	WHEN id = 40439006  AND host_neighbourhood IS NULL THEN 'Dorchester'
	WHEN id = 40348580  AND host_neighbourhood IS NULL THEN 'Downtown'
    WHEN id = 1066879803257359794 AND host_neighbourhood IS NULL THEN 'East Boston'
    ELSE host_neighbourhood
END;

-- Realizar análisis de casos completos (CCA) para la columna host_is_superhost
SELECT *
INTO listing_cleaned
FROM listing_prepared_cleaned lpc
WHERE
  host_is_superhost IS NOT NULL;

-- Crear CTE que contiene Q1, Q3 e IQR para la columna price en la tabla calendar_prepared
WITH central_tendency_measures_price_calendar_prepared_cte AS (
	SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS Q1_price,
	  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS Q3_price,
	  ((PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price)) - (PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY price))) AS IQR_price
	FROM calendar_prepared
)

-- Reparar datos en la tabla calendar_prepared usando limpieza de datos basada en reglas
SELECT *
INTO calendar_prepared_cleaned
FROM calendar_prepared cp
WHERE
  -- Asegurar validez de date
  cp.date BETWEEN '2024-03-24' AND '2025-03-24'
  -- Asegurar validez de price usando el método IQR para detección de valores atípicos
  AND cp.price BETWEEN ((SELECT Q1_price FROM central_tendency_measures_price_calendar_prepared_cte) - 1.5 * (SELECT IQR_price FROM central_tendency_measures_price_calendar_prepared_cte)) AND ((SELECT Q3_price FROM central_tendency_measures_price_calendar_prepared_cte) + 1.5 * (SELECT IQR_price FROM central_tendency_measures_price_calendar_prepared_cte));

-- Reparar datos en la tabla review_prepared usando limpieza de datos basada en reglas
SELECT *
INTO review_prepared_cleaned
FROM review_prepared rp
WHERE
  -- Asegurar validez de date
  rp.date BETWEEN '2008-08-01' AND '2024-03-24';

-- Identificar datos duplicados en la tabla listing_prepared_cleaned
SELECT id, COUNT(*)
FROM review_prepared
GROUP BY id
HAVING COUNT(*) > 1;