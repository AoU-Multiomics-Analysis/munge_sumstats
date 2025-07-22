

task MungeSumstats{
    String SumstatsPath 
    String OutputPrefix 
}


command {
    Rscript ${munge_sumstats_rscript} \
        --sumstats_path ${SumstatsPath} \
        --prefix ${OutputPrefix}

}

runtime {
        docker: 'quay.io/kfkf33/susier:v24.01.1'        
        memory: "${memory}GB"
        disks: "local-disk 500 SSD"
        bootDiskSizeGb: 25
        cpu: "1"
        zones: ["us-central1-c"]
    }

output {
    File SusieParquet = "${OutputPrefix}.parquet" 
    }
}

workflow susieR_workflow {
    call munge_sumstats 
    }
