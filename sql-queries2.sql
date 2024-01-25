USE sakila;


-- 1. Return the count of films belonging to each category.
SELECT a.category_id, c.name, COUNT(a.film_id) as count_films
from film_category a
join category c ON c.category_id = a.category_id
group by category_id
order by count_films DESC;

-- 2. Return customers with their total payments.
SELECT cust.first_name, cust.last_name, SUM(p.amount) as payment_total
FROM customer cust
JOIN payment p ON cust.customer_id = p.customer_id
GROUP BY cust.customer_id
ORDER BY payment_total DESC;

-- 3. Get actors and the films they acted in.
SELECT a.first_name, a.last_name, f.title 
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id

-- 4.1. List films that have never been rented (The film might not even be in inventory).
SELECT f.title, i.inventory_id, r.rental_id
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE rental_id is NULL;

-- 4.2. List films from inventory that have never been rented 
SELECT f.title, i.inventory_id, r.rental_id
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;

-- 5. Count how many rentals each staff has processed.
SELECT CONCAT(s.first_name, ' ', s.last_name), COUNT(r.rental_id) as rental_count
FROM staff s
JOIN rental r ON r.staff_id = s.staff_id
GROUP BY s.staff_id;

-- 6. Find films rented by a specific customer.
SELECT f.title,r.rental_id, r.rental_date, r.return_date
FROM rental r 
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE r.customer_id = 130;


-- 7. Find actors who acted more than 15 films.
SELECT a.first_name, a.last_name, COUNT(fa.film_id) as actor_film_count
FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id 
HAVING COUNT(fa.film_id) > 15
ORDER BY actor_film_count DESC;

-- 8. Find English movies with category 'Documentary'
SELECT  f.film_id, f.title, c.name, l.name
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON f.film_id = fc.film_id
JOIN language l ON f.language_id = l.language_id
WHERE c.name = 'Documentary' and l.name = 'English'

