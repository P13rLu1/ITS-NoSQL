-- 1. recuperare la lista di attori e film, dove la durata del film é > 60 minuti
select a.actor_id, a.first_name, a.last_name, f.film_id, f.title, f.length
from actor as a
join film_actor as fa on a.actor_id = fa.actor_id
join film as f on fa.film_id = f.film_id
where f.length > 60;

-- 2. Selezionare actor id, nome intero dell'attore, e contare il numero di film che ogni attore ha fatto, ordinando poi per il totale dei film in modo decrescente.
SELECT 
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS full_name,
    COUNT(fa.film_id) AS film_count
FROM 
    actor AS a
JOIN 
    film_actor AS fa ON a.actor_id = fa.actor_id
GROUP BY 
    a.actor_id, full_name
ORDER BY 
    film_count DESC;

-- 3. Estrarre la durata media dei film, raggruppati per categoria
SELECT 
    c.name AS category_name,
    AVG(f.length) AS average_length
FROM 
    category AS c
JOIN 
    film_category AS fc ON c.category_id = fc.category_id
JOIN 
    film AS f ON fc.film_id = f.film_id
GROUP BY 
    c.name
ORDER BY 
    average_length DESC;

-- 4. correggere il nome dell'attore GROUCHO WILLIAMS in HARPO WILLIAMS
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

-- 5. se il  nome dell'attore con id = 172 è Harpo, allora cambiarlo in Groucho, altrimenti cambiarlo in Mucho Groucho
UPDATE actor
SET first_name = CASE 
                    WHEN first_name = 'HARPO' THEN 'GROUCHO'
                    ELSE 'MUCHO GROUCHO'
                 END
WHERE actor_id = 172;

-- 6. creare una vista che categorizza i clienti in base all'ammontare speso nel noleggio
CREATE OR REPLACE VIEW customer_spending_category AS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent,
    CASE
        WHEN SUM(p.amount) < 100 THEN 'Spesa di livello basso'
        WHEN SUM(p.amount) BETWEEN 100 AND 500 THEN 'Spesa di livello medio'
        ELSE 'Spesa di livello alto'
    END AS spending_category
FROM
    public.customer c
JOIN
    public.payment p ON c.customer_id = p.customer_id
JOIN
    public.rental r ON p.rental_id = r.rental_id
GROUP BY
    c.customer_id
ORDER BY
    total_spent DESC;


-- Mostra vista
select * from customer_spending_category

-- 7. Trovare id, nome e cognome degli attori che compaiono di più nei film, ordinandoli in ordine decrescenze per numero di comparse
SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS appearance_count
FROM
    actor a
JOIN
    film_actor fa ON a.actor_id = fa.actor_id
GROUP BY
    a.actor_id, a.first_name, a.last_name
ORDER BY
    appearance_count DESC;

-- 8. Creare una vista in cui sono mostrati i clienti che non hanno restituito il film, visualizzando id del noleggio, id del cliente, data di noleggio e email del cliente
CREATE VIEW customers_with_unreturned_rentals AS
SELECT
    r.rental_id,
    r.customer_id,
    r.rental_date,
    c.email
FROM
    rental r
JOIN
    customer c ON r.customer_id = c.customer_id
WHERE
    r.return_date IS NULL;

-- mostra vista
select * from customers_with_unreturned_rentals

-- 9. ottieni una lista dei film più noleggiati per categoria e ordina per categoria e numero di noleggi decrescente (suggerimento: prima ottieni il conteggio dei noleggi per ogni film, poi usa questo dato per fare la statistica sulla categoria)
SELECT
    c.name AS category_name,
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM
    film f
JOIN
    inventory i ON f.film_id = i.film_id
JOIN
    rental r ON i.inventory_id = r.inventory_id
JOIN
    film_category fc ON f.film_id = fc.film_id
JOIN
    category c ON fc.category_id = c.category_id
GROUP BY
    c.name, f.film_id, f.title
ORDER BY
    category_name ASC,
    rental_count DESC;

-- 10. Calcola la media del rental_rate per ogni categoria di film
SELECT
    c.name AS category_name,
    AVG(f.rental_rate) AS average_rental_rate
FROM
    film f
JOIN
    film_category fc ON f.film_id = fc.film_id
JOIN
    category c ON fc.category_id = c.category_id
GROUP BY
    c.name
ORDER BY
    category_name;