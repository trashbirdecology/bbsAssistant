## code to prepare `bbs_obs` dataset
## This script contains the code to prepare the original data from the ScienceBase directory as downloaded based on sb_id 
# devtools::load_all()
## how to make sure that load_all() and build() builds the bbs_obs (get_bbs_data()) prior to building bbs_data

# Load in data promises ----------------------------------------------------------------------
data(bbs_obs)
data(region_codes)
data(species_list)


bbs_data <- list(bbs_obs, region_codes, species_list)
names(bbs_data) <- c("bbs_obs","region_codes", "species_list")
    
    
# Write the data to package files as .RDA ---------------------------------
usethis::use_data(bbs_data, overwrite=TRUE)
