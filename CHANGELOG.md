# Changelog

All notable changes to this project are documented here.
The format follows Keep a Changelog; the project follows Semantic Versioning.

## [0.1.0] - 2026-11-15
### Added
- Initial template: FASTQC -> fastp -> STAR -> salmon -> MultiQC workflow.
- Per-process Conda environments and container directives.
- Test profile and GitHub Actions CI (nf-core lint, nf-test, smoke run).
- Provenance outputs (Nextflow trace, timeline, report) and MultiQC aggregation.
- MIT license, CITATION.cff, CONTRIBUTING.md.