## code to prepare most recent version of `species_list` goes here
tempdir<-tempdir()

# AOU --------------------------------------------------------------------
# Download AOU file to temp folder
aou.url <- "http://checklist.aou.org/taxa.csv?type=charset%3Dutf-8%3Bsubspecies%3Dno%3B"
download.file(aou.url, destfile=paste0(tempdir, "aou.csv"))
# Import AOU
aou <- read.csv(paste0(tempdir, "aou.csv"))
# Add leading zeroes
aou <- aou %>% 
    dplyr::mutate(AOU=stringr::str_pad(aou$id, 5, pad="0")) %>% 
    dplyr::select(-id)


# Save to /data/ ---------------------------------------------------------------
usethis::use_data(species_list, overwrite = TRUE)
