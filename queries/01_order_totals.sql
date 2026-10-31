-- What is the value of each completed order?
SELECT o.order_id, SUM(i.quantity * i.unit_price_paise) AS total_paise
FROM orders AS o
JOIN order_items AS i ON i.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY o.order_id
ORDER BY o.order_id;
