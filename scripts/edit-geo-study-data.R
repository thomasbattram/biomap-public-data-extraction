# --------------------------------------------------------------------
# Editing GEO study data manually
# --------------------------------------------------------------------

# Aim: to take study data generated by "search-geo.R" and edit each entry manually to add the correct data

# Date: 2021-04-01

# pkgs
library(tidyverse) # tidy code and data
library(usefunc) # personal package for useful functions
library(openxlsx) # to write out data as a spreadsheet

# data
all_study_dat <- read_tsv("data/messy-geo-study-data.tsv")
pheno_data <- new_load("data/geo-pheno-data.RData")

# --------------------------------------------------------------------
# Edit study data 
# --------------------------------------------------------------------

## Get columns to fill in/check 
to_fill <- lapply(all_study_dat, function(x) {any(grepl(".*FILL ME.*", x))})
to_fill <- names(which(unlist(to_fill)))
to_check <- lapply(all_study_dat, function(x) {any(grepl(".*CHECK ME.*", x))})
to_check <- names(which(unlist(to_check)))

#
#### Row 1: GSE151278
#
tmp_study <- all_study_dat[1, ]
tmp_chr <- pheno_data[[tmp_study$accession]] %>% as_tibble

# to check
tmp_study$phenotype <- "antitumour necrosis factor drug response in moderate‐to‐severe psoriasis"
tmp_study$covariates <- "gender, age, age at initiation, biological drug"

# to fill
cc <- table(tmp_chr$response)
cc <- paste0("Excellent responders: ", as.character(cc["ER"]), ", Partial responders: ", as.character(cc["PR"]))
tmp_study$cases_and_controls <- cc
tmp_study$tissue # all good

out_study_dat <- tmp_study

#
#### Row 2: GSE126017 - removing as sperm cells
#

#
#### Row 3: GSE73894
#
tmp_study <- all_study_dat[3, ]
tmp_chr <- pheno_data[[tmp_study$accession]] %>% as_tibble

# to check
tmp_study$phenotype <- "PSO"
tmp_study$covariates <- "gender"

# to fill
cc <- table(tmp_chr$`disease state`)
cc <- paste0("Cases: ", as.character(cc["Psoriasis"]), ", Controls: ", as.character(cc["Normal"]))
tmp_study$cases_and_controls <- cc
tmp_study$tissue # all good

# bind to study data
out_study_dat <- rbind(out_study_dat, tmp_study)

#
#### Row 4: GSE63315
#
tmp_study <- all_study_dat[4, ]
tmp_chr <- pheno_data[[tmp_study$accession]] %>% as_tibble

# to check
tmp_study$phenotype <- "PSO"
tmp_study$covariates <- "gender"

# to fill
cc <- table(tmp_chr$`treatment`)
cc <- paste0("Cases: ", as.character(cc["PRE-UV"]), ", Controls: ", as.character(cc["CONTROL"]))
tmp_study$cases_and_controls <- paste0(cc, ". NOTE: epidermis sampled pre-, during-, and post-UV treatment in cases")
tmp_study$tissue <- "skin (epidermis)"

# bind to study data
out_study_dat <- rbind(out_study_dat, tmp_study)

#
#### Row 5: GSE126017 - ignoring as sperm cells
#
tmp_study <- all_study_dat[5, ]
tmp_chr <- pheno_data[[tmp_study$accession]] %>% as_tibble

# to check
tmp_study$phenotype <- "PSO"
tmp_study$covariates <- "age, age of psoriasis onset, gender, batch (unclear what batch variable represents)"

# to fill
cc <- table(tmp_chr$`disease state`)
cc <- paste0("Cases: ", as.character(cc["Disease"]), ", Controls: ", as.character(cc["Normal"]))
tmp_study$cases_and_controls <- cc
tmp_study$tissue # all good

# bind to study data
out_study_dat <- rbind(out_study_dat, tmp_study)

# --------------------------------------------------------------------
# write out study data 
# --------------------------------------------------------------------

write.xlsx(out_study_dat, file = "data/all-cleaned-study-data.xlsx")

# subset to remove colnames not present on josine's spreadsheet
nams_to_rm <- c("title", "description", "organism", "type", "platform", "accession", "id", "project", "samples", "filenames")
small_study_dat <- out_study_dat %>%
	dplyr::select(-one_of(nams_to_rm))
write.xlsx(small_study_dat, file = "data/subset-cleaned-study-data.xlsx")






