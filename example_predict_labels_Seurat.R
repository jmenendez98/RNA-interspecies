library(Seurat)
library(SeuratDisk)

# R is run through a docker container(satijalab/seurat:latest) within wsl2 
#setwd("/home/jmmenend/RNA-interspecies")

#################################################
### Parsing in the Reference Dataset(human2): ###
#################################################
human2_ref <- "data/human2_h1h2_ref.h5Seurat"

# loads reference data into R
reference <- LoadH5Seurat(human2_ref, meta.data = FALSE, misc = FALSE)

#dfref <- read.csv("../dataset/Allen-human/h1025.csv") 
#reference[["CellType"]] <- dfref$subclass.label
#reference@meta.data[["CellType"]] <- dfref$cell_type

#############################################
### Parsing in the Query Dataset(human1): ###
#############################################
human1_query <- "data/human1_h1h2_query.h5Seurat"
human1_labels <- "data/human1_h1h2_metadata.csv"

query1 <- LoadH5Seurat(human1_query, meta.data = FALSE, misc = FALSE)
query1_labels <- read.csv(human1_labels)

query1[["CellType"]] <- query1_labels

#############################################
### Performing the Cell Type Predictions: ###
#############################################
log_reference <- NormalizeData(reference, normalization.method = "LogNormalize", scale.factor = 10000, margin = 1, block.size = NULL, verbose = TRUE)
log_query1 <- NormalizeData(query1, normalization.method = "LogNormalize", scale.factor = 10000, margin = 1, block.size = NULL, verbose = TRUE)

# just to be 100% sure
DefaultAssay(reference) <- 'RNA'
DefaultAssay(query) <- 'RNA'

# find the anchor genes between the two datasets
anchors1 <- FindTransferAnchors(reference = reference, query = query, features = rownames(query[["RNA"]]), dims = 1:50, reference.reduction = "pca")

# actually run the predictions
predictions <- TransferData(anchorset = anchors1, refdata = reference@meta.data[["CellType"]])
query1@meta.data$prediction <- predictions$predicted.id

# write to a csv
write.csv(query@meta.data, "data/human1_h1h2_seuratpredictedlabels.csv")