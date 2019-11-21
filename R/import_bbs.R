#' @title  Import BBS data into R from file.
#' @description Import compressed (.zip) BBS data from file, combine all regions/states into a single data.frame object and load into environment.
#' @param data.dir Location of the compressed (.zip) route-level files (one per region/states) to be imported into R. Files will also be unzipped to this directory as ".csv".
#' @param state.names Vector of state names Default = NULL (all states). See column 'State' in data("region_codes").
#' @importFrom magrittr %>%
#' @export import_bbs

import_bbs <- function(data.dir=paste0(getwd(),"/raw-data/"), state.names=NULL) {

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
        
        }else( # identify all .zip files in directory which match those listed as regions
        file_names <- region_codes$zip_states 
        )
        
        # Idenitfy all files in dir which match file.names
        for(i in seq_along(file_names)){
            if(i ==1) {file.paths <- NULL}
            file.paths <- c(file.paths, list.files(data.dir, pattern=file_names[i], full.names=TRUE))
            }
        
            
    if(is.null(file.paths) | length(file.paths)==0) stop("No files to import. If `state.names` is specified, please ensure files exist in `data.dir`.")
            
    # Decompress the files to the data.dir        
    for(i in seq_along(file.paths)){
        if(i==1){unzipped.file.paths = NULL}
        unzipped.file.paths[i] <- 
            unzip(file.paths[i], exdir = data.dir, overwrite = TRUE) # will overwrite existing files....
    }
    
    # Now import all files which were just unzipped.     
    for(i in seq_along(unzipped.file.paths)){
        print(paste0("Unzipping file ", i ," of ", length(unzipped.file.paths)))
       # Create empty df for storing all decompressed data.frames
        if(i==1){bbs.df <-NULL}
     
      # Combine region-level data
        bbs.df <- bind_rows(bbs.df, read.csv(unzipped.file.paths[i]))   
    }

    # Join region-level information to the data frame...
    bbs.df <- left_join(bbs.df, region_codes %>% dplyr::select(-zip_states) %>% mutate(StateNum=as.integer(StateNum), 
                                                                                       CountryNum=as.integer(CountryNum), 
                                                                                       State = as.character(State)))
        
   return(bbs.df)
    
} # end function

# End Run -----------------------------------------------------------------
