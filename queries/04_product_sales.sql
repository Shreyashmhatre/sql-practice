-- What sold? Include only completed orders, using captured line-item prices.
SELECT p.name, SUM(i.quantity) AS units,
       SUM(i.quantity * i.unit_price_paise) AS revenue_paise
FROM products AS p
JOIN order_items AS i ON i.product_id = p.product_id
JOIN orders AS o ON o.order_id = i.order_id
WHERE o.status = 'completed'
GROUP BY p.product_id, p.name
ORDER BY revenue_paise DESC, p.product_id;
