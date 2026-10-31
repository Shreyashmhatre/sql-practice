-- Which customers have completed purchases, and how much did they spend?
SELECT c.name, SUM(i.quantity * i.unit_price_paise) AS spend_paise
FROM customers AS c
JOIN orders AS o ON o.customer_id = c.customer_id
JOIN order_items AS i ON i.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.name
ORDER BY spend_paise DESC, c.customer_id;
