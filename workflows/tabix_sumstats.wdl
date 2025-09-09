version 1.0

task TabixSumstats{
    input {
        File SumStats 
    }
    
    String BasePrefix = sub(basename(SumStats, ".gz"), "\\.tsv$", "")

    command <<<
        sed '1s/^/#/' ~{SumStats} | bgzip > ~{BasePrefix}.tabix.tsv.gz
        tabix -s 2 -b 3 -e 3 ~{BasePrefix}.tabix.tsv.gz
    >>>

runtime {
        docker: 'ghcr.io/aou-multiomics-analysis/munge_sumstats:main'        
        memory: "32GB"
        disks: "local-disk 500 SSD"
        bootDiskSizeGb: 25
        cpu: "1"
        zones: ["us-central1-c"]
    }

output {
        File TabixMungedSumstats = "${BasePrefix}.tabix.tsv.gz"
        File TabixMungedSumstatsIndex = "${BasePrefix}.tabix.tsv.gz.tbi"
    }
}

workflow TabixSumstatsWorkflow {
    input {
        File SumStats
    }

    call TabixSumstats {
        input:
            SumStats = SumStats
        }
    output {
        File TabixMungedSumstats = TabixSumstats.TabixMungedSumstats
        File TabixMungedSumstatsIndex = TabixSumstats.TabixMungedSumstatsIndex
        }
    }
