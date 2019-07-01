#' @title Import the species list used by the BBS from website or local disk.
#' @param file A character string for location for the species list (as .txt).
#' @param skipEmpty Numeric, default = 7. The number of lines to skip. This may need to be updated if the file on webpage changes. 
#' @export getSppListBBS

getSppListBBS <- function(file="ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/SpeciesList.txt", 
                          skip=7
){
    
    file <- url("ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/SpeciesList.txt")
    sppListBBS <- readr::read_table(file, col_names=TRUE, skip=7) %>% 
        filter(! str_detect(AOU, "---"))
}