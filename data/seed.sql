-- Fictional records for reproducible exercises. All money is integer paise.
INSERT INTO customers VALUES
    (1, 'Asha', 'Pune'), (2, 'Rohan', 'Mumbai'),
    (3, 'Meera', 'Pune'), (4, 'Kabir', 'Nagpur');
INSERT INTO products VALUES
    (1, 'Sensor kit', 120000), (2, 'Network adapter', 80000),
    (3, 'Microcontroller', 65000);
INSERT INTO orders VALUES
    (1, 1, '2026-01-03', 'completed'), (2, 2, '2026-01-05', 'completed'),
    (3, 1, '2026-02-02', 'completed'), (4, 3, '2026-02-07', 'cancelled'),
    (5, 2, '2026-02-08', 'completed'), (6, 3, '2026-02-10', 'pending');
INSERT INTO order_items VALUES
    (1, 1, 1, 120000), (1, 2, 1, 80000), (2, 2, 2, 80000),
    (3, 3, 1, 65000), (4, 1, 1, 120000),
    (5, 1, 1, 120000), (5, 3, 2, 65000), (6, 2, 1, 80000);
