WITH payment_store AS (
    SELECT
        p.payment_date,
		s.store_id,
		d.district,
		r.rental_id ,
		p.amount ,
        p.customer_id 
    FROM
        payment p
	JOIN
        rental r ON r.rental_id = p.rental_id
    JOIN
        inventory i ON r.inventory_id = i.inventory_id
    JOIN
        store s ON i.store_id = s.store_id
	LEFT JOIN
        address d ON d.address_id = s.address_id
)

SELECT
    payment_date AS Data,
    amount AS Total_Receita,
	rental_id AS Id_Aluguel,
    customer_id AS Id_Cliente,
    store_id AS Id_Loja,
    district AS Distrito
FROM
    payment_store
ORDER BY
    payment_date, store_id, district DESC
