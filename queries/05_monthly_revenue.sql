-- Keep the year in the grouping so January of different years never merges.
SELECT strftime('%Y-%m', o.ordered_at) AS month,
       SUM(i.quantity * i.unit_price_paise) AS revenue_paise
FROM orders AS o
JOIN order_items AS i ON i.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY month
ORDER BY month;
