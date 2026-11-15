process MULTIQC {
    label 'process_low'

    conda 'bioconda::multiqc=1.21'
    container 'quay.io/biocontainers/multiqc:1.21--pyhdfd78af_0'

    publishDir "${params.outdir}/multiqc", mode: 'copy'

    input:
    path '*'

    output:
    path 'multiqc_report.html', emit: report
    path '*multiqc_data*', emit: data
    path 'versions.yml', emit: versions

    script:
    """
    multiqc --filename multiqc_report .
    echo 'multiqc: 1.21' > versions.yml
    """
}