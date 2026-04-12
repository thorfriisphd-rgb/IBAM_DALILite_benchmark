#!/usr/bin/env python3
from __future__ import annotations

import csv
import sys
from pathlib import Path


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit("Usage: make_manuscript_dali_table_md.py <input_summary_tsv> <output_md>")

    infile = Path(sys.argv[1])
    outfile = Path(sys.argv[2])

    if not infile.is_file():
        raise SystemExit(f"Input summary file not found: {infile}")

    rows = []
    with infile.open("r", newline="") as f:
        reader = csv.DictReader(f, delimiter="\t")
        for row in reader:
            rows.append([
                f'{row["query"]} vs {row["subject"]}',
                row["z"],
                row["rmsd"],
                row["lali"],
                row["pid"],
            ])

    lines = [
        "| Pair | Z | RMSD | lali | %ID |",
        "|---|---:|---:|---:|---:|",
    ]
    for r in rows:
        lines.append(f"| {r[0]} | {r[1]} | {r[2]} | {r[3]} | {r[4]} |")

    outfile.write_text("\n".join(lines) + "\n")
    print(f"Wrote: {outfile}")


if __name__ == "__main__":
    main()