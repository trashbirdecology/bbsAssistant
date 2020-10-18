## code to prepare most recent version of `species_list` goes here
tempdir<-tempdir()

# AOU --------------------------------------------------------------------
aou.url <- "http://checklist.aou.org/taxa.csv?type=charset%3Dutf-8%3Bsubspecies%3Dno%3B"
download.file(aou.url, destfile=paste0(tempdir, "aou.csv"))
# Import AOU
aou <- read.csv(paste0(tempdir, "aou.csv"))
# Add leading zeroes
aou <- aou %>% 
    dplyr::mutate(AOU=stringr::str_pad(aou$id, 5, pad="0")) %>% 
    dplyr::select(-id)

# REMOVE FRENCH NAMES BECAUSE SPELL CHECK HATES MY GUTS
aou <- aou %>% 
    dplyr::select(-french_name, -annotation)

# Merge all the lists into a single list ----------------------------------
species_list <- aou # rihgt now just aou, but leave here for future additions

# Save to /data/ ---------------------------------------------------------------
usethis::use_data(species_list, overwrite = TRUE, internal=TRUE)
