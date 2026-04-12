#!/usr/bin/env python3
from __future__ import annotations

import csv
import sys
from pathlib import Path


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit("Usage: make_manuscript_dali_table.py <input_summary_tsv> <output_tsv>")

    infile = Path(sys.argv[1])
    outfile = Path(sys.argv[2])

    if not infile.is_file():
        raise SystemExit(f"Input summary file not found: {infile}")

    rows = []
    with infile.open("r", newline="") as f:
        reader = csv.DictReader(f, delimiter="\t")
        for row in reader:
            rows.append({
                "Pair": f'{row["query"]} vs {row["subject"]}',
                "Z": row["z"],
                "RMSD": row["rmsd"],
                "lali": row["lali"],
                "%ID": row["pid"],
            })

    with outfile.open("w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["Pair", "Z", "RMSD", "lali", "%ID"], delimiter="\t")
        writer.writeheader()
        writer.writerows(rows)

    print(f"Wrote: {outfile}")


if __name__ == "__main__":
    main()