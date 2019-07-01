# birdsToFeathers #########################################################
#' @title Save BBS dataframe as a feather file
#' @param dataIn The BBS data to save.
#' @param newDir Where to save the BBS feathers.
#' @param filename Name of the new filename (e.g., 'arizona.zip'). This function will replace .zip with .feather
#' @export birdsToFeathers

birdsToFeathers <- function(dataIn, newDir, filename) {
    
    # Create the new filename as .feather
    filename = gsub(".zip" , ".feather", filename)
    
    # Keep only necessary columns
    temp = dataIn %>%
        dplyr::select(year, countrynum, statenum, route, bcr, latitude, longitude,
                      aou, stoptotal)
    
    # WRite to disk
    write_feather(x = temp, path = paste0(newDir, filename))
    
    
}
