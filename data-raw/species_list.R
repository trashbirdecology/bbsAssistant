# grab most recent version of data and save the species list as a lookup table
df <- bbsAssistant::grab_bbs_data() ## need to update this to grab data if its already stored inside the local package
species_list <- df[['species_list']]
species_list$AOU <- as.integer(as.character(species_list$AOU))
usethis::use_data(species_list, overwrite = TRUE)

