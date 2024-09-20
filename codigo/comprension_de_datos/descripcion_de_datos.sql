--  Listar nombres de columnas y sus tipos de datos para la tabla listing
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'listing';

--  Listar las primeras 5 observaciones de la tabla listing
SELECT *
FROM listing
LIMIT 5;

-- Contar observaciones para la tabla listing
SELECT COUNT(*)
FROM listing;

--  Listar nombres de columnas y sus tipos de datos para la tabla calendar
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'calendar';

-- Listar las primeras 5 observaciones de la tabla calendar
SELECT *
FROM calendar
LIMIT 5;

-- Contar observaciones para la tabla calendar
SELECT COUNT(*)
FROM calendar;

--  Listar nombres de columnas y sus tipos de datos para la tabla review
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'review';

--  Listar las primeras 5 observaciones de la tabla review
SELECT *
FROM review
LIMIT 5;

-- Contar observaciones para la tabla review
SELECT COUNT(*)
FROM review;

-- Contar valores faltantes en cada columna para la tabla listing
SELECT
  COUNT(*) FILTER (WHERE id IS NULL) AS id_nulls,
  COUNT(*) FILTER (WHERE listing_url IS NULL) AS listing_url_nulls,
  COUNT(*) FILTER (WHERE scrape_id IS NULL) AS scrape_id_nulls,
  COUNT(*) FILTER (WHERE last_scraped IS NULL) AS last_scraped_nulls,
  COUNT(*) FILTER (WHERE source IS NULL) AS source_nulls,
  COUNT(*) FILTER (WHERE name IS NULL) AS name_nulls,
  COUNT(*) FILTER (WHERE description IS NULL) AS description_nulls,
  COUNT(*) FILTER (WHERE neighborhood_overview IS NULL) AS neighborhood_overview_nulls,
  COUNT(*) FILTER (WHERE picture_url IS NULL) AS picture_url_nulls,
  COUNT(*) FILTER (WHERE host_id IS NULL) AS host_id_nulls,
  COUNT(*) FILTER (WHERE host_url IS NULL) AS host_url_nulls,
  COUNT(*) FILTER (WHERE host_name IS NULL) AS host_name_nulls,
  COUNT(*) FILTER (WHERE host_since IS NULL) AS host_since_nulls,
  COUNT(*) FILTER (WHERE host_location IS NULL) AS host_location_nulls,
  COUNT(*) FILTER (WHERE host_about IS NULL) AS host_about_nulls,
  COUNT(*) FILTER (WHERE host_response_time IS NULL) AS host_response_time_nulls,
  COUNT(*) FILTER (WHERE host_response_rate IS NULL) AS host_response_rate_nulls,
  COUNT(*) FILTER (WHERE host_acceptance_rate IS NULL) AS host_acceptance_rate_nulls,
  COUNT(*) FILTER (WHERE host_is_superhost IS NULL) AS host_is_superhost_nulls,
  COUNT(*) FILTER (WHERE host_thumbnail_url IS NULL) AS host_thumbnail_url_nulls,
  COUNT(*) FILTER (WHERE host_picture_url IS NULL) AS host_picture_url_nulls,
  COUNT(*) FILTER (WHERE host_neighbourhood IS NULL) AS host_neighbourhood_nulls,
  COUNT(*) FILTER (WHERE host_listings_count IS NULL) AS host_listings_count_nulls,
  COUNT(*) FILTER (WHERE host_total_listings_count IS NULL) AS host_total_listings_count_nulls,
  COUNT(*) FILTER (WHERE host_verifications IS NULL) AS host_verifications_nulls,
  COUNT(*) FILTER (WHERE host_has_profile_pic  IS NULL) AS host_has_profile_pic_nulls,
  COUNT(*) FILTER (WHERE host_identity_verified  IS NULL) AS host_identity_verified_nulls,
  COUNT(*) FILTER (WHERE neighbourhood IS NULL) AS neighbourhood_nulls,
  COUNT(*) FILTER (WHERE neighbourhood_cleansed IS NULL) AS neighbourhood_cleansed_nulls,
  COUNT(*) FILTER (WHERE neighbourhood_group_cleansed  IS NULL) AS neighbourhood_group_cleansed_nulls,
  COUNT(*) FILTER (WHERE latitude IS NULL) AS latitude_nulls,
  COUNT(*) FILTER (WHERE longitude IS NULL) AS longitude_nulls,
  COUNT(*) FILTER (WHERE property_type IS NULL) AS property_type_nulls,
  COUNT(*) FILTER (WHERE room_type  IS NULL) AS room_type_nulls,
  COUNT(*) FILTER (WHERE accommodates  IS NULL) AS accommodates_nulls,
  COUNT(*) FILTER (WHERE bathrooms IS NULL) AS bathrooms_nulls,
  COUNT(*) FILTER (WHERE bathrooms_text IS NULL) AS bathrooms_text_nulls,
  COUNT(*) FILTER (WHERE bedrooms IS NULL) AS bedrooms_nulls,
  COUNT(*) FILTER (WHERE beds IS NULL) AS beds_nulls,
  COUNT(*) FILTER (WHERE amenities IS NULL) AS amenities_nulls,
  COUNT(*) FILTER (WHERE price IS NULL) AS price_nulls,
  COUNT(*) FILTER (WHERE minimum_nights IS NULL) AS minimum_nights_nulls,
  COUNT(*) FILTER (WHERE maximum_nights IS NULL) AS maximum_nights_nulls,
  COUNT(*) FILTER (WHERE minimum_minimum_nights IS NULL) AS minimum_minimum_nights_nulls,
  COUNT(*) FILTER (WHERE maximum_minimum_nights IS NULL) AS maximum_minimum_nights_nulls,
  COUNT(*) FILTER (WHERE minimum_maximum_nights IS NULL) AS minimum_maximum_nights_nulls,
  COUNT(*) FILTER (WHERE maximum_maximum_nights IS NULL) AS maximum_maximum_nights_nulls,
  COUNT(*) FILTER (WHERE minimum_nights_avg_ntm IS NULL) AS minimum_nights_avg_ntm_nulls,
  COUNT(*) FILTER (WHERE maximum_nights_avg_ntm IS NULL) AS maximum_nights_avg_ntm_nulls,
  COUNT(*) FILTER (WHERE calendar_updated IS NULL) AS calendar_updated_nulls,
  COUNT(*) FILTER (WHERE has_availability IS NULL) AS has_availability_nulls,
  COUNT(*) FILTER (WHERE availability_30 IS NULL) AS availability_30_nulls,
  COUNT(*) FILTER (WHERE availability_60 IS NULL) AS availability_60_nulls,
  COUNT(*) FILTER (WHERE availability_90 IS NULL) AS availability_90_nulls,
  COUNT(*) FILTER (WHERE availability_365 IS NULL) AS availability_365_nulls,
  COUNT(*) FILTER (WHERE number_of_reviews IS NULL) AS number_of_reviews_nulls,
  COUNT(*) FILTER (WHERE number_of_reviews_ltm IS NULL) AS number_of_reviews_ltm_nulls,
  COUNT(*) FILTER (WHERE number_of_reviews_l30d IS NULL) AS number_of_reviews_l30d_nulls,
  COUNT(*) FILTER (WHERE first_review IS NULL) AS first_review_nulls,
  COUNT(*) FILTER (WHERE last_review IS NULL) AS last_review_nulls,
  COUNT(*) FILTER (WHERE review_scores_rating IS NULL) AS review_scores_rating_nulls,
  COUNT(*) FILTER (WHERE review_scores_cleanliness IS NULL) AS review_scores_cleanliness_nulls,
  COUNT(*) FILTER (WHERE review_scores_checkin IS NULL) AS review_scores_checkin_nulls,
  COUNT (*)FILTER( WHERE review_scores_communication Is Null )AS review_scores_communication_NULLS ,
