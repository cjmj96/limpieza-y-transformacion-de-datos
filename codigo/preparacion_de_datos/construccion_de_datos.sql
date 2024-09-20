-- Añadir la columna total_potential_revenue
ALTER TABLE listing_cleaned
ADD COLUMN total_potential_revenue NUMERIC GENERATED ALWAYS AS (365 * price) STORED;