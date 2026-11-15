process FASTQC {
    tag "$meta.id"
    label 'process_low'

    conda 'bioconda::fastqc=0.12.1'
    container 'quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0'

    input:
    tuple val(meta), path(reads)

    output:
    tuple val(meta), path('*.zip'), path('*.html'), emit: fastqc
    path 'versions.yml', emit: versions

    script:
    """
    fastqc --quiet --threads ${task.cpus} ${reads}
    echo 'fastqc: 0.12.1' > versions.yml
    """
}