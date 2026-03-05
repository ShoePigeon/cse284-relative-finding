# cse284-relative-finding

Repository for the CSE284 final project "Comparing PLINK vs other methods for Relative Finding" by Robert Xu, Richard Zhang, and Richard James. This workspace contains data, scripts, results, and notebooks used to reproduce analyses (including KING-based relatedness and IBD segment summaries) on chr22 from 1000 Genomes and benchmark data.

## Contents
- `cse284-final-proj.ipynb` — final project notebook (analysis & figures).
- `run_1000g_analysis.sh` — shell script to run the example 1000 Genomes analysis pipeline.
- `data/` — input data; `data/test/` contains minimal test inputs.
- `results/` — produced result files (KING outputs, IBD segments, benchmarks).
- `figures/` — generated figures from the notebook/analysis.
- `notebooks/` — supporting notebooks *(none right now).
- `scripts/` — helper scripts used by the pipeline.

## Key result files (examples)
- `results/1000g_chr22_king_related.kin0`
- `results/1000g_chr22_king_ibdsegallsegs.txt`
- `results/king_relatedallsegs.txt`

## Requirements
- Bash (for `run_1000g_analysis.sh`).
- Python 3.x and common scientific packages to open and run the notebook (Jupyter, numpy, pandas, matplotlib). See the notebook for specific environment details.

## Quickstart
1. Inspect the notebook:

   - Open `cse284-final-proj.ipynb` in Jupyter Lab / Notebook to view the full analysis and plots.

2. Run the provided analysis script (in a POSIX shell):

```bash
chmod +x run_1000g_analysis.sh
./run_1000g_analysis.sh
```

3. Results and intermediate files will be written to `results/` and plots to `figures/`.

Note: The shell script may assume tools and data paths that require configuration on first run — inspect the script and adjust paths or install missing tools as needed.

## Reproduce notebook locally
- Create and activate a Python environment (venv/conda), install Jupyter and the packages used in the notebook, then run:

```bash
jupyter lab
```

Open `cse284-final-proj.ipynb` and run cells top-to-bottom.
Alternatively, you can download and run on datahub.ucsd.edu
