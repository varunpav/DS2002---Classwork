-- Actors in "ACADEMY DINOSAUR"
SELECT actor.first_name, actor.last_name FROM actor INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id 
    INNER JOIN film ON film_actor.film_id = film.film_id WHERE film.title = 'ACADEMY DINOSAUR';

-- Count of films in each category
SELECT category.name AS Genre, COUNT(film_category.film_id) AS TotalNum FROM category
    INNER JOIN film_category ON category.category_id = film_category.category_id 
    INNER JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name;

-- Average rental duration for each rating
SELECT rating, AVG(rental_duration) AS AverageRentalDur FROM film GROUP BY rating;

-- Total number of rentals for each customer
SELECT customer.first_name, customer.last_name, COUNT(rental.rental_id) AS TotalRentals FROM customer
    INNER JOIN rental ON customer.customer_id = rental.customer_id GROUP BY customer.customer_id;

-- Store with the highest number of rentals
SELECT inventory.store_id, COUNT(rental.rental_id) AS TotalRentals FROM rental 
    INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id 
GROUP BY inventory.store_id ORDER BY TotalRentals DESC;
LIMIT 1;

-- Most popular film category among customers
-- used chatgpt to suggest fixes my original query
SELECT category.name AS CategoryName, COUNT(rental.rental_id) AS TotalRentals FROM rental
    INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
    INNER JOIN film ON inventory.film_id = film.film_id
    INNER JOIN film_category ON film.film_id = film_category.film_id
    INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY TotalRentals DESC
LIMIT 1;

-- Average rental cost of films by category
SELECT category.name AS Genre, AVG(film.rental_rate) AS AverageRentalRate FROM film
    INNER JOIN film_category ON film.film_id = film_category.film_id
    INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY AverageRentalRate DESC;

-- List of films not rented in the last month
-- used chatgpt to suggest fixes my original query
SELECT film.title AS FilmTitle, MAX(rental.rental_date) AS LastRentalDate FROM film
    LEFT JOIN inventory ON film.film_id = inventory.film_id
    LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
HAVING LastRentalDate < NOW() - INTERVAL 1 MONTH OR LastRentalDate IS NULL;

-- Customer spending on rentals
SELECT customer.first_name, customer.last_name, SUM(film.rental_rate) AS TotalSpending FROM customer
    INNER JOIN rental ON customer.customer_id = rental.customer_id
    INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
    INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY customer.customer_id
ORDER BY TotalSpending DESC;

-- Average length of films in each language
SELECT language.name AS Language, AVG(film.length) AS AverageLength FROM film
    INNER JOIN language ON film.language_id = language.language_id
GROUP BY language.name
ORDER BY AverageLength DESC;







