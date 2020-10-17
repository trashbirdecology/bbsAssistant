## code to prepare `sauer_results` dataset
## (the most recent release of Sauer et al. analyses available on SB)
## This script contains the code to prepare the original data from the ScienceBase directory as downloaded based on sb_id

# Define the sb_id to grab ---------------------------------------------------------
sb_items <- readr::read_csv(here::here("/data-raw/sb_items.csv"))
# grab the sb item idenitfier associated with the most recent year end.
sb_id <- sb_items %>%
    filter(data_type == "sauer_results") %>%
    filter(year_end == max(year_end)) %>%
    dplyr::select(sb_item) %>% as.character()

# Create subdirectory for the sb_id files  -----------------------------------------------------------------
sb_dir <-
    paste0(here::here("data-raw/"), sb_id) # define the new directory
suppressWarnings(dir.create(sb_dir)) # create directory for data associated with the sb item (sb_id) if it does not already exist.

# Download the item files to sb_dir -------------------------------------------------
sbtools::item_file_download(sb_id = sb_id, dest_dir = sb_dir, overwrite_file=TRUE)

# Specify relevant files to bring in -----------------------------
fns <- list.files(sb_dir, pattern = "trend|inde", full.names=TRUE) # all of Sauer's relevant results files contain these phrases.... for now...

# Bring them in eh --------------------------------------------------------
sauer_results <- list()
for(i in seq_along(fns)){
    if(grep(".csv",fns[i], value=FALSE)){
        temp <- read.csv(fns[i])
        }
    sauer_results[[i]] <- temp
    if(exists("temp")) rm(temp)
    }

# # Write the data to package files as .RDA ---------------------------------
usethis::use_data(sauer_results, overwrite = TRUE)
