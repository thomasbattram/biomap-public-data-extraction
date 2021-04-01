# --------------------------------------------------------------------
# Searching geo datasets for DNAm data
# --------------------------------------------------------------------

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

## get all EPIC and 450K datasets
datasets <- geograbi.retrieve.datasets(gpl = c(gpls_epic, gpls_450k)) ## 5sec

datasets <- as_tibble(datasets)

# --------------------------------------------------------------------
# Search for eczema and psoriasis data
# --------------------------------------------------------------------

# filter based on sample size
filt_datasets <- datasets[datasets$samples > 50, ]

ad_terms <- c("eczema", "atopic", "dermatitis", "rash")
pso_terms <- c("psoriasis", "pso", "rash")

## get potential ad data
pot_ad_data_desc <- datasets[grep(paste(ad_terms, collapse = "|"), datasets$description), ]
pot_ad_data_title <- datasets[grep(paste(ad_terms, collapse = "|"), datasets$title), ]
pot_ad_data <- bind_rows(pot_ad_data_title, pot_ad_data_desc) %>%
	distinct()
## check title and description to see if AD has been captured 
pot_ad_data$title
pot_ad_data$description
## These datasets relate to asthma and not AD so no AD data is available
ad_data <- NULL

## get potential psoriasis data 
pot_pso_data_desc <- datasets[grep(paste(pso_terms, collapse = "|"), datasets$description), ]
pot_pso_data_title <- datasets[grep(paste(pso_terms, collapse = "|"), datasets$title), ]
pot_pso_data <- bind_rows(pot_pso_data_title, pot_pso_data_desc) %>%
	distinct()
## check title and description to see if pso has been captured 
pot_pso_data$title
pot_pso_data$description
## all data contains psoriasis patients so keeping them all
pso_data <- pot_pso_data

# --------------------------------------------------------------------
# Extract relevant info and data
# --------------------------------------------------------------------

## This step takes a while
pso_data$filenames <- geograbi.download.series.files(path = "data/series_files",
													 gses = pso_data$accession, 
													 gpls = pso_data$platform)

## Manually get datasets that were not downloaded
pso_data[is.na(pso_data$filenames), ]

## get pmids from series files
extract_pmid_from_series <- function(series_filepath)
{
	series <- geograbi.get.series(series_filepath)
	keep <- grep("pubmed", names(series))[1]
	return(series[keep])
}

pso_pmids <- extract_pmid_from_series(pso_data$filenames[1])

## things want

## extract samples
test_f <- pso_data$filenames[1]
samples <- geograbi.get.samples(filename = test_f)
chr <- geograbi.extract.characteristics(samples)

extract_contact <- function(sample_df)
{
	contact <- unique(sample_df$contact_name)
	contact <- gsub("\\,", " ", contact)
	contact <- str_squish(contact)
	contact_email <- unique(sample_df$contact_email)
	out_contact <- paste0(contact, " <", contact_email, ">")
	return(out_contact)
}

all_dat <- lapply(1:nrow(pso_data), function(x) {
	print(x)
	dat <- pso_data[x, ]
	## extract sample data
	dat_samples <- geograbi.get.samples(filename = dat$filenames)
	## get phenotype data
	chr <- geograbi.extract.characteristics(dat_samples)
	## extract tissue information if present
	tiss <- unique(chr[, grep("tissue", colnames(chr), ignore.case = T), drop = T])
	tiss <- ifelse(class(tiss) == "data.frame", "FILL ME", tiss)
	## put together study data as is done for the spreadsheet "public_available_template.xlsx"
	out_dat <- dat %>%
		mutate(pi_contact = "", 
			   data_contact = extract_contact(dat_samples), 
			   contacted_by = "", 
			   study_name = "", 
			   pmid = extract_pmid_from_series(dat$filenames), 
			   resource = "GEO", 
			   resource_id1 = accession, 
			   resource_id2 = id, 
			   resource_link = paste0("https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=", accession), 
			   phenotype = "PSO - CHECK ME", 
			   covariates = paste(paste(names(chr), collapse = ", "), "CHECK ME"), 
			   comorbidities = "", 
			   electronic_health_records = "", 
			   cases_and_controls = "FILL ME", 
			   tissue = tiss, 
			   methylation_type = "array", 
			   methylation_assay = "chip", 
			   methylation_file_format = "series file", 
			   raw_methylation_data_available = "yes")
	out_all <- list(study_dat = out_dat, chr = chr)
	return(out_all)
})

all_study_dat <- map_dfr(all_dat, "study_dat")
all_chr <- map(all_dat, "chr")
names(all_chr) <- pso_data$accession

## write out the data and switch to edit-geo-study-data.R to manually edit the study data
write.table(all_study_dat, file = "data/messy-geo-study-data.tsv", 
			col.names = T, row.names = F, quote = F, sep = "\t")

save(all_chr, file = "data/geo-pheno-data.RData")






