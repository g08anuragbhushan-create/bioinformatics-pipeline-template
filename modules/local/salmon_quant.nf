process SALMON_QUANT {
    tag "$meta.id"
    label 'process_medium'

    conda 'bioconda::salmon=1.10.2'
    container 'quay.io/biocontainers/salmon:1.10.2--h7e5ed60_0'

    input:
    tuple val(meta), path(reads)
    path index

    output:
    path "${meta.id}_quant", emit: quant
    path 'versions.yml', emit: versions

    script:
    """
    salmon quant -i ${index} -l A -1 ${reads[0]} -2 ${reads[1]} -o ${meta.id}_quant --threads ${task.cpus} --gcBias
    echo 'salmon: 1.10.2' > versions.yml
    """
}