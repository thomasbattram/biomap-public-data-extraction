# Publicly available data for BIOMAP analyses

To increase the number of samples available for analyses the databases housing publicly available data will be checked. These include: [GEO](https://www.ncbi.nlm.nih.gov/geo/), [ArrayExpress](https://www.ebi.ac.uk/arrayexpress/), [European Genome-phenome Archive](https://www.ebi.ac.uk/ega/home), and [dbGaP](https://www.ncbi.nlm.nih.gov/gap/). 

Below describes querying of those databases, the results of those queries and the data to download.

__NOTE:__ Antonio et al. also conducted a search of publicly available datasets and processed the data as seen in this paper: [Manually curated and harmonised transcriptomics datasets of psoriasis and atopic dermatitis patients](https://www.nature.com/articles/s41597-020-00696-8). The curated data can be found here: [https://zenodo.org/record/4009497](https://zenodo.org/record/4009497). These data are only transcriptomic.

## GEO

Date of last search: 2021-04-01

Two scripts were used in the search:
1. [search-geo.R](scripts/search-geo.R) - This script involves the [geograbi](https://github.com/yousefi138/geograbi) R package to extract data and do some pre-lim filtering. It produces the files: [messy-geo-study-data.tsv](data/messy-geo-study-data.tsv) and [geo-pheno-data.RData](data/geo-pheno-data.RData). The comments and code should make it clear how data were extracted.
2. [edit-geo-study-data.R](scripts/edit-geo-study-data.R) - This script takes the data generated from [search-geo.R](scripts/search-geo.R) and manually edits any variables that need clarification or can't be directly extracted using [geograbi](https://github.com/yousefi138/geograbi).

__Identified studies can be found in [subset-cleaned-study-data.xlsx](data/subset-cleaned-study-data.xlsx)__. 

Note: Only psoriasis data were found.

## ArrayExpress

Date of last search: 2021-03-04

Notes: 

* The R package [ArrayExpress](http://www.bioconductor.org/packages/release/bioc/html/ArrayExpress.html) was tested, but it gave less flexibility in querying the database than the website (last tested 2021-03-04).
* Searching for "eczema" on the website seems to capture atopic dermatitis so just keeping the eczema query results
* Restricted searches to array data thus far, but could expand to sequencing data
* No option to search for EPIC array datasets so assuming there are none
* ArrayExpress was also used by Antonio. See https://zenodo.org/record/4009497.

The results of the queries are downloaded and put in a spreadsheet: __arrayexpress.xlsx__. At the top of each sheet are the exact search terms used, the filters applied to the search and the date the search was conducted. Below them are some notes after a look at the query results and below that are the downloaded query results. If reading in the data (e.g. into R) then skip the first 4 lines of each sheet. Please keep formatting the same when editting.

## EGA (European Genome-phenome Archive)

Date of last search: 2021-03-04

Note: Searching with the inital searchbox available here: https://www.ebi.ac.uk/ega/home caused a redirection to this website: https://ega-archive.org/ and no results appeared. A search of the same terms gave back some results.

Below are the summaries of the results of each search because the website does not enable you to download query results like ArrayExpress.

### Search for specific studies/methylation

* LBC. [EGA link](https://ega-archive.org/datasets/EGAD00010000604). Unclear whether they have data on eczema or psoriasis (checked cohort profile and for publications and found nothing) .
* Lifelines-DEEP. [EGA link](https://ega-archive.org/studies/EGAS00001001704). This cohort has DNAm data, but it's not listed on EGA. Think they have eczema data as they contributed to [Shared genetic origin of asthma, hay fever and eczema elucidates allergic disease biology](https://www.nature.com/articles/ng.3985).
* Understanding society. [EGA link](https://ega-archive.org/studies/EGAS00001002836). Doesn't look as though they have eczema or psoriasis data (searched the [CLOSER search engine](https://discovery.closer.ac.uk/)).
* Canadian Biobank on Respiratory and Allergic diseases (COBRA). [EGA link](https://ega-archive.org/studies/EGAS00001003103). They have data on eczema along with 167 whold blood 450k samples and 24 eosinophil 450k samples.
* BLUEPRINT. [EGA link](https://ega-archive.org/dacs/EGAC00001000135).

### Search results for "eczema"

Only one study: ["Skin Microbiome in Disease States: Atopic Dermatitis and Immunodeficiency"](https://ega-archive.org/studies/phs000266). Study is just assessing differences in microbiota between individuals. Data is on dbGaP, study ID = [phs000266](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/study.cgi?study_id=phs000266.v4.p1)


### Search results for "atopic dermatitis"

1. Same study as "eczema" query
2. ["A Study of the Genetic Causes of Complex Pediatric Disorders"](https://ega-archive.org/studies/phs000490). From the description: "CAG [Center for Applied Genomics] has committed to releasing genotype and phenotype data for 4000 individuals diagnosed with asthma, ADHD, atopic dermatitis, GERD (1000 for each), and 1000 individuals on the upper and lower ranges of Low-Density Lipoprotein (LDL) levels to dbGaP". dbGaP study ID = [phs000490](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/study.cgi?study_id=phs000490). NOTE: phenotype data may also include electronic medical records.
3. ["eMERGE Network Imputed GWAS for 41 Phenotypes"](https://ega-archive.org/studies/phs000888). From the description: "The goal of eMERGE [electronic Medical Records and Genomics] is to conduct genome-wide association studies in approximately 55,000 individuals using EMR-derived phenotypes and DNA from linked Biorepositories." Data is on dbGaP, study ID = [phs000888](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/study.cgi?study_id=phs000888)
4. ["eMERGE Network Phase III: HRC SNV and 1000 Genomes SV Imputed Array Data of 105,000 Participants"](https://ega-archive.org/studies/phs001584) - similar to 3. Data is on dbGaP, study ID = [phs001584](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/study.cgi?study_id=phs001584)

### Search results for "psoriasis"

9 studies. Looks to be mostly genetics studies with one microbiome and one gene expression study. Can't be bothered to write them out so click [HERE](https://ega-archive.org/search-results.php?query=psoriasis) for search result.

One dataset was also present in the results of the query - Psoriasis cases as part of WTCCC2 phase 2. What was in the dataset was not totally clear, but it's likely basic phenotype (psoriasis case/control status) and genotype. Sample size = 2622. Need to contact someone about getting access to the data, more details [HERE](https://ega-archive.org/datasets/EGAD00010000124).

## dbgap

Found no results of relevance.
