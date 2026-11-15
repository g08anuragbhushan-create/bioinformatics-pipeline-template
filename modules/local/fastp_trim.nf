process FASTP_TRIM {
    tag "$meta.id"
    label 'process_medium'

    conda 'bioconda::fastp=0.23.4'
    container 'quay.io/biocontainers/fastp:0.23.4--h5f740d0_3'

    input:
    tuple val(meta), path(reads)

    output:
    tuple val(meta), path('*_1.trim.fastq.gz'), path('*_2.trim.fastq.gz'), emit: reads
    path '*.json', emit: json
    path 'versions.yml', emit: versions

    script:
    """
    fastp --in1 ${reads[0]} --in2 ${reads[1]} --out1 ${meta.id}_1.trim.fastq.gz --out2 ${meta.id}_2.trim.fastq.gz --json ${meta.id}.fastp.json --html ${meta.id}.fastp.html --thread ${task.cpus}
    echo 'fastp: 0.23.4' > versions.yml
    """
}