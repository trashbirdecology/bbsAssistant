#' @title Download (and optionally subset) USGS Breeding Bird Survey data to file and import into the environment.
#' @description This function downloads a select subset or all the compressed, state-level BBS data from the USGS server via FTP. Parts of this function were adapted from [**oharar/rBBS**](http://www.github.com/oharar/rbbs). Note: this function requires an internet connection. If the bbs data are on file, please specify in the parameter `file`.
#' @param data.link URL to the location of 'States' compressed files on the USGS server. Defaults to the FTP location.
#' @param year Vector of years. Default = NULL (all years available).
#' @param aou Vector of AOU numeric codes. Default = NULL (all species). For species list visit the BBS FTP site (ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/), or use `get_SpeciesList`.
#' @param country.nums Vector of country ID #'s. Default = NULL (all countryNums). Codes: 484==Mexico; 124==Canada; 840==Canada. State/region files DNE for Mexico as of November 2019
#' @param state.names Vector of state names Default = NULL (all states). See column 'State' in data("region_codes").
#' @param state.nums Vector of state numbers (used by BBS). Default = NULL (all states). See column 'StateNum' in data("region_codes").
#' @param common.names Vector of common names (please see `get_speciesList()` column `commonName` for common name formatting). To avoid errors, we recommend indexing by AOU numbers
#' @param data.dir Where to save the 'raw' BBS data. Defaults to subdir 'raw-data' in the current working directory. 
#' @param ext File extension for saving the BBS state-level 'raw' data to file. Default = "csv". 
#' @importFrom magrittr %>%
#' @importFrom utils download.file
#' @importFrom utils read.csv
#' @importFrom utils read.table
#' @importFrom stats family
#' @return .zip files saved to local directory, as specified by data.dir
#' @examples
#' # Load the region codes into memory
#' \dontrun{
#' data("region_codes")
#' unique(region_codes$zip_states)
#' }
#'
#' # download all species and years from Nebraska.
#' \dontrun{
#' NE <- download_bbs(file = "Nebrask.zip")
#' }
#'
#' @export download_bbs
#'
download_bbs <-
    function(data.link =  "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/States/",
             year = NULL,
             aou = NULL,
             country.nums = NULL,
             state.names = NULL,
             state.nums = NULL, 
             ext = "csv", 
             data.dir = here::here("raw-data/")
             ) {
        
        ##### ERRORS #####
        # Do not proceed if state names and numbers are specified!
        if (!is.null(state.names) &
            !is.null(state.nums)){
            stop(
                'Both arguments,  "state.nums" and "state.names" are specified. \nPlease specify only one!'
            )
        }
        
        # Stop if country.nums are misspecified
        if(!is.null(country.nums)){
            if(!country.nums %in% c(124, 484, 840)){
                stop("Argument country.nums must be NULL or one of c(124, 484, 480).")
            }
        }
        ##### END ERRORS #####   
     
     
    # Load region_codes into memory to access the .zip filenames for retrieving data...   
     data(region_codes) 
     
      ## If country.nums is specified, then subset the list of filenames for downloading to speed things up. 
      if(!is.null(country.nums)){
          region_codes <- region_codes %>% dplyr::filter(CountryNum %in% country.nums)}


    # Download each .zip file and save to local machine
    urls <- paste0(data.link, region_codes$zip_states)
    
        
    # Make sure the user wants to overwrite existing data. 
    if(length(list.files(data.dir))>0){
        choice <- menu(c(paste0("Yes, overwrite files to ", data.dir),
               "No, cancel download.")
             )
        }     
    # Retrieve and save the state-level files specified in 'files'   to local disk      
    # Download the select (or all) state data from the FTP server and unzip the files to a temporary folder, as specified by `files`.
    if(choice == 1) {
        for (i in seq_along(urls)) {
            state <- region_codes$State[i]
            if (state %in% c("District of Columbia", 'PUERTO RICO'))
                next(paste0("Skipping ", state))
            
            cat("Saving state .zip file", i, " of ", length(urls), "\n")
            fn.local <- paste0(data.dir, state, ".zip")
            suppressMessages(download.file(url = urls[i], destfile = fn.local))
            cat("Files saved locally in directory ", data.dir)
        }
    }
    }
    if(choice == 2) print("NO DATA DOWNLOADED.")
