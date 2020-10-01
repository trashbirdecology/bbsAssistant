## code to prepare `bbs_obs` dataset
## This script contains the code to prepare the original data from the ScienceBase directory as downloaded based on sb_id 
library(dplyr)

# Import sb_items ---------------------------------------------------------
sb_items <- readr::read_csv(here::here("/data-raw/sb_items.csv"))
# grab the sb item idenitfier associated with the most recent year end.
sb_id <- sb_items %>% filter(year_end == max(year_end)) %>% dplyr::select(sb_item) %>% as.character()

# # Define the item and create subdirectory for the item  -----------------------------------------------------------------
sb_dir <- paste0(here::here("data-raw/"), sb_id) # define the new directory
suppressWarnings(dir.create(sb_dir)) # create directory for data associated with the sb item (sb_id) if it does not already exist.


# Download  and unzip the BBS data ----------------------------------------
get_bbs_data(overwrite=TRUE)

# Import the BBS data list ------------------------------------------------
bbs_data <- import_bbs_data(sb_id, sb_dir)

# Import state files and create a single df  ---------------------------------------------------------------------
# fns <- list.files(paste0(sb_dir,"/States"), ".csv", full.names = TRUE)
# if(length(fns)==0){warning(paste0("Something is terribly wrong. Directory ", list.files(paste0(sb_dir,"/States"), " is empty.")))}
# 
# for(i in seq_along(fns)){
#   if(i==1) data <- NULL #initialize empty df for brining in the state level data 
#   tmp <- readr::read_csv(fns[i], progress = FALSE) %>% 
#          mutate(StateNum=as.numeric(StateNum)) 
#   bbs_recent <- bind_rows(tmp, data) # append new data to previous data set
#   message("imported file ", fns[i])
# }


# Load the region_codes ---------------------------------------------------
data(region_codes)
left_join(bbs_data$observations, region_codes)

# Write the data to package files as .RDA ---------------------------------
usethis::use_data(bbs_obs, overwrite=TRUE)

