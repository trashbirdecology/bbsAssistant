#' @title Download (and optionally subset) USGS Breeding Bird Survey data to file and import into the environment.
#' @description This function downloads a select subset or all the compressed, state-level BBS data from the USGS server via FTP. Parts of this function were adapted from [**oharar/rBBS**](http://www.github.com/oharar/rbbs). Note: this function requires an internet connection. If the bbs data are on file, please specify in the parameter `file`.
#' @param data.link URL to the location of 'States' compressed files on the USGS server. Defaults to the FTP location.
#' @param country.namess Vector of country name(s), capitalization irrelevant. One of c(US, USA, United States, U.S.A., U.S., United States of America, CA, Canada, MX, Mexico). Country identities correspond with country codes (BBS): 484==Mexico; 124==Canada; 840==United States. State/region files DNE for Mexico as of November 2019
#' @param state.names Vector of state names Default = NULL (all states). See column 'State' in data("region_codes").
#' @param data.dir Where to save the 'raw' BBS data. Defaults to subdir 'raw-data' in the current working directory. 
#' @importFrom magrittr %>%
#' @importFrom utils download.file
#' @export download_bbs
#' @return .zip files saved to local directory, as specified by data.dir
#' @examples
#' # Load the region codes into memory
#' \dontrun{
#' data("region_codes")
#' unique(region_codes$zip_states) # list of zip files available via USGS BBS FTP.
#' }
#'
#' # download all route-level data from Canada
#' \dontrun{
#' download_bbs(state.names="Canada)
#' }
#'
#' # download all route-level data from Nebraska
#' \dontrun{
#' download_bbs(state.names="Nebraska")
#' }
#'
download_bbs <-
    function(data.link =  "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/States/",
             data.dir = here::here("raw-data/"),
             country.names= NULL, 
             state.names = NULL
             ) {
        
        ##### ERRORS #####
        # Stop if country.names are misspecified
        if(!is.null(country.names)){
          if(!toupper(country.names) %in% toupper(c("Mexico", "MX", "US", "USA", "U.S.A.", "United States","United States of America", "CA","Canada"))){
                stop("Argument country.nums must be NULL or one more of c('Mexico', 'MX', 'US', 'USA', 'United States', 'CA','Canada').")}
            
          # create an index for specifying country names
            country.ind <- NULL
            # United States
            if(toupper(country.names) %in% toupper(c("US", "USA", "U.S.A.", "United States", "United States of America"))){
              country.ind <- c(country.ind, 840)}
              # 84==Mexico; 124==Canada; 840==USA
            
            # Canada
            if(toupper(country.names) %in% toupper(c('CA', "Canada"))){
              country.ind <- c(country.ind, 124)}
            # 84==Mexico; 124==Canada; 840==USA
            
            # Mexico
            if(toupper(country.names) %in% toupper(c('MX', "Mexico"))){
              country.ind <- c(country.ind, 84)}
            # 84==Mexico; 124==Canada; 840==USA
            
        }
        ##### END ERRORS #####   
     
     
    # Load region_codes into memory to access the .zip filenames for retrieving data...   
     data(region_codes) 
      region_codes$State <- toupper(region_codes$State)

      # Force state.names to upper
      if(exists("state.names") & !is.null(state.names)){ 
        # force stae.names index
        state.names <- toupper(state.names)
      # keep only the state names specified in state.names
      region_codes <- region_codes %>% dplyr::filter(State %in% state.names)
      
      }
      
      ## If conuntry.names is specified, then country.ind was created. Subset the list of filenames for downloading to speed things up. 
      if(exists("country.ind")){
        if(!is.null(country.ind)){
          region_codes <- region_codes %>% dplyr::filter(CountryNum %in% country.ind)}}

      
    # Download each .zip file and save to local machine
    urls <- paste0(data.link, region_codes$zip_states)
    
    # Make sure the user wants to overwrite existing data. 
    if(length(list.files(data.dir))>0){
        choice <- menu(c(paste0("Yes, overwrite files to ", data.dir),
               "No, cancel download.")
             )
        }else(choice <- 1)     
    
    # Retrieve and save the state-level files specified in 'files'   to local disk      
    # Download the select (or all) state data from the FTP server and unzip the files to a temporary folder, as specified by `files`.
    if(choice == 1) {
        for (i in seq_along(urls)) {
          ## deal with a pesky "NA" in an inefficient manner..
              #### if the url == ...NA then skip
            if(urls[i]=="ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/States/NA")next() 
            
          state.name <- region_codes$State[i]
            
            # if (state %in% c("District of Columbia", 'PUERTO RICO'))
            #     next(paste0("Skipping ", state))
            
            cat("Saving state .zip file", i, " of ", length(urls), "\n")
            fn.local <- paste0(data.dir, state.name, ".zip")
            suppressMessages(download.file(url = urls[i], destfile = fn.local))
            cat("Files saved locally in directory ", data.dir)
            }
    }
    if(choice == 2) print("NO DATA DOWNLOADED.")
    }



    
