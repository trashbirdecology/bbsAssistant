#' @title Save BBS dataframe as a feather file on disk. 
#' @description Save the BBS data frame as a feather file to disk for easier import.
#' @param dataIn Data to be saved to local disk (e.g., /bbsData/). This data frame is a product of merging route information and raw count data. Data frame should have at least the columns dplyr::select(year, countrynum, statenum, route, bcr, latitude, longitude,aou, stoptotal).
#' @param newDir Where to save the BBS data as feathers. If not specified will default to /bbsData/.
#' @param filename Name of the new filename (e.g., 'arizona.zip'). This should be the same filename used to import the .zip from FTP (i.e, it should end with ".zip") This function will replace .zip with .feather
#' @importFrom magrittr %>%
#' @export export_bbsFeathers

export_bbsFeathers <- function(dataIn, newDir= here::here("bbsData/"), filename) {

    # Create newDir if DNE 
    dir.create(newDir)
    
    # make sure the bbsDar ends in "/" (windows vs. mac os issue..)
   if(substr(newDir, nchar(newDir), nchar(newDir)) != "/") newDir <- paste0(newDir, "/")

     
    # Create the new filename as .feather
    filename = gsub(".zip" , ".feather", filename)
    
    
    
    # Keep only necessary columns
    temp = dataIn %>%
        dplyr::select(year, countrynum, statenum, route, 
                      aou, stoptotal,
                      # these are optional, the others are necessary for most purposes.
                      contains("bcr"), contains("latitude"), contains("longitude")
        )
    
    # Write to disk
    feather::write_feather(x = temp, path = paste0(newDir, filename))
    
    
}

