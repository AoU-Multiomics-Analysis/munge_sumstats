suppressPackageStartupMessages(library(tidyverse))
library(data.table)
library(MungeSumstats)
library(SNPlocs.Hsapiens.dbSNP155.GRCh38)
library(BSgenome.Hsapiens.NCBI.GRCh38)
suppressPackageStartupMessages(library(optparse))

BiocManager::install("SNPlocs.Hsapiens.dbSNP155.GRCh38")

###### PARSE OPTIONS ######
option_list <- list(
  #TODO look around if there is a package recognizing delimiter in dataset
  optparse::make_option(c("--sumstats_path"), type="character", default=NULL,
                        help="Path to GWAS summary statistics", metavar = "type"),
  optparse::make_option(c("--output_prefix"), type="character", default=NULL,
                        help="Expression matrix file path with gene phenotype-id in rownames and sample-is in columnnames", metavar = "type")
  )
 
opt <- optparse::parse_args(optparse::OptionParser(option_list=option_list))

#######MUNGE SUMSTATS ######
sumstats_path <- opt$sumstats_path
output_prefix <- opt$output_prefix

system(paste('wget ',sumstats_path,' . '))

output_file <- paste0(output_prefix,'_munged_summary_statistics.tsv')
munged_sumstats <- MungeSumstats::format_sumstats(basename(sumstats_path), ref_genome="GRCh38") %>% 
        mutate(outcome = output_prefix,save_path = output_file)
#munged_sumstats %>% fwrite(file = output_file)

