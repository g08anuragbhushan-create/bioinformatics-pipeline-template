# Workflow design

This is the repository-side summary of the design document.

## Stack
- Orchestrator: Nextflow DSL2
- Environments: Conda/Mamba (Bioconda), version-pinned
- Containers: Docker (development), Singularity/Apptainer (HPC)
- CI: GitHub Actions
- Testing: nf-test
- Reporting: MultiQC

## Stages
1. FASTQC — raw read quality control
2. fastp — adapter and quality trimming
3. STAR — spliced alignment to a reference index
4. salmon — transcript quantification
5. MultiQC — aggregate report over all logs

## Reproducibility
- Tool versions pinned per process via conda and container directives.
- Container images addressable by digest at run time.
- Nextflow trace, timeline and execution report published to `results/pipeline_info/`.
- Cached, resumable runs guarantee identical outputs for unchanged steps.

See the companion Google Docs design document for the full rationale, provenance bundle specification, and reproducibility checklist.