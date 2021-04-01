# ------------------------------------------------------
# Search for relevant data from ArrayExpress
# ------------------------------------------------------

## Aim: To search for any relevant data from the ArrayExpress database (https://www.ebi.ac.uk/arrayexpress/)
##		and document the process and data properly.

## Date created: 2021-03-04


## pkgs
library(tidyverse) # tidy code and data
if (!require("ArrayExpress"))
    BiocManager::install("ArrayExpress")



# ------------------------------------------------------
# Set out the queries
# ------------------------------------------------------

## EXAMPLE QUERY:
sets <- queryAE(keywords = "pneumonia", species = "homo+sapiens")
as_tibble(sets)


sets <- queryAE(keywords = "eczema", species = "homo+sapiens")
as_tibble(sets)

head(sets$ExperimentDesign)

