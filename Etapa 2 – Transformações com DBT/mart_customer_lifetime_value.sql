WITH customer_rentals AS (
    SELECT
        r.customer_id,
        SUM(f.rental_rate) AS total_spent,
        MIN(r.rental_date) AS first_rental_date
    FROM
        rental r
    JOIN
        inventory i ON r.inventory_id = i.inventory_id
    JOIN
        film f ON i.film_id = f.film_id
    GROUP BY
        r.customer_id
)

SELECT
    c.customer_id AS Id_Cliente,
    c.first_name AS Primeiro_Nome,
    c.last_name AS Segundo_Nome,
	c.email AS Email,
    cr.total_spent AS Valor_Total_Gasto,
    (CURRENT_DATE - cr.first_rental_date::date) AS Dias_Desde_a_Primeira_Compra
FROM
    customer c
JOIN
    customer_rentals cr ON c.customer_id = cr.customer_id
