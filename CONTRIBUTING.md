# Contributing

Thanks for helping improve this template.

## Workflow
1. Open an issue describing the change you want to make.
2. Branch off `main` (for example `fix/fastqc-threads`).
3. Keep modules self-contained and pin tool versions in each module's conda and container directives.
4. Add or update the nf-test case for any module you touch.
5. Run `nf-test test tests/` and `nf-core lint` locally before pushing.
6. Open a pull request; CI must pass before merge.

## Style
Follow nf-core conventions: lowercase process names, `meta` as the first channel element, and a `versions.yml` emitted by every process.