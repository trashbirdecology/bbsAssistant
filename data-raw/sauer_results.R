## code to prepare `sauer_results` dataset
## (the most recent release of Sauer et al. analyses available on SB)
## This script contains the code to prepare the original data from the ScienceBase directory as downloaded based on sb_id

# Define the sb_id to grab ---------------------------------------------------------
sb_items <- read.csv(file = "./data-raw/sb_items.csv")
# need to munge a little first
sb_items<-sb_items[sb_items$data_type=="sauer_results" & sb_items$release_year==max(sb_items$release_year) ,] # filter acting up...
sb_id <- sb_items$sb_item


# Create subdirectory for the sb_id files  -----------------------------------------------------------------
sb_dir <- paste0("./data-raw/", sb_id) # define the new directory
suppressWarnings(dir.create(sb_dir)) # create directory for data associated with the sb item (sb_id) if it does not already exist.

# Download the item files to sb_dir -------------------------------------------------
# NOTE: `sbtools::item_file_download` has overwrite arg, but when set to TRUE and sb_dir exists, it throws an error)
if(!(sb_id %in% list.files("./data-raw/", full.names = FALSE))){
sbtools::item_file_download(sb_id = sb_id, dest_dir = sb_dir, overwrite_file=TRUE) 
}

# Specify relevant files to bring in -----------------------------
# all of Sauer's relevant results files contain these phrases.... for now...
fns <- list.files(sb_dir, pattern = "trend|inde", full.names=TRUE) 

# Bring them in --------------------------------------------------------
sauer_results <- list()
for(i in seq_along(fns)){
    if(grep(".csv",fns[i], value=FALSE)){
        temp <- read.csv(fns[i])
        }else{print('break');next}
    sauer_results[[i]] <- temp
    if(exists("temp")) rm(temp)
    names(sauer_results)[i] <-
        gsub(".*/(.+).csv*", "\\1", fns[i])
    ## for some reason roxygen translation is **Removing the list names**
    ## therefore^, I have annoying added a variable to determine the 
}

## append 
# # Write the data to package files as .RDA ---------------------------------
usethis::use_data(sauer_results, overwrite = TRUE)
