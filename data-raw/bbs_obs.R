## code to prepare `bbs_obs` dataset
## This script contains the code to prepare the original data from the ScienceBase directory as downloaded based on sb_id 
library(dplyr)

# Import sb_items ---------------------------------------------------------
sb_items <- readr::read_csv(here::here("/data-raw/sb_items.csv"))
# grab the sb item idenitfier associated with the most recent year end.
sb_id <- sb_items %>% filter(year_end == max(year_end)) %>% dplyr::select(sb_item) %>% as.character()

# # Define the item and create subdirectory for the item  -----------------------------------------------------------------
sb_dir<- paste0(here::here("data-raw/"), sb_id) # define the new directory
#     ## i'd like to create a table of the child items within the dataset (sbid="52b1dfa8e4b0d9b325230cd9")
# suppressWarnings(dir.create(sb_dir)) # create directory for data associated with the sb item (sb_id) if it does not already exist. 
# 
# # Download the files associated with this sb item --------------------------------------------
# sbtools::item_file_download(sb_id = sb_id, # 2020 release (up until 2019)
#                    dest_dir = sb_dir, 
#                    overwrite_file = TRUE
#                    )

# Decompress the observations data for each region (state/province) -------------------------------------------------
# Unzip the States.zip into the sb_id item directory
# unzip(list.files(sb_dir, full.names=TRUE, pattern="States.zip"), exdir = sb_dir)
 ###### get_bbs_data() already decompresses /data-raw/States/ ###### 


# Import state files and create a single df  ---------------------------------------------------------------------
fns <- list.files(paste0(sb_dir,"/States"), ".csv", full.names = TRUE)
if(length(fns)==0){warning(paste0("Something is terribly wrong. Directory ", list.files(paste0(sb_dir,"/States"), " is empty.")))}

for(i in seq_along(fns)){
  if(i==1) data <- NULL #initialize empty df for brining in the state level data 
  tmp <- readr::read_csv(fns[i], progress = FALSE) %>% 
         mutate(StateNum=as.numeric(StateNum)) 
  bbs_recent <- bind_rows(tmp, data) # append new data to previous data set
  message("imported file ", fns[i])
}


# Append the region proper names to the data ------------------------------
data(region_codes, package="bbsAssistant") # this data is currently done by hand so can call from package directly.
region_codes <- region_codes %>% 
  dplyr::select(-zip_states) %>% 
  mutate(CountryNum = as.integer(CountryNum)) %>% 
  mutate(StateNum = as.integer(StateNum)) %>% 
  mutate(State = as.character(State)) 

bbs_obs <- left_join(bbs_recent, region_codes)
               
# Write the data to package files as .RDA ---------------------------------
usethis::use_data(bbs_obs, overwrite=TRUE)

