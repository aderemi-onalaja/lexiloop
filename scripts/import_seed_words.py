# scripts/import_seed_words.py
"""Import data/seed_words.csv into Postgres words table.
Usage:
  pip install psycopg2-binary python-dotenv
  export DATABASE_URL='postgres://user:pass@localhost:5432/lexiloop'
  python scripts/import_seed_words.py
"""
import csv, os, sys
from pathlib import Path
from urllib.parse import urlparse
from dotenv import load_dotenv
import psycopg2
import psycopg2.extras as extras

ROOT = Path(__file__).resolve().parents[1]
CSV_PATH = ROOT / "data" / "seed_words.csv"

def get_conn():
    load_dotenv(ROOT / ".env", override=True)  # optional local .env
    url = os.getenv("DATABASE_URL")
    if not url:
        print("DATABASE_URL env var is required", file=sys.stderr)
        sys.exit(1)
    return psycopg2.connect(url)

UPSERT_SQL = """
INSERT INTO words (headword, pos, definition, example, difficulty, frequency, domain, tags)
VALUES %s
ON CONFLICT (headword)
DO UPDATE SET
  pos = EXCLUDED.pos,
  definition = EXCLUDED.definition,
  example = EXCLUDED.example,
  difficulty = EXCLUDED.difficulty,
  frequency = EXCLUDED.frequency,
  domain = EXCLUDED.domain,
  tags = EXCLUDED.tags;
"""

def to_record(row):
    # tags are semicolon-separated in CSV → Postgres TEXT[]
    tags = [t.strip() for t in (row.get("tags") or "").split(";") if t.strip()]
    # difficulty numeric
    try:
        difficulty = float(row.get("difficulty") or 0)
    except ValueError:
        difficulty = None
    return (
        row.get("headword"),
        row.get("pos"),
        row.get("definition"),
        row.get("example"),
        difficulty,
        row.get("frequency"),
        row.get("domain"),
        tags
    )

def main():
    if not CSV_PATH.exists():
        print(f"CSV not found at {CSV_PATH}", file=sys.stderr)
        sys.exit(1)

    with open(CSV_PATH, newline='', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        rows = [to_record(r) for r in reader]

    if not rows:
        print("No rows to import.")
        return

    conn = get_conn()
    try:
        with conn, conn.cursor() as cur:
            extras.execute_values(cur, UPSERT_SQL, rows, page_size=100)
        print(f"Imported {len(rows)} rows into words table.")
    finally:
        conn.close()

if __name__ == "__main__":
    main()
