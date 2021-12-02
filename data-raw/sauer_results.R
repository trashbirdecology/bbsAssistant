## code to prepare `usgs_results` dataset
## (the most recent release of Sauer et al. analyses available on SB)
## This script contains the code to prepare the original data from the ScienceBase directory as downloaded based on sb_id
library(dplyr)
# Define the sb_id to grab ---------------------------------------------------------
sb_items <- read.csv(file = "./data-raw/sb_items.csv")
# need to munge the sb_items object
sb_items <-
    sb_items %>%
    dplyr::filter(data_type %in% c("sauer_results")&
                  release_year==max(release_year)
                  )

sb_id <- sb_items$sb_item


# Download the data to temp dir Create subdirectory for the sb_id files  -----------------------------------------------------------------
mydir <- tempdir()
sbtools::item_file_download(sb_id = sb_id, dest_dir = tempdir, overwrite_file=TRUE)

# Import ------------------------------------------------------------------
fns <- list.files(mydir, pattern = "trend|inde", full.names=TRUE)
list.files(sb_dir)
# Bring them in --------------------------------------------------------
## This needs to be improved, but fine for now.
usgs_results <- list()
for(i in seq_along(fns)){
    if(grep(".csv",fns[i], value=FALSE)){
        temp <- read.csv(fns[i])
        }else{print('break');next}
    usgs_results[[i]] <- temp
    if(exists("temp")) rm(temp)
    names(usgs_results)[i] <-
        gsub(".*/(.+).csv*", "\\1", fns[i])
    ## for some reason roxygen translation is **Removing the list names**
    ## therefore^, I have annoying added a variable to determine the
}

## append
# # Write the data to package files as .RDA ---------------------------------
usethis::use_data(usgs_results, overwrite = TRUE)
