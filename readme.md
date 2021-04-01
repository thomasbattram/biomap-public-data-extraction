# Publicly available data for BIOMAP analyses

To increase the number of samples available for analyses the databases housing publicly available data will be checked. These include: [ArrayExpress](https://www.ebi.ac.uk/arrayexpress/), [European Genome-phenome Archive](https://www.ebi.ac.uk/ega/home), and [dbGaP](https://www.ncbi.nlm.nih.gov/gap/). 

Below describes querying of those databases, the results of those queries and the data to download.

__NOTE:__ Antonio et al. also conducted a search of publicly available datasets and processed the data as seen in this paper: [Manually curated and harmonised transcriptomics datasets of psoriasis and atopic dermatitis patients](https://www.nature.com/articles/s41597-020-00696-8). The curated data can be found here: [https://zenodo.org/record/4009497](https://zenodo.org/record/4009497). These data are only transcriptomic.

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

