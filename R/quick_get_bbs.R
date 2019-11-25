#' @title A wrapper function for downloading (`bbsAssistant::download_bbs()`) from the USGS FTP server and importing (`bbsAssistant::import_bbs()`) the BBS into the environment. 
#' @description This function wraps the functions `bbsAssistant::download_bbs()` and `bbsAssistant::import_bbs()` for speedy retrieval and imortation of all or a selection of the BBS point count data into the local environment
#' @param data.link URL to the location of 'States' compressed files on the USGS server. Defaults to the FTP location.
#' @param country.namess Vector of country name(s), capitalization irrelevant. One of c(US, USA, United States, U.S.A., U.S., United States of America, CA, Canada, MX, Mexico). Country identities correspond with country codes (BBS): 484==Mexico; 124==Canada; 840==United States. State/region files DNE for Mexico as of November 2019
#' @param state.names Vector of state names to be downloaded and imported (using functions `bbsAssistant::downoad_bbs()` and `bbsAssistant::import_bbs()`. Default = NULL (all states). See column 'State' in data("region_codes").
#' @param data.dir Where to save the 'raw' BBS data. Defaults to subdir 'raw-data' in the current working directory.
#' @param overwrite.bbs Logical. Defaults NULL. If TRUE will overwrite existing BBS data in data.dir. NULL will prompt user to force overwrite if .zip files exist in data.dir.
#' @param overwrite.routes Logical. Defaults NULL. If TRUE will overwrite existing routes.csv data in data.dir. NULL will prompt user to force overwrite if routes.csv exists in data.dir.
#' @param overwrite.conditions Logical. Defaults NULL. If TRUE will overwrite existing Weather.csv data in data.dir. NULL will prompt user to force overwrite if Weather.csv exists in data.dir.
#' @param get.conditions Logical. Defaults FALSE. If true, will append the route-level conditions to the data frame. 
#' @return A data frame containing the BBS point count data and the route-level geographical information (e.g. Lat, Long, Bird Conservation Region number (BCR)).
#' @importFrom utils download.file
#' @importFrom magrittr %>%
#' @export quick_get_bbs
quick_get_bbs <- function(
    data.link =  "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/States/",
    data.dir = here::here("raw-data/"),
    country.names= NULL, 
    state.names = NULL, 
    overwrite.bbs = NULL,
    overwrite.routes = NULL, 
    get.conditions = FALSE, 
    overwrite.conditions = NULL
    ){
    # download bbs data; if .zip files exist in data.dir will prompt user to overwrite or cancel download
    download_bbs(data.link =  data.link, data.dir =  data.dir, country.names = country.names, state.names =  state.names, overwrite.bbs = overwrite.bbs)
    # import all or selected .zip files from data.dir
    data <- import_bbs(data.dir = data.dir ,  state.names = state.names, overwrite.routes = overwrite.routes)
    
    if(get.conditions) {
        ## Get the conditions (weather)
        conds <- get_conditions(data.dir = data.dir, overwrite=overwrite.conditions)
        ## Join conditions data with bbs data frame
        data <- left_join(data, conds)    
        
        # PRINT SELECT ERRORS and WARNINGS TO FILE 
        messages.dir <- paste0(data.dir, "messages/"); suppressWarnings(dir.create(messages.dir))
        ## Get and print which appear in the bbs data frame but NOT in the routes data frame: 
        missing.conditions <- setdiff(data %>% distinct(CountryNum, StateNum, Route), 
                                  conds %>% distinct(CountryNum, StateNum, Route)) 
        ## write to file the missing routes message
        if(nrow(missing.conditions)>0){
           missing.conditions[1,ncol(missing.conditions)] <- paste0("This file contains the Country x State x Route combinations which appeared in the BBS data inquiry which you retrieved and imported but did not appear in the file ", data.dir, "routes.csv")
            fn <- paste0(messages.dir,Sys.Date(), "_missing-conditions.txt")
            write.table(x=missing.conditions, file=fn, sep = ",")
            warning(paste0("There were discrepancies among the routes present in the BBS data you imported and the routes present in the conditions files (Weather.csv) \n\nPlease see file  ", 
                           fn, 
                           " for more information. "))
        } # end if missing.conditions rows >0 (print to textfile)
    
    } # end if statement for get.conditions
    
    return(data)
}