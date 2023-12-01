#/bin/bash

# launches interactive session of R with Seurat Packages installed
docker run -v /home/jmmenend/RNA-interspecies:/home/jmmenend/RNA-interspecies -it satijalab/seurat:latest bash
# -u $(id -u):$(id -g) add if you dont have root permissions!
# Allows you to copy paste the R commands to run them :)

cd home/jmmenend/RNA-interspecies/
