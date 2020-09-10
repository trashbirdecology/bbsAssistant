#' @title One-stop shop for downloading and importing the USGS Breeding Bird Survey observations data. 
#' @description This function downloads all files assocaited with a single version (defaults to the most recent release) of the BBS observations dataset from USGS ScienceBase repository, and allows the user to import all or a subset (based on Country, State, or Province). 
#' @param data_dir Directory within which the BBS compressed and decompressed files associated with the ScienceBase item will be stored. Location defaults to a new folder named after the ScienceBase identifier tag (sb_id), in ~/data-raw/<SB_ID>.
#' @param bbs_version Specify the dataset release version (by release year) for retrieval from ScienceBase. Please see /data-raw/sb_items for a list of available datasets and their associated release year.
#' @param sb_id Specify the dataset to download based on the unique ScienceBase Item identifier for retrieval from ScienceBase. If `bbs_version` is specified, this will be ignored.
#' @param sb_dir Where to save the files associated with the ScienceBase item. efaults to (a created) folder within folder 'data-raw' in the current working directory.
#' @param country A vector of one or more country names for importing only a subset of the downloaded data. Capitalization ignored. Can be one of c(US, USA, United States, U.S.A., U.S., United States of America, CA, Canada, MX, Mexico). Country identities correspond with country codes (BBS): 484==Mexico; 124==Canada; 840==United States. State/region files DNE for Mexico as of November 2019
#' @param state A vector of one or more state names for importing only a subset of the downloaded data. 
#' @param country Vector of country name(s), capitalization irrelevant. One of c(US, USA, United States, U.S.A., U.S., United States of America, CA, Canada, MX, Mexico). 
#' @param state Vector of state names Default = NULL (all states). See column 'State' in data("region_codes").
#' @importFrom magrittr %>%
#' @importFrom utils download.file
#' @export

get_bbs_data <- function(
    sb_id, 
    bbs_version, 
    dir, 
    country=NULL, 
    state=NULL
){
# Retrieve dataset lookup table -------------------------------------------
sb_items <- readr::read_csv(here::here("/data-raw/sb_items.csv"))

# When sb_id & bbs_version == NULL -------------------------------------------------
# If the sb_id and bbs_version are not defined, default to the most recent dataset release. 
    if(!exists("sb_id") & !exists("bbs_version")){
        ind=max(sb_items$release_year)
        sb_id <- sb_items[sb_items$release_year==ind,"sb_item"] %>% as.character()
        message("FYI: neither `sb_id` nor `bbs_version` were specified. \nDownloading the most recent version of the BBS dataset titled,\n",sbtools::item_get_fields(sb_id,"title"))
    }    

# When bbs_version is defined -------------------------------------------------
if(exists("bbs_version")){
    sb_id <- sb_items %>% filter(release_year) %>%  
        dplyr::select(sb_item) %>% as.character()
    }
    
# When sb_dir DNE, define it... ------------------------
if(!exists("sb_dir")){
    sb_dir <- paste0(here::here("data-raw/"), sb_id) # define the new directory
}

# Create sb_dir -----------------------------------------------------------
suppressWarnings(dir.create(sb_dir)) # create directory for data associated with the sb item (sb_id) if it does not already exist. 

# Download the SB item files via `download_bbs_data()` -------------------------------------------------------
download_bbs_data(sb_id, sb_dir)
    # TO DO: provide FILE subsetting via sbtools::item_get_file or something like that...

# Unzip the state files via `unpack_bbs_data()` --------------------------------------------------
unpack_bbs_data(sb_dir, state=state, country=country)

# Import bbs observations data  --------------------------------------------------------------------
bbs_data <- import_bbs_data(sb_dir, state=state, country=country)


# END FUNCTION ------------------------------------------------------------

message("¡¡¡PLEASE FOR THE LOVE OF .... SOMETHING YOU CARE ABOUT!!!!\nIf you use the BBS dataset in your publications, presentations, webpages, etc., please cite it. The citation for the dataset you just retrieved using `get_bbs_data()` is provided in the list, and is provided here, free of charge: \n","    ", bbs_data$citation)
return(bbs_data)
}