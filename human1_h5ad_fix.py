import scanpy as sc
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

if __name__ == "__main__":
    human1_h5ad = sc.read_h5ad('data/human1_h1h2.h5ad')

    # Save adata.obs as a pandas dataframe
    human1_h5ad.obs.to_csv('data/human1_h1h2_metadata.csv')

    # Delete adata.obs from the object
    del human1_h5ad.obs

    # Save adata as an h5ad file
    human1_h5ad.write('data/human1_h1h2_fixed.h5ad')
