## Use micromamba as the base image
FROM mambaorg/micromamba:1.5.3

## Set up environment
ENV MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
## Create a new environment and install packages
RUN micromamba install -y -n base -c conda-forge -c bioconda \
    bioconductor-MungeSumstats \
    bioconductor-SNPlocs.Hsapiens.dbSNP155.GRCh38 \
    bioconductor-BSgenome.Hsapiens.NCBI.GRCh38 \
    conda-forge::r-tidyverse \
    conda-forge::datatable \
    conda-forge::r-optparse \
    dnachun::tabix

## Default command to run when the container starts
CMD ["bash"]
