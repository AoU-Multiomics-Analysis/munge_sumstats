version 1.0

task QuerySumstats{
    input {
        File SumStats
        File SumStatsIndex 
        String OutputPrefix 
        File InputBed
        Int Memory
    }
    String BasePrefix = sub(basename(SumStats), "_munged_summary_statistics.*$", "")

command <<<
    tabix -R ~{InputBed} ~{SumStats} > ~{OutputPrefix}.~{BasePrefix}.bed 
    >>>

runtime {
        docker: 'evinpadhi/munge_sumstats:latest'        
        memory: "${Memory}GB"
        disks: "local-disk 500 SSD"
        bootDiskSizeGb: 25
        cpu: "1"
        zones: ["us-central1-c"]
    }

output {
    File QueriedSumStats = "~{OutputPrefix}.~{BasePrefix}.bed" 
    }
}

workflow QuerySumstatsWorkflow {
    input {
            File SumStats
            File SumStatsIndex 
            String OutputPrefix 
            File InputBed
            Int Memory
    }

    call QuerySumstats{
        input:
            SumStats = SumStats,
            SumStatsIndex = SumStatsIndex, 
            OutputPrefix = OutputPrefix,
            InputBed = InputBed,
            Memory = Memory 
    }
    output {
        File QueriedSumStats = QuerySumstats.QueriedSumStats 
        }
}
