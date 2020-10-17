## code to prepare `bbs_obs` dataset
## (the most recent release available on SB)
## This script contains the code to prepare the original data from the ScienceBase directory as downloaded based on sb_id 
# devtools::load_all()
# library(dplyr)

# Import sb_items ---------------------------------------------------------
sb_items <- readr::read_csv(here::here("/data-raw/sb_items.csv"))
# grab the sb item idenitfier associated with the most recent year end.
sb_id <- sb_items %>% 
    filter(data_type=="observations") %>% 
    filter(year_end == max(year_end)) %>% 
    dplyr::select(sb_item) %>% as.character()

# # Define the item and create subdirectory for the item  -----------------------------------------------------------------
sb_dir <- paste0(here::here("data-raw/"), sb_id) # define the new directory
suppressWarnings(dir.create(sb_dir)) # create directory for data associated with the sb item (sb_id) if it does not already exist.

# Download  and unzip the BBS data ----------------------------------------
get_bbs_data(overwrite=FALSE)

# Import the BBS data list ------------------------------------------------
bbs_data <- import_bbs_data(sb_id, sb_dir)

# Load the region_codes ---------------------------------------------------
bbs_obs<-bbs_data$observations

# Write the data to package files as .RDA ---------------------------------
usethis::use_data(bbs_obs, overwrite=TRUE)

