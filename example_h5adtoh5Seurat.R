#####################################################
### NEED TO EXTRACT THE METADATA BEFORE R PORTION ###
#####################################################

##################################################
### Use SeuratDisk to Convert h5ad to h5Seurat ###
##################################################
library(Seurat)
library(SeuratDisk)

# maybe not needed
# I used a docker container to run R through wsl2
setwd("/home/jmmenend/RNA-interspecies")

# can change this to the files you want to convert
h5ad_file <- "data/human1_h1h2_fixed.h5ad" # input
h5seurat_file <- "data/human1_h1h2.h5seurat" # output

# Performs the actual conversion!
Convert(h5ad_file, h5seurat_file, "RNA", overwrite = FALSE, verbose = TRUE)