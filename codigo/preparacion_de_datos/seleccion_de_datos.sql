-- Filtrar datos en columnas (tabla listing_prepared)
ALTER TABLE listing_prepared
DROP COLUMN description,
DROP COLUMN picture_url,
DROP COLUMN host_url,
DROP COLUMN host_about,
DROP COLUMN host_picture_url,
DROP COLUMN listing_url,
DROP COLUMN last_scraped,
DROP COLUMN calendar_updated,
DROP COLUMN scrape_id,
DROP COLUMN source,
DROP COLUMN neighborhood_overview,
DROP COLUMN host_since,
DROP COLUMN host_location,
DROP COLUMN host_thumbnail_url,
DROP COLUMN host_verifications,
DROP COLUMN host_has_profile_pic,
DROP COLUMN host_identity_verified,
DROP COLUMN neighbourhood,
DROP COLUMN neighbourhood_cleansed,
DROP COLUMN neighbourhood_group_cleansed,
DROP COLUMN bathrooms_text,
DROP COLUMN minimum_minimum_nights,
DROP COLUMN maximum_minimum_nights,
DROP COLUMN minimum_maximum_nights,
DROP COLUMN maximum_maximum_nights,
DROP COLUMN minimum_nights_avg_ntm,
DROP COLUMN maximum_nights_avg_ntm,
DROP COLUMN availability_30,
DROP COLUMN availability_60,
DROP COLUMN availability_90,
DROP COLUMN availability_365,
DROP COLUMN review_scores_accuracy,
DROP COLUMN review_scores_cleanliness,
DROP COLUMN review_scores_checkin,
DROP COLUMN review_scores_communication,
DROP COLUMN review_scores_location,
DROP COLUMN review_scores_value,
DROP COLUMN license,
DROP COLUMN instant_bookable,
DROP COLUMN calculated_host_listings_count,
DROP COLUMN calculated_host_listings_count_entire_homes,
DROP COLUMN calculated_host_listings_count_private_rooms,
DROP COLUMN calculated_host_listings_count_shared_rooms;

-- Filtrar datos en columnas (tabla calendar_prepared)
ALTER TABLE calendar_prepared
DROP COLUMN adjusted_price,
DROP COLUMN minimum_nights,
DROP COLUMN maximum_nights;

--  Filtrar datos en columnas (tabla review_prepared)
ALTER TABLE review_prepared
DROP COLUMN reviewer_name,
DROP COLUMN comments;