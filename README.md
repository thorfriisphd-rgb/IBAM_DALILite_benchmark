# IBAM DALILite Structural Benchmark

This repository contains the reproducibility pipeline for the structural benchmarking analyses used in the IBAM/C12orf29 study.

C12orf29 is proposed here to encode IBAM (In Between Actin and Myosin), a conserved contractile-system protein exhibiting a deeply conserved actomyosin interaction grammar spanning approximately one billion years of evolution.

The DALILite benchmark framework tests whether IBAM conforms to canonical RNA ligase structural families, an annotation previously proposed in the literature.

The pipeline performs systematic DALILite structural comparisons between:

- canonical RNA ligases
- IBAM vs RNA ligases
- IBAM vs IBAM homologues

The goal is to rigorously test the hypothesis that C12orf29 is structurally related to RNA ligases.
The entire analysis can be reproduced with a single command.

### Repository Structure
```
IBAM_DALILite_benchmark/
│
├── dali_projects/                  # Input dataset (PDB structures and comparison definitions)
│   ├── dali_1S68_vs_5COT/
│   ├── dali_1S68_vs_OaC12/
│   ├── dali_5COT_vs_2HVQ/
│   └── ... (additional comparisons)
│
├── scripts/                        # Pipeline scripts
│   ├── run_dali_benchmark_pipeline.sh
│   ├── run_dalilite_batch.sh
│   ├── parse_dalilite_results.sh
│   ├── make_manuscript_dali_table.py
│   └── make_manuscript_dali_table_md.py
│
└── README.md
```

`dali_projects/` contains the input structures only and should **not be modified**.

##### Pipeline outputs are generated automatically in:
```
dali_batch_runs/
```
## Requirements

### The pipeline requires:
```
Linux or macOS shell
DALILite v5
Python 3
```
DALILite must be available in the system PATH.

#### Example installation location:
```
~/DaliLite/DaliLite.v5/bin/dali.pl
```
#### Add DALILite to the PATH if necessary:
```
export PATH="$HOME/DaliLite/DaliLite.v5/bin:$PATH"
```
### Running the Benchmark

From the repository root:
````
cd dali_projects
bash ../scripts/run_dali_benchmark_pipeline.sh
````
The pipeline will automatically:
````
Validate the dataset structure
Run all DALILite pairwise structural comparisons
Parse the results
Generate manuscript-ready summary tables
````
Runtime on a typical workstation is approximately 1 minute.

### Output

#### Results are written to:
```
dali_batch_runs/results/
```
### Generated files:

#### File	Description
```
dali_summary.tsv	Parsed DALILite output
dali_manuscript_table.tsv	Formatted table used in the manuscript
dali_manuscript_table.md	Markdown version of the benchmark table
```
A preview of the benchmark results is also printed to the terminal when the pipeline finishes.

---

## Reproducibility

All structural comparisons are explicitly defined in the dataset.
Running the pipeline regenerates the benchmarking table directly from the input structures without manual intervention.
This ensures that the structural benchmark reported in the manuscript can be fully reproduced by any reviewer or reader.
---
## Citation

If you use this repository, please cite the associated IBAM/C12orf29 study and reference this repository directly.

Friis TE. *C12orf29 encodes IBAM (In Between Actin and Myosin), a conserved actomyosin-associated protein exhibiting deeply conserved interaction grammar across eukaryotic evolution.* Manuscript in preparation.
---

###  License

MIT License

Copyright (c)

Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  
SOFTWARE.



### Author
Thor Einar Friis

### ORCID
https://orcid.org/0000-0002-4132-4912

