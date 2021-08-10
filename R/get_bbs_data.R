#' @title One-stop shop for downloading and importing the USGS Breeding Bird Survey observations data. 
#' @description This function downloads all files associated with a single version (defaults to the most recent release) of the BBS observations dataset from USGS ScienceBase repository, and allows the user to import all or a subset (based on Country, State, or Province). 
#' @param sb_dir Directory within which the BBS compressed and decompressed files associated with the ScienceBase item will be stored. Location defaults to a new folder named after the ScienceBase identifier tag (sb_id), in ~/data-raw/<SB_ID>.
#' @param bbs_version Specify the dataset release version (by release year) for retrieval from ScienceBase. Please see /data-raw/sb_items for a list of available datasets and their associated release year.
#' @param sb_id Specify the dataset to download based on the unique ScienceBase Item identifier for retrieval from ScienceBase. If `bbs_version` is specified, this will be ignored.
#' @param country A vector of one or more country names for importing only a subset of the downloaded data. Capitalization ignored. Can be one of c(US, USA, United States, U.S.A., U.S., United States of America, CA, Canada, MX, Mexico). Country identities correspond with country codes (BBS): 484==Mexico; 124==Canada; 840==United States. State/region files DNE for Mexico as of November 2019
#' @param state A vector of one or more state names for importing only a subset of the downloaded data. 
#' @param country Vector of country name(s), capitalization irrelevant. One of c(US, USA, United States, U.S.A., U.S., United States of America, CA, Canada, MX, Mexico). 
#' @param state Vector of state names Default = NULL (all states). See column 'State' in data("region_codes").
#' @param overwrite Logical. Default TRUE will overwrite the local files within sb_dir (defaults to /data-raw/). 
#'
#' 
#' @return A list comprising all relevant information and data associated with the specified BBS observations data release.
#' \itemize{
#'   \item observations - The BBS observations dataset comprising point counts for all all years up to the release specified.
#'   \item routes - Route metadata forassociated with the observations dataset at hand.
#'   \item weather - The weather observations associated with the observations dataset for all years and locations 
#'   \item citation - Citation for the BBS observations dataset release being used (per sb_id)
#'   \item species_list - The species list lookup table as released by the BBS for a given data release/year. See official BBS documentation for more details on taxonimc classifications.  
#'   \item sb_id - The ScienceBase Identifier for the dataset at hand. This is used internally for citation purposes.
#'   }
#'   
#' @importFrom magrittr %>%
#' @importFrom utils download.file
#' @importFrom stats "filter"
#' @importFrom utils "data"
#' @importFrom utils "unzip"
#' @export
#' 

get_bbs_data <- function(
    sb_id=NULL, 
    bbs_version=NULL, 
    sb_dir=NULL,
    country=NULL, 
    state=NULL, 
    overwrite=FALSE
){
  
# Retrieve dataset lookup table -------------------------------------------
# data(sb_items, package="bbsAssistant")
sb_items  <- bbsAssistant::sb_items
# When sb_id is undefined & bbs_version is defined -------------------------------------------------
if(is.null(sb_id) & !is.null(bbs_version)){
    sb_id <- sb_items %>% filter(release_year==bbs_version) %>%  
        dplyr::select(sb_item) %>% as.character()
}

# When sb_id & bbs_version == NULL -------------------------------------------------
# If the sb_id and bbs_version are not defined, default to the most recent dataset release. 
    if(is.null(sb_id)){
        ind=max(sb_items$release_year)
        sb_id <- sb_items[sb_items$release_year==ind,]$sb_item
        sb_id <- as.character(sb_id)
        message("FYI: neither `sb_id` nor `bbs_version` were specified. Therefore, the most recent version of the BBS dataset titled,\n",sbtools::item_get_fields(sb_id,"title"))
    }

# When sb_dir does not exist define and craete it ------------------------
if(is.null(sb_dir)){ 
    sb_dir <- paste0("./data-raw/", sb_id) # define the new directory
}

# Create sb_dir -----------------------------------------------------------
suppressWarnings(dir.create(sb_dir)) # create directory for data associated with the sb item (sb_id) if it does not already exist. 


# Download the SB item files via `download_bbs_data()` -------------------------------------------------------
if (overwrite |
    length(list.files(sb_dir)) == 0) {
  download_bbs_data(sb_id, sb_dir)
} else
  (paste(
    "BBS data directory ",
    sb_dir,
    " exists and is populated. To overwrite, please specify overwrite=TRUE in `get_bbs_data()`"
  ))

# Unzip the state files via `unpack_bbs_data()` --------------------------------------------------
if(is.null("state")) {state <- NULL}
if(is.null("country")) {country <- NULL}
bbsAssistant::unpack_bbs_data(sb_dir, state, country=country)


# Import bbs observations data  --------------------------------------------------------------------
bbs_data <- bbsAssistant::import_bbs_data(sb_id, sb_dir, state=state, country=country)

bbs_data$sb_id <- sb_id # add the sciencebase identifier as a list element


# END FUNCTION ------------------------------------------------------------
return(bbs_data)
}
