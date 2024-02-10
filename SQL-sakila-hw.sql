-- Actors in "ACADEMY DINOSAUR"
SELECT 
    actor.first_name, 
    actor.last_name
FROM 
    actor
INNER JOIN 
    film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN 
    film ON film_actor.film_id = film.film_id
WHERE 
    film.title = 'ACADEMY DINOSAUR';
