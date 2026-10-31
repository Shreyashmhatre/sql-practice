-- Calculate spend first; window functions then rank the aggregated customers.
WITH spend AS (
    SELECT c.customer_id, c.name, SUM(i.quantity * i.unit_price_paise) AS spend_paise
    FROM customers AS c
    JOIN orders AS o ON o.customer_id = c.customer_id
    JOIN order_items AS i ON i.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY c.customer_id, c.name
)
SELECT name, spend_paise, DENSE_RANK() OVER (ORDER BY spend_paise DESC) AS spend_rank
FROM spend
ORDER BY spend_rank, customer_id;
