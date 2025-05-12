-- Quais são os 5 clientes que mais geraram receita no último ano?


SELECT 

    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS Receita_Total
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
where p.payment_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY c.customer_id
ORDER BY Receita_Total DESC
LIMIT 5;

-- Qual a média de dias entre o aluguel e a devolução por categoria de filme?


SELECT 
    cat.name AS categoria,
    AVG(DATE_PART('day', r.return_date - r.rental_date)) AS media_dias__devolucao
FROM rental r
JOIN film_category fc ON r.inventory_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
where r.return_date IS NOT NULL
GROUP BY cat.name;

-- Quais as 3 cidades com maior volume de locações?


SELECT 
    ci.city,
    COUNT(r.rental_id) AS Total_Alugueis
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city
ORDER BY Total_Alugueis DESC
LIMIT 3;

-- Qual o ticket médio por loja?


SELECT 
    s.store_id,
    AVG(p.amount) AS media_ticket_loja
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id
ORDER BY media_ticket_loja desc;

-- Gere uma visão agregada de receita mensal para os últimos 24 meses com dados.

SELECT 
    TO_CHAR(p.payment_date, 'YYYY-MM') AS month,
    SUM(p.amount) AS total_revenue
FROM payment p
WHERE p.payment_date >= (SELECT MAX(payment_date) FROM payment) - INTERVAL '24 months'
GROUP BY TO_CHAR(p.payment_date, 'YYYY-MM')
ORDER BY month DESC;

