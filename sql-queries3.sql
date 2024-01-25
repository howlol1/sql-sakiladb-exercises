USE sakila;



-- 1. Average rental duration for each customer.
SELECT c.customer_id, c.first_name, c.last_name, AVG(DATEDIFF(r.return_date, r.rental_date))
FROM customer c 
JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id;

-- 2. Most popular actor by number of rentals.
SELECT a.actor_id, a.first_name, a.last_name, COUNT(r.rental_id) as rental_count
FROM rental r 
JOIN inventory i on r.inventory_id = i.inventory_id
JOIN film_actor fa on fa.film_id = i.film_id
JOIN actor a on fa.actor_id = a.actor_id
GROUP BY a.actor_id
ORDER BY rental_count DESC;

-- 3. Top 3 longest films from each category.

SELECT category_name, film_title, film_length
FROM (
    SELECT c.name as category_name, f.title as film_title, f.length as film_length,
    ROW_NUMBER() OVER(PARTITION BY c.name ORDER BY f.length DESC) as row_num
    FROM film f 
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c on c.category_id = fc.category_id) as subquery
WHERE row_num <= 3;

-- 4. Total revenue of each store.
SELECT s.store_id, SUM(p.amount)
FROM payment p 
JOIN staff stf ON p.staff_id = stf.staff_id
JOIN store s ON stf.store_id = s.store_id
GROUP BY s.store_id;

    
-- 5. Date diff between first and last rentals of each customer.
SELECT customer_id, 
       DATEDIFF(MAX(rental_date), MIN(rental_date)) as days_between_rentals
FROM rental
GROUP BY customer_id;



