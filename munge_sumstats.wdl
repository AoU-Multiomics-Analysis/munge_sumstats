
task MungeSumstats{
    String SumstatsPath 
    String OutputPrefix 
    String DockerPath
    File  MungeSumstatsRscriptPath
command {
    #gsutil cp ${MungeSumstatsRscriptPath} . 
    Rscript ${MungeSumstatsRscriptPath} \
        --sumstats_path ${SumstatsPath} \
        --prefix ${OutputPrefix}

    }

runtime {
        docker: '${DockerPath}'        
        memory: "16GB"
        disks: "local-disk 500 SSD"
        bootDiskSizeGb: 25
        cpu: "1"
        zones: ["us-central1-c"]
    }

output {
    File MungedSumstats = "${OutputPrefix}_munged_summary_statistics.tsv.gz" 
    }
}

workflow MungeSumstatsWorkflow {
    call MungeSumstats 
    }
