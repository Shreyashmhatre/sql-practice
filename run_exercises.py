import argparse
import json
import sqlite3
from contextlib import closing
from pathlib import Path

ROOT = Path(__file__).resolve().parent


def build_database() -> sqlite3.Connection:
    connection = sqlite3.connect(":memory:")
    connection.row_factory = sqlite3.Row
    for name in ["schema.sql", "seed.sql"]:
        connection.executescript((ROOT / "data" / name).read_text())
    return connection


def run_query(connection: sqlite3.Connection, name: str) -> list[dict]:
    choices = {p.stem: p for p in (ROOT / "queries").glob("*.sql")}
    if name not in choices:
        raise ValueError(f"Unknown exercise: {name}")
    return [dict(row) for row in connection.execute(choices[name].read_text())]


def main():
    expected = json.loads((ROOT / "expected_results.json").read_text())
    parser = argparse.ArgumentParser(description="Run reproducible SQLite exercises")
    parser.add_argument("--exercise", choices=sorted(expected))
    parser.add_argument(
        "--check", action="store_true", help="Verify exact expected rows"
    )
    args = parser.parse_args()
    names = [args.exercise] if args.exercise else sorted(expected)
    failed = False
    with closing(build_database()) as connection:
        for name in names:
            rows = run_query(connection, name)
            if args.check:
                matches = rows == expected[name]
                print(f"{'PASS' if matches else 'FAIL'} {name}")
                failed |= not matches
            else:
                print(name, json.dumps(rows, indent=2))
    raise SystemExit(1 if failed else 0)


if __name__ == "__main__":
    main()
