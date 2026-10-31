-- ROWS and the order ID tie-breaker make the cumulative sum deterministic.
WITH totals AS (
    SELECT o.order_id, o.ordered_at, SUM(i.quantity * i.unit_price_paise) AS total_paise
    FROM orders AS o
    JOIN order_items AS i ON i.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY o.order_id, o.ordered_at
)
SELECT order_id, total_paise,
       SUM(total_paise) OVER (
           ORDER BY ordered_at, order_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS cumulative_paise
FROM totals
ORDER BY ordered_at, order_id;
