-- Healthy fixtures have zero orphaned items and zero invalid amounts.
SELECT
    (SELECT COUNT(*) FROM order_items AS i
     LEFT JOIN orders AS o ON o.order_id = i.order_id
     LEFT JOIN products AS p ON p.product_id = i.product_id
     WHERE o.order_id IS NULL OR p.product_id IS NULL) AS orphan_items,
    (SELECT COUNT(*) FROM order_items
     WHERE quantity <= 0 OR unit_price_paise <= 0) AS invalid_amounts;
