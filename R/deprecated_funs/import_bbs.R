#' @title  Import BBS data into R from file.
#' @description Import compressed (.zip) BBS data from file, combine all regions/states into a single data.frame object and load into environment.
#' @param data.dir Location of the compressed (.zip) route-level files (one per region/states) to be imported into R. Files will also be unzipped to this directory as ".csv".
#' @param state.names Vector of state names Default = NULL (all states). See column 'State' in data("region_codes").
#' @param overwrite.routes Logical. Default TRUE will download and overwrite any existing files named "routes.csv" in data.dir.
#' @importFrom magrittr %>%
#' @export import_bbs

import_bbs <- function(data.dir=paste0(getwd(),"/raw-data/"), 
                       state.names=NULL, 
                       overwrite.routes = TRUE) {
require(dplyr)
  
        # Pull in the region code file to identify .zip filenames..
        data(region_codes)
        # Removing those with missing ZIp_states (i.e. Mexico...)
        region_codes <- region_codes %>% dplyr::filter(zip_states != "NA" )
            
        # Force state.names to upepr
        region_codes$State <- toupper(region_codes$State)
        
        # Force state.names toupper
        
    # If specific regions/states desired, reduce options for identifying files 
    if (!is.null(state.names)) {
        state.names <- toupper(state.names)
        file_names <-
            region_codes %>% dplyr::filter(State %in% state.names)
        file_names <- file_names$State # we want a vector and not a df...
        
        }else( # identify all .zip files in directory which match those listed as regions. We should do this because we might store other .zip files in the same directory.
        file_names <- region_codes$State 
        )
        
        # Idenitfy all files in dir which match file.names
        file.paths <- NULL
        for(i in seq_along(file_names)){
          file.paths[i] <- list.files(data.dir, pattern=file_names[i], full.names=TRUE)
                      }
        
          
    if(is.null(file.paths) | length(file.paths)==0) stop("No files to import. If `state.names` is specified, please ensure files exist in `data.dir`.")
            
    # Decompress the files to the data.dir.  
    for(i in seq_along(file.paths)){
      print(paste0("Decompressing file ", i ," of ", length(file.paths)))
      if(i==1){unzipped.file.paths = NULL}
        unzipped.file.paths[i] <- 
            unzip(file.paths[i], exdir = data.dir, overwrite = TRUE) # will overwrite existing files....
    }
    # Now import all files which were just unzipped.     
    for(i in seq_along(unzipped.file.paths)){
        print(paste0("Importing decompressed file ", i ," of ", length(unzipped.file.paths)))
       # Create empty df for storing all decompressed data.frames
        if(i==1){bbs.df <-NULL}
     
      # Combine region-level data
        bbs.df <- bind_rows(bbs.df, read.csv(unzipped.file.paths[i]))   
    }

   # Add a column for State (state, region name) to the bbs data frame to make life a lot easier...   
   if(!exists("routes")) 
   routes <- get_routes(data.dir = data.dir, overwrite=overwrite.routes) #import routes if DNE
   states <-  unique(routes[c("StateNum", "State")])
     
   # Join the state information with the BBS data
   if(setdiff(bbs.df$StateNum, states$StateNum) %>% length() == 0){bbs.df <- left_join(bbs.df, states)}else(warning("Something is up with your StateNums. Some StateNums do not exist in `region_codes$StateNum`. You've got problems, friend."))
   
   # Join the route-level information (e.g. BCR, Latlon)
   bbs <- left_join(bbs.df, routes)
   
   
  # PRINT SELECT ERRORS and WARNINGS TO FILE 
  messages.dir <- paste0(data.dir, "messages/"); suppressWarnings(dir.create(messages.dir))
  
    ## Get and print which appear in the bbs data frame but NOT in the routes data frame: 
    missing.routes <- setdiff(bbs.df %>% distinct(CountryNum, StateNum, Route), 
             routes %>% distinct(CountryNum, StateNum, Route)
              ) %>% left_join(states) %>% 
      mutate(message = NA)
    ## write to file the missing routes message
    if(nrow(missing.routes)>0){
      missing.routes[1,ncol(missing.routes)] <- paste0("This file contains the Country x State x Route combinations which appeared in the BBS data inquiry which you retrieved and imported but did not appear in the file ", data.dir, "routes.csv")
      fn <- paste0(messages.dir,Sys.Date(), "_missing-routes.txt")
      write.table(x=missing.routes, file=fn, sep = ",")
      warning(paste0("There were discrepancies among the routes present in the BBS data you imported and the routes listed in routes.csv. \n\nPlease see file  ", 
                     fn, 
                     " for more information. "))
}

 return(bbs)
    
} # end function


