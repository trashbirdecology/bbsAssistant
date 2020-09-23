# code to grab the most recent files associated with raw data in this package (as opposed to retrieving and moving files by hand...lame)
library(dplyr)
library(bbsAssistant)

data_raw_dir <- here::here("data-raw/")
# GRAB ALL DATA FROM SCIENCEBASE ------------------------------------------
# get the most recent sb_id based on the manually updated `sb_items` lookup table.

sb_id <-
    bbsAssistant::sb_items %>% filter(release_year == max(release_year)) %>% dplyr::select(sb_item) %>% as.character()

# define the directory in data-raw based on sb_id
sb_dir <- paste0(data_raw_dir, sb_id)                           
                          

# if the dir already exists, do not overwrite...
if (length(list.files(sb_dir)) == 0) {
    get_bbs_data(sb_id, sb_dir) # note here i use an internal function...
} else(message("directory already exists. not overwriting ", sb_dir))
  ## NOTE: get_bbs_data creates the new directory, unzips States.zip (to /data-raw/States/...), and unzips routes.zip, weather.zip

# Copy desired files into the /data-raw/ ----------------------------------------------
## search tags for files we care about
tags <- c("ecies", "outes.csv", "eather.csv")

## BBS SPECIES LIST
for(i in seq_along(tags)){
list.files(sb_dir, full.names = TRUE, tags[i])
file.copy(list.files(sb_dir, full.names = TRUE, tags[i]), 
           data_raw_dir) # copy to this location
}


# END RUN -----------------------------------------------------------------



