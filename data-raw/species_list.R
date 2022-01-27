# grab most recent version of data and save the directory
### Data is produced using:

df <- bbsAssistant::grab_bbs_data()

species_list <- df[['species_list']]
species_list$AOU <- as.integer(as.character(species_list$AOU))


usethis::use_data(species_list, overwrite = TRUE)

