IBAM DALILite Structural Benchmark

Reproducible structural benchmarking pipeline used in the C12orf29 / IBAM study to evaluate whether C12orf29 belongs to the RNA ligase structural family.

The pipeline performs systematic DALILite structural comparisons between:

canonical RNA ligases
IBAM vs RNA ligases
IBAM vs IBAM homologues

The goal is to rigorously test the hypothesis that C12orf29 is structurally related to RNA ligases.

The entire analysis can be reproduced with a single command.

Repository Structure
IBAM_DALILite_benchmark/
│
├── dali_projects/                # Input dataset (PDB structures and comparison definitions)
│
├── scripts/                      # Pipeline scripts
│   ├── run_dali_benchmark_pipeline.sh
│   ├── run_dalilite_batch.sh
│   ├── parse_dalilite_results.sh
│   ├── make_manuscript_dali_table.py
│   └── make_manuscript_dali_table_md.py
│
└── README.md

dali_projects/ contains the input structures only and should not be modified.

Pipeline outputs are generated automatically in:

dali_batch_runs/
Requirements

The pipeline requires:

Linux or macOS shell
DALILite v5
Python 3

DALILite must be available in the system PATH.

Example installation location:

~/DaliLite/DaliLite.v5/bin/dali.pl

Add DALILite to the PATH if necessary:

export PATH="$HOME/DaliLite/DaliLite.v5/bin:$PATH"
Running the Benchmark

From the repository root:

cd dali_projects
bash ../scripts/run_dali_benchmark_pipeline.sh

The pipeline will automatically:

Validate the dataset structure
Run all DALILite pairwise structural comparisons
Parse the results
Generate manuscript-ready summary tables

Runtime on a typical workstation is approximately 1 minute.

Output

Results are written to:

dali_batch_runs/results/

Generated files:

File	Description
dali_summary.tsv	Parsed DALILite output
dali_manuscript_table.tsv	Formatted table used in the manuscript
dali_manuscript_table.md	Markdown version of the benchmark table

A preview of the benchmark results is also printed to the terminal when the pipeline finishes.

Reproducibility

All structural comparisons are explicitly defined in the dataset.

Running the pipeline regenerates the benchmarking table directly from the input structures without manual intervention.

This ensures that the structural benchmark reported in the manuscript can be fully reproduced by any reviewer or reader.

Author

Thor Friis

ORCID
https://orcid.org/0000-0002-4132-4912

License

Released for reproducible scientific use.
