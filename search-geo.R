# ---
# Searching geo datasets for DNAm data
#

# Aim: To search GEO (https://www.ncbi.nlm.nih.gov/geo/) for data that could be used in EWAS of eczema/psoriasis

# Date: 2021-03-31

# pkgs
library(tidyverse) # tidy code and data
library(geograbi) # to extract geo datasets


# --------------------------------------------------------------------
# Extract data for each platform of interest
# --------------------------------------------------------------------

## NOTE: GEO uses GPL terms to represent platforms. GPLs below were sourced using the "Find platform"
## 		 tool on the GEO platform browser (https://www.ncbi.nlm.nih.gov/geo/browse/?view=platforms&display=20)

# GPLs of interest:
gpls_epic <- c("GPL23976", "GPL21145")
gpls_450k <- c("GPL18809", "GPL16304", "GPL13534")


## all Illumina Infinium 27K DNA methylation datasets
datasets <- geograbi.retrieve.datasets(gpl = c(gpls_epic, gpls_450k)) ## 5sec

datasets <- as_tibble(datasets)

# --------------------------------------------------------------------
# Search for eczema and psoriasis data
# --------------------------------------------------------------------

# filter based on sample size
filt_datasets <- datasets[datasets$samples > 50, ]

ad_terms <- 
grep("eczema", datasets$description, ignore.case = T)

grep("atopic", datasets$description, ignore.case = T, value = T)

grep("psoriasis", datasets$description, ignore.case = T)
