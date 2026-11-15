# Linear Build Tasks (Backlog)

These 15 tasks define the build plan for the bioinformatics workflow template. Each task is self-contained and can be imported one-for-one into Linear (or any issue tracker). The plan maps to the reproducibility checklist in the design document.

---

## 1. Scaffold repository skeleton and README
**Priority:** High
**Objective:** Create the project directory layout and a complete README.
**Scope:** nf-core-style tree (`main.nf`, `nextflow.config`, `modules.config`, `modules/local/`, `conf/`, `assets/`, `tests/`, `docs/`, `.github/workflows/`, `README.md`).
**Acceptance criteria:** every directory and stub file exists; README explains purpose, quick start, inputs, outputs, and license; repo has a protected `main` branch.

## 2. Author nextflow.config with profiles and parameters
**Priority:** High
**Objective:** Declare parameters, resource labels, profiles, and the manifest.
**Scope:** `params` (input, outdir, fasta, gtf, index, transcriptome); `process` defaults with retry; labels `process_low/medium/high`; profiles `docker`, `singularity`, `conda`, `test`, `hpc`; `manifest` block.
**Acceptance criteria:** config loads with `nextflow config`; all profiles resolve; labels map to sensible CPU/memory/time.

## 3. Implement main.nf workflow orchestration
**Priority:** High
**Objective:** Wire FASTQC → fastp → STAR → salmon → MultiQC into one DSL2 workflow.
**Scope:** parse the samplesheet via nf-validation; build reference-index channels from parameters; connect process outputs; feed collected QC into MultiQC.
**Acceptance criteria:** `-stub-run` completes without channel errors; output channel names match includes/consumers; the graph includes all five processes in order.

## 4. Build FASTQC module
**Priority:** Normal
**Objective:** Raw-read QC process, nf-core style.
**Acceptance criteria:** Conda pinned to `bioconda::fastqc=0.12.1`; container pinned to a Biocontainers image; emits `versions.yml`; tagged by `$meta.id`; `process_low` label.

## 5. Build fastp trimming module
**Priority:** Normal
**Objective:** Adapter/quality trimming.
**Acceptance criteria:** Conda pinned to `bioconda::fastp=0.23.4`; deterministic sample-derived output names; JSON report emitted for MultiQC; `process_medium` label.

## 6. Build STAR alignment module
**Priority:** Normal
**Objective:** Spliced alignment to a reference index.
**Acceptance criteria:** Conda pinned to `bioconda::star=2.7.11b`; `--readFilesCommand zcat`; coordinate-sorted BAM emitted; `process_high` label; index from `params.index`.

## 7. Build salmon quantification module
**Priority:** Normal
**Objective:** Transcript quantification.
**Acceptance criteria:** Conda pinned to `bioconda::salmon=1.10.2`; `-l A` with `--gcBias`; deterministic output directory; index from `params.transcriptome`.

## 8. Create samplesheet schema and nf-validation
**Priority:** Normal
**Objective:** Fail fast on malformed inputs.
**Acceptance criteria:** `nextflow_schema.json` with `sample`, `fastq_1`, `fastq_2`; invalid rows produce clear errors; schema lists all parameters; stub run validates the shipped samplesheet.

## 9. Write environment.yml and lock dependencies
**Priority:** Normal
**Objective:** One reproducible environment, frozen.
**Acceptance criteria:** every tool pinned; `mamba env create -f environment.yml` succeeds in CI; a commit-pinned conda-lock file accompanies it.

## 10. Containerize with Dockerfile and Singularity definition
**Priority:** Normal
**Objective:** Runtime images for local/cloud and HPC.
**Acceptance criteria:** `docker build` produces the pinned image; `.def` builds a runnable SIF; image digest (not floating tag) recorded for provenance.

## 11. Set up GitHub Actions CI
**Priority:** High
**Objective:** Make CI the merge gate.
**Acceptance criteria:** triggers on push/PR to `main`; runs nf-test, nf-core lint, and `nextflow run main.nf -profile test,conda`; branch protection on `main`.

## 12. Author nf-test suites per module
**Priority:** Normal
**Objective:** Automated unit/integration tests.
**Acceptance criteria:** `tests/main.nf.test` asserts `workflow.success` and the MultiQC report; suite runs in CI; determinism checks compare outputs across resumed runs.

## 13. Add MultiQC reporting
**Priority:** Normal
**Objective:** Aggregate all logs into one report.
**Acceptance criteria:** Conda pinned to `bioconda::multiqc=1.21`; report at `results/multiqc/multiqc_report.html`; tool versions recorded for provenance.

## 14. Add provenance outputs and publish strategy
**Priority:** Normal
**Objective:** Trace every result to code, versions, and parameters.
**Acceptance criteria:** Nextflow trace/timeline/report published to `results/pipeline_info/`; per-process `versions.yml`; commit SHA and parameter snapshot captured with results.

## 15. Add LICENSE, CITATION, CHANGELOG, and CONTRIBUTING
**Priority:** Low
**Objective:** Complete governance documentation.
**Acceptance criteria:** explicit MIT license; machine-readable `CITATION.cff`; Keep-a-Changelog style `CHANGELOG.md`; contributing guide documenting PR workflow and style.
