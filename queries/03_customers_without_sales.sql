-- Include both customers with no orders and those with only non-completed orders.
SELECT c.name
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1 FROM orders AS o
    WHERE o.customer_id = c.customer_id AND o.status = 'completed'
)
ORDER BY c.customer_id;
