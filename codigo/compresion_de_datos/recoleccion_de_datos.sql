-- Crear tabla listing
CREATE TABLE listing (
  id TEXT,
  listing_url TEXT,
  scrape_id TEXT,
  last_scraped TEXT,
  source TEXT,
  name TEXT,
  description TEXT,
  neighborhood_overview TEXT,
  picture_url TEXT,
  host_id TEXT,
  host_url TEXT,
  host_name TEXT,
  host_since TEXT,
  host_location TEXT,
  host_about TEXT,
  host_response_time TEXT,
  host_response_rate TEXT,
  host_acceptance_rate TEXT,
  host_is_superhost TEXT,
  host_thumbnail_url TEXT,
  host_picture_url TEXT,
  host_neighbourhood TEXT,
  host_listings_count INTEGER,
  host_total_listings_count INTEGER,
  host_verifications TEXT,
  host_has_profile_pic TEXT,
  host_identity_verified TEXT,
  neighbourhood TEXT,
  neighbourhood_cleansed TEXT,
  neighbourhood_group_cleansed TEXT,
  latitude FLOAT8,
  longitude FLOAT8,
  property_type TEXT,
  room_type TEXT,
  accommodates INTEGER,
  bathrooms FLOAT8,
  bathrooms_text TEXT,
  bedrooms INTEGER,
  beds INTEGER,
  amenities TEXT,
  price TEXT,
  minimum_nights INTEGER,
  maximum_nights INTEGER,
  minimum_minimum_nights INTEGER,
  maximum_minimum_nights INTEGER,
  minimum_maximum_nights INTEGER,
  maximum_maximum_nights INTEGER,
  minimum_nights_avg_ntm FLOAT8,
  maximum_nights_avg_ntm FLOAT8,
  calendar_updated TEXT,
  has_availability TEXT,
  availability_30 INTEGER,
  availability_60 INTEGER,
  availability_90 INTEGER,
  availability_365 INTEGER,
  calendar_last_scraped TEXT,
  number_of_reviews INTEGER,
  number_of_reviews_ltm INTEGER,
  number_of_reviews_l30d INTEGER,
  first_review TEXT,
  last_review TEXT,
  review_scores_rating FLOAT8,
  review_scores_accuracy FLOAT8,
  review_scores_cleanliness FLOAT8,
  review_scores_checkin FLOAT8,
  review_scores_communication FLOAT8,
  review_scores_location FLOAT8,
  review_scores_value FLOAT8,
  license TEXT,
  instant_bookable TEXT,
  calculated_host_listings_count INTEGER,
  calculated_host_listings_count_entire_homes INTEGER,
  calculated_host_listings_count_private_rooms INTEGER,
  calculated_host_listings_count_shared_rooms INTEGER,
  reviews_per_month FLOAT8
);

-- Copiar datos de un archivo CSV
COPY listing
FROM '/tmp/listings.csv'
DELIMITER ',' CSV HEADER;

-- Crear tabla calendar
CREATE TABLE calendar (
  listing_id TEXT,
  date TEXT,
  available TEXT,
  price TEXT,
  adjusted_price TEXT,
  minimum_nights INTEGER,
  maximum_nights INTEGER
);

-- Copiar datos de un archivo CSV
COPY calendar
FROM '/tmp/calendar.csv'
DELIMITER ',' CSV HEADER;

-- Create tabla review
CREATE TABLE review (
  listing_id TEXT,
  id TEXT,
  date TEXT,
  reviewer_id TEXT,
  reviewer_name TEXT,
  comments TEXT
);

-- Copiar datos de un archivo CSV
COPY review
FROM '/tmp/reviews.csv'
DELIMITER ',' CSV HEADER;