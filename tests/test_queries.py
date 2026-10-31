import json
import sqlite3
import unittest

from run_exercises import ROOT, build_database, run_query


class QueryTests(unittest.TestCase):
    def setUp(self):
        self.db = build_database()
        self.addCleanup(self.db.close)

    def test_every_query_matches_expected_rows(self):
        expected = json.loads((ROOT / "expected_results.json").read_text())
        self.assertEqual(
            set(expected), {p.stem for p in (ROOT / "queries").glob("*.sql")}
        )
        for name, rows in expected.items():
            with self.subTest(exercise=name):
                self.assertEqual(run_query(self.db, name), rows)

    def test_foreign_keys_and_positive_amounts(self):
        with self.assertRaises(sqlite3.IntegrityError):
            self.db.execute(
                "INSERT INTO orders VALUES (99, 999, '2026-01-01', 'completed')"
            )
        with self.assertRaises(sqlite3.IntegrityError):
            self.db.execute("INSERT INTO order_items VALUES (1, 3, 0, 65000)")

    def test_catalog_price_changes_do_not_change_historic_sales(self):
        before = run_query(self.db, "01_order_totals")
        self.db.execute("UPDATE products SET price_paise = 1")
        self.assertEqual(run_query(self.db, "01_order_totals"), before)

    def test_dense_rank_handles_ties(self):
        self.db.execute("INSERT INTO orders VALUES (7, 1, '2026-02-11', 'completed')")
        self.db.execute("INSERT INTO order_items VALUES (7, 1, 1, 145000)")
        ranks = run_query(self.db, "06_customer_rank")
        self.assertEqual([r["spend_rank"] for r in ranks], [1, 1])

    def test_reject_unknown_query(self):
        with self.assertRaises(ValueError):
            run_query(self.db, "../../unexpected")


if __name__ == "__main__":
    unittest.main()
