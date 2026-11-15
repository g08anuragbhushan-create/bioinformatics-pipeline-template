#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { FASTQC }       from './modules/local/fastqc'
include { FASTP_TRIM }   from './modules/local/fastp_trim'
include { STAR_ALIGN }   from './modules/local/star_align'
include { SALMON_QUANT } from './modules/local/salmon_quant'
include { MULTIQC }      from './modules/local/multiqc'

// Samplesheet input: columns sample,fastq_1,fastq_2 (validated by nf-validation)
Channel
    .fromSamplesheet('input')
    .map { meta, reads -> [meta, reads] }
    .set { ch_reads }

// Reference indices are passed as parameters
ch_star_index   = params.index         ? Channel.fromPath(params.index, checkIfExists: true).collect()         : Channel.empty()
ch_salmon_index = params.transcriptome ? Channel.fromPath(params.transcriptome, checkIfExists: true).collect() : Channel.empty()

workflow {
    FASTQC(ch_reads)
    FASTP_TRIM(ch_reads)
    STAR_ALIGN(FASTP_TRIM.out.reads, ch_star_index)
    SALMON_QUANT(FASTP_TRIM.out.reads, ch_salmon_index)

    ch_qc = Channel.empty()
        .mix(FASTQC.out.fastqc)
        .mix(FASTP_TRIM.out.json)
        .mix(STAR_ALIGN.out.log)

    MULTIQC(ch_qc.collect())
}