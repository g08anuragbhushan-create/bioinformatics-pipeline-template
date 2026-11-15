# Bioinformatics Pipeline Template

A reproducible, open-source analysis workflow template built on **Nextflow DSL2**, with **Conda/Bioconda** environments, **Docker/Singularity** containers, **GitHub Actions** CI, **nf-test** testing, and **MultiQC** reporting.

## Features
- Modular Nextflow DSL2 processes (FASTQC → fastp → STAR → salmon → MultiQC)
- Per-process Conda environments and container images (Bioconda / Biocontainers)
- Input validation via nf-validation (CSV samplesheet + JSON schema)
- GitHub Actions CI: nf-core lint, nf-test, and an end-to-end smoke run
- Full Nextflow provenance (trace, timeline, report) plus MultiQC aggregation
- MIT licensed, nf-core style directory layout

## Quick start
1. Install a container runtime (Docker or Singularity/Apptainer) and Nextflow.
2. Clone this repository.
3. Run the smoke test: `nextflow run main.nf -profile test,docker`
4. Run your own data: `nextflow run main.nf -profile docker --input assets/samplesheet.csv --outdir results`

## Inputs
A CSV samplesheet with columns `sample,fastq_1,fastq_2`, validated against the parameter schema before any compute starts.

## Outputs
Results under `results/`, with the aggregated report in `results/multiqc/` and provenance in `results/pipeline_info/`.

## Documentation
See `docs/workflow_design.md` and the companion Google Docs design document.

## License
MIT. See LICENSE.