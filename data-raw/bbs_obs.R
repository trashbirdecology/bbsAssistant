## This script contains the code to prepare the original data from ScienceBase 
## eventually I will generalize this script to allow the user to provide any sb item they want, BUT for now, I just need to get the most recent datset into the package..
library(dplyr)
# Import sb_items ---------------------------------------------------------
sb_items <- readr::read_csv(here::here("/data-raw/sb_items.csv"))
# grab the sb item idenitfier associated with the most recent year end.
sb_id <- sb_items %>% filter(year_end == max(year_end)) %>% dplyr::select(sb_item) %>% as.character()

# Define the item and create subdirectory for the item  -----------------------------------------------------------------
sb_dir<- paste0(here::here("data-raw/"), sb_id) # define the new directory
    ## i'd like to create a table of the child items within the dataset (sbid="52b1dfa8e4b0d9b325230cd9")
suppressWarnings(dir.create(sb_dir)) # create directory for data associated with the sb item (sb_id) if it does not already exist. 

# Download the files associated with this sb item --------------------------------------------
sbtools::item_file_download(sb_id = sb_id, # 2020 release (up until 2019)
                   dest_dir = sb_dir, 
                   overwrite_file = TRUE
                   )

# State observations data -------------------------------------------------
# Unzip the States.zip into the sb_id item directory
unzip(list.files(sb_dir, full.names=TRUE, pattern="States.zip"), exdir = sb_dir)

# Region code lookups -----------------------------------------------------
# regions.lookup <- list.files(sb_dir, full.names=TRUE, pattern="region") # the observations data at the state level...
### NOTE: SBTOOLS is currently not working correctly, so I will just use my premade region codes.

# Unzip individual states data --------------------------------------------
state_dir <- paste0(sb_dir,"/States/")
states.zipped <- list.files(state_dir, full.names=TRUE) 
lapply(states.zipped, unzip, exdir=state_dir)


# Import state files and create a single df  ---------------------------------------------------------------------
fns <- list.files(state_dir, ".csv", full.names = TRUE)

for(i in seq_along(fns)){
  if(i==1) data <- NULL #initialize empty df for brining in the state level data 
  tmp <- readr::read_csv(fns[i], progress = FALSE) %>% 
         mutate(StateNum=as.numeric(StateNum)) 
  bbs_recent <- bind_rows(tmp, data) # append new data to previous data set
  message("imported file ", fns[i])
}


# Append the region proper names to the data ------------------------------
data(region_codes, package="bbsAssistant")
region_codes <- region_codes %>% 
  dplyr::select(-zip_states) %>% 
  mutate(CountryNum = as.integer(CountryNum)) %>% 
  mutate(StateNum = as.integer(StateNum)) %>% 
  mutate(State = as.character(State)) 

bbs_obs <- left_join(bbs_recent, region_codes)
               
# Write the data to package files as .RDA ---------------------------------
usethis::use_data(bbs_obs, overwrite=TRUE)

