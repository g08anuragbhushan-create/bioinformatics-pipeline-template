process STAR_ALIGN {
    tag "$meta.id"
    label 'process_high'

    conda 'bioconda::star=2.7.11b'
    container 'quay.io/biocontainers/star:2.7.11b--h9ee0642_0'

    input:
    tuple val(meta), path(reads)
    path index

    output:
    path "${meta.id}.Aligned.sortedByCoord.out.bam", emit: bam
    path "${meta.id}.Log.final.out", emit: log
    path 'versions.yml', emit: versions

    script:
    """
    STAR --runThreadN ${task.cpus} --genomeDir ${index} --readFilesIn ${reads[0]} ${reads[1]} --readFilesCommand zcat --outSAMtype BAM SortedByCoordinate --outFileNamePrefix ${meta.id}.
    echo 'star: 2.7.11b' > versions.yml
    """
}