## code to prepare `bbs_obs` dataset
## (the most recent release available on SB)
## This script contains the code to prepare the original data from the ScienceBase directory as downloaded based on sb_id 

# Import sb_items ---------------------------------------------------------
s <- read.csv("./data-raw/sb_items.csv")

# grab the sb item idenitfier associated with the most recent year end.
sb_items<-sb_items[sb_items$data_type=="observations" & sb_items$release_year==max(sb_items$release_year) ,] # filter acting up...

# # Define the item and create subdirectory for the item  -----------------------------------------------------------------
sb_dir <- paste0("./data-raw/", sb_id) # define the new directory
suppressWarnings(dir.create(sb_dir)) # create directory for data associated with the sb item (sb_id) if it does not already exist.

# Download  and unzip the BBS data ----------------------------------------
get_bbs_data(overwrite=FALSE)

# Import the BBS data list ------------------------------------------------
bbs_data <- import_bbs_data(sb_id, sb_dir)

# Load the region_codes ---------------------------------------------------
bbs_obs<-bbs_data$observations

# Write the data to package files as .RDA ---------------------------------
usethis::use_data(bbs_obs, overwrite=TRUE)

