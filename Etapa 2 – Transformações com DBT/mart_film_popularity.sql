WITH film_rentals AS (
    SELECT
        f.film_id,
        f.title,
        EXTRACT(YEAR FROM r.rental_date) AS rental_year,
        EXTRACT(MONTH FROM r.rental_date) AS rental_month,
        COUNT(*) AS rental_count
    FROM
        rental r
    JOIN
        inventory i ON r.inventory_id = i.inventory_id
    JOIN
        film f ON i.film_id = f.film_id
    GROUP BY
        f.film_id, f.title, rental_year, rental_month
)

SELECT
    rental_year AS Ano,
    rental_month AS Mes,
    film_id AS Id_Filme,
    title AS Titulo,
    rental_count AS Qtde_Alugueis
FROM
    film_rentals
ORDER BY
    rental_year, rental_month, rental_count DESC
