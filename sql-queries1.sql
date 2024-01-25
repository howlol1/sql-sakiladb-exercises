USE sakila;

-- Show all tables
SHOW FULL TABLES;

-- Get all customers
SELECT * from customer

-- Select only id, first_name column from actor table.
SELECT a.actor_id, a.first_name
FROM actor a

-- Select only customer_id, email, store_id column from customer table.
SELECT c.customer_id, c.email, store_id 
from customer c;

-- Show how many customers belong to each store.
SELECT c.store_id, COUNT(*) as customer_count
FROM customer c
GROUP BY c.store_id;

-- Show how many films belong to each unique rating.
SELECT rating, COUNT(*) as film_count
FROM film
GROUP BY rating;

-- Find movies that has 'AME' substring in its title.
SELECT film_id, title
FROM film
WHERE title LIKE '%AME%';

-- Get actor first_name and last_name concatenation under column "full_name".
SELECT CONCAT(first_name, " ", last_name) as full_name
from actor;

-- Actors sorted by their first name
SELECT a.first_name, a.last_name
FROM actor a ORDER BY a.first_name;

-- Get films released in 2006.
SELECT f.film_id, f.title, f.release_year
FROM film f
WHERE f.release_year = 2006;

-- Get films released in 2005,2006,2007.
SELECT f.film_id, f.title, f.release_year
FROM film f
WHERE f.release_year BETWEEN 2005 AND 2007;

-- Get all active staff first_name, last_name and email (last name in uppercase)
SELECT s.first_name, UPPER(s.last_name), s.email
FROM staff s
WHERE s.active = 1;

-- Find all rentals that is returned less than a day.
SELECT rental_id, rental_date, return_date, TIMESTAMPDIFF(HOUR, rental_date, return_date) AS rental_hours
FROM rental
WHERE TIMESTAMPDIFF(HOUR, rental_date, return_date) < 24;

-- Calculate Average Film Replacement Cost
SELECT AVG(replacement_cost) AS average_replacement_cost
FROM film;

-- Get films with replacement cost more than average cost.
SELECT film_id, title, replacement_cost
FROM film
WHERE replacement_cost > (SELECT AVG(replacement_cost) FROM film);

-- Find the shortest film name(s).
SELECT title
FROM film
WHERE LENGTH(title) = (SELECT
MIN(LENGTH(title)) FROM film)

-- Total rental duration for all films.
SELECT SUM(rental_duration) FROM film;

-- Get 'PG-13' rating films with rental_rate > 2 and order by descending rental_rate 
SELECT title, rental_rate
FROM film
WHERE rating = 'PG-13' AND rental_rate > 2
ORDER BY rental_rate DESC;

-- Find the length of longest customer full name.   
SELECT MAX(LENGTH(CONCAT(first_name, ' ', last_name)))
FROM customer;

-- Find count of films where special_features is not null.
SELECT COUNT(*) FROM film WHERE special_features IS NOT NULL;

-- Find phone numbers starting with '695' from address table.
SELECT phone
FROM address where phone LIKE '695%';

-- Find addresses without a postal code (empty string or null).
SELECT address 
FROM address 
WHERE postal_code IS NULL OR postal_code = '';

-- Check the total amount of inventory for each film.
SELECT film_id, COUNT(*) AS inventory_count
FROM inventory
GROUP BY film_id;

-- Find the top 10 paying customers.
SELECT customer_id, SUM(amount) AS total_payment
FROM payment
GROUP BY customer_id
ORDER BY total_payment DESC
LIMIT 10;
