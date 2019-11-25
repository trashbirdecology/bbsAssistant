#' @title A wrapper function for downloading (`bbsAssistant::download_bbs()`) from the USGS FTP server and importing (`bbsAssistant::import_bbs()`) the BBS into the environment. 
#' @description This function wraps the functions `bbsAssistant::download_bbs()` and `bbsAssistant::import_bbs()` for speedy retrieval and imortation of all or a selection of the BBS point count data into the local environment
#' @param data.link URL to the location of 'States' compressed files on the USGS server. Defaults to the FTP location.
#' @param country.namess Vector of country name(s), capitalization irrelevant. One of c(US, USA, United States, U.S.A., U.S., United States of America, CA, Canada, MX, Mexico). Country identities correspond with country codes (BBS): 484==Mexico; 124==Canada; 840==United States. State/region files DNE for Mexico as of November 2019
#' @param state.names Vector of state names to be downloaded and imported (using functions `bbsAssistant::downoad_bbs()` and `bbsAssistant::import_bbs()`. Default = NULL (all states). See column 'State' in data("region_codes").
#' @param data.dir Where to save the 'raw' BBS data. Defaults to subdir 'raw-data' in the current working directory. 
#' @ return A data frame containing the BBS point count data
#' @importFrom utils download.file
#' @importFrom magrittr %>%
#' @export quick_get_bbs


quick_get_bbs <- function(
    data.link =  "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/States/",
    data.dir = here::here("raw-data/"),
    country.names= NULL, 
    state.names = NULL
){
    # download bbs data; if .zip files exist in data.dir will prompt user to overwrite or cancel download
    bbsAssistant::download_bbs(data.link, data.dir, country.names, state.names)
    # import all or selected .zip files from data.dir
    data <- bbsAssistant::import_bbs(data.dir, state.names)
    
    
    return(data)
}