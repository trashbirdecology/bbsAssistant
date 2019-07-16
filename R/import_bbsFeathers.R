#' @title Load the BBS data feathers into R.
#' @description This function loads .feather files into disk given a directory. 
#' @param newDir Where the BBS feathers are saved.
#' @param filename Name of the feather filename (e.g., 'arizona.zip' or 'arizona'). This function will replace .zip with .feather when necessary.
#' @export import_bbsFeathers

import_bbsFeathers <- function(newDir, filename) {
    
    # Create the new filename as .feather
    filename = gsub(".zip" , ".feather", filename)
    
    feather <- feather::read_feather(path = paste0(newDir, filename))
    
    return(feather)
}