COUNT (*)FILTER( WHERE review_scores_location Is Null )AS review_scores_location_NULLS ,
COUNT (*)FILTER( WHERE calculated_host_listings_count Is Null )AS calculated_host_listings_count_NULLS ,
COUNT (*)FILTER( WHERE calculated_host_listings_count_entire_homes Is Null )AS calculated_host_listings_count_entire_homes_NULLS ,
COUNT (*)FILTER( WHERE calculated_host_listings_count_private_rooms Is Null )AS calculated_host_listings_count_private_rooms_NULLS ,
COUNT (*)FILTER( WHERE calculated_host_listings_count_shared_rooms Is Null )AS calculated_host_listings_count_shared_rooms_NULLS ,
COUNT (*)FILTER( WHERE reviews_per_month Is Null )AS reviews_per_month_NULLS 
FROM listing;

-- Contar valores faltantes en cada columna para la tabla calendar
SELECT
COUNT (*)FILTER( WHERE listing_id Is Null )AS listing_id_NULLS ,
COUNT (*)FILTER( WHERE date Is Null )AS date_NULLS ,
COUNT (*)FILTER( WHERE available Is Null )AS available_NULLS ,
COUNT (*)FILTER( WHERE price Is Null )AS price_NULLS ,
COUNT (*)FILTER( WHERE adjusted_price Is Null )AS adjusted_price_NULLS ,
COUNT (*)FILTER( WHERE minimum_nights Is Null )AS minimum_nights_NULLS ,
COUNT (*)FILTER( WHERE maximum_nights Is Null )AS maximum_nights_NULLS 
FROM calendar;

-- Contar valores faltantes en cada columna para la tabla review
SELECT
COUNT (*)FILTER( WHERE listing_id Is Null )AS listing_id_NULLS ,
COUNT (*)FILTER( WHERE id Is Null )AS id_NULLS ,
COUNT (*)FILTER( WHERE date Is Null )AS date_NULLS ,
COUNT (*)FILTER( WHERE reviewer_id Is Null )AS reviewer_id_NULLS ,
COUNT (*)FILTER( WHERE reviewer_name Is Null )AS reviewer_name_NULLS ,
COUNT (*)FILTER( WHERE comments Is Null )AS comments_NULLS 
FROM review;