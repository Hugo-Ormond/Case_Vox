WITH store_performance AS (
    SELECT
        s.store_id,
        COUNT(DISTINCT(r.rental_id)) AS rental_count,
        SUM(p.amount) AS total_revenue
    FROM
        rental r
    JOIN
        inventory i ON r.inventory_id = i.inventory_id
    JOIN
        store s ON i.store_id = s.store_id
    JOIN
        payment p ON r.rental_id = p.rental_id
    GROUP BY
         s.store_id
),
store_details AS (
    SELECT
        s.store_id,
		d.district,
        COUNT(DISTINCT c.customer_id) AS total_customers,
        COUNT(DISTINCT st.staff_id) AS total_staff,
        COUNT(DISTINCT i.inventory_id) AS total_inventory
    FROM
        store s
    LEFT JOIN
        customer c ON s.store_id = c.store_id
    LEFT JOIN
        staff st ON s.store_id = st.store_id
    LEFT JOIN
        inventory i ON s.store_id = i.store_id
	LEFT JOIN
        address d ON d.address_id = s.address_id
    GROUP BY
        s.store_id, d.district
)

SELECT
    sp.store_id as ID_Loja,
    sp.rental_count AS Total_Alugueis,
    sp.total_revenue AS Total_Receita,
    sd.total_customers AS Qtde_Clientes,
    sd.total_staff AS Qtde_Funcionarios,
    sd.total_inventory AS Filmes_Disponiveis,
	sd.district AS Distrito
FROM
    store_performance sp
JOIN
    store_details sd ON sp.store_id = sd.store_id
ORDER BY
    sp.total_revenue DESC
