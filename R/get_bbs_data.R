#' @title Downloads all files associated with a single version of the USGS Breeding Bird Survey observations data. 
#' @description This function downloads all files assocaited with a single version (defaults to the most recent release) of the BBS observations dataset from USGS ScienceBase repository, and allows the user to import all or a subset (based on Country, State, or Province). 
#' @data_dir Directory within which the BBS compressed and decompressed files associated with the ScienceBase item will be stored. Location defaults to a new folder named after the ScienceBase identifier tag (sb_id), in ~/data-raw/<SB_ID>.
#' @version Specify the dataset release version (by release year) for retrieval from ScienceBase. Please see /data-raw/sb_items for a list of available datasets and their associated release year.
#' @sb_id Specify the dataset to download based on the unique ScienceBase Item identifier for retrieval from ScienceBase. If `version` is specified, this will be ignored.
#' @nations A vector of one or more country names for importing only a subset of the downloaded data. Capitalization ignored. Can be one of c(US, USA, United States, U.S.A., U.S., United States of America, CA, Canada, MX, Mexico). Country identities correspond with country codes (BBS): 484==Mexico; 124==Canada; 840==United States. State/region files DNE for Mexico as of November 2019
#' @states A vector of one or more state names for importing only a subset of the downloaded data. 
#' @overwrite Logical. Defaults to FALSE. If overwrite=TRUE existing files inside the data_dir will be overwritten. Unless the data have been modified by the maintainers (rare) or by the end user (more common), there will typically not be a need to overwrite these data.
#' @param country.namess Vector of country name(s), capitalization irrelevant. One of c(US, USA, United States, U.S.A., U.S., United States of America, CA, Canada, MX, Mexico). 
#' @param state.names Vector of state names Default = NULL (all states). See column 'State' in data("region_codes").
#' @param sb_dir Where to save the files associated with the ScienceBase item. efaults to (a created) folder within folder 'data-raw' in the current working directory.
#' @importFrom magrittr %>%
#' @importFrom utils download.file

get_bbs_data <- function(
    sb_id, 
    version, 
    dir, 
    overwrite=FALSE
)
require(dplyr)
require(magrittr)
# Retrieve dataset lookup table
sb_items <- readr::read_csv(here::here("/data-raw/sb_items.csv"))

# sb_id & version == NULL -------------------------------------------------
# If the sb_id and version are not defined, default to the most recent dataset release. 
    if(!exists("sb_id") & !exists("version")){
        sb_id <- sb_items %>%  filter(year_end == max(year_end)) %>% dplyr::select(sb_item) %>% as.character()
        
        message("Neither `sb_id` nor `version` were specified, therefore the collective we will retrieve the most recent version of the BBS dataset:\n",
                "    Title: ", sbtools::item_get_fields(sb_id,"title"))
    }    

# version is defined -------------------------------------------------
if(exists("version")){
    sb_id <- sb_items %>% filter(release_year==version) %>% 
        dplyr::select(sb_item) %>% as.character()
    }
    

# Identify and/or create a folder for the sb items ------------------------
if(!exists("sb_dir")){
    sb_dir <- paste0(here::here("data-raw/"), sb_id) # define the new directory
}
suppressWarnings(dir.create(sb_dir)) # create directory for data associated with the sb item (sb_id) if it does not already exist. 

# Download all files associated with the ScienceBase item (sb_id) ------------------------------------------
sbtools::item_file_download(sb_id = sb_id, 
                            dest_dir = sb_dir, 
                            overwrite_file = overwrite)


