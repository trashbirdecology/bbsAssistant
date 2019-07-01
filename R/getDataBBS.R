# getDataBBS ##########################################################
#' @title Download USGS Breeding Bird Survey data
#' @description This function was adapted from **oharar/rBBS** package.
#' @param file One file name including the .zip extension ("stateX.zip"). Preferably download a single state at a time, otherwise run time will take >1 minutes.
#' @param dir URL to the StatesFiles.
#' @param year Vector of years. Default = NULL (all years).
#' @param aou Vector of AOU numeric codes. Default = NULL (all species). (For species list visit the BBS [FTP site]("ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/SpeciesList.txt"). 
#' @param countrynum Vector of country ID #'s. Default = NULL (all countryNums).
#' @param states Vector of state names Default = NULL (all states).
#'
#' @return If download successful, a dataframe with the results.
#'
#' @examples
#' # download all species and years from Nebraska.
#'
#' \dontrun{
#' NE <- getDataBBS(file = "Nebrask.zip")
#' }
#'
#' @export getDataBBS
#'
getDataBBS <- function(file,
                       dir =  "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/States/",
                       year = NULL,
                       aou = NULL,
                       countrynum = NULL,
                       states = NULL) {
    # Unzip the the state file(s)
    
    dat <-
        GetUnzip(ZipName = paste0(dir, file),
                 FileName = gsub("^Fifty", "fifty", gsub("zip", "csv", file)))
    
    names(dat) <- tolower(names(dat))
    
    ## Define subsetting parameters
    if(!is.null(countrynum)) dat <- dat %>%
        filter(countrynum %in% countrynum)
    
    if(!is.null(year)) dat <- dat %>%
        filter(year %in% year)
    
    if(!is.null(aou)) dat <- dat %>%
        filter(AOU %in% aou)
    
    if(!is.null(states)) dat <- dat %>%
        filter(statenum %in% states)
    
    
    
    if (nrow(dat) > 0) {
        dat$routeID <-
            paste(dat$statenum, dat[, grep("^[Rr]oute$", names(dat))])
        
        # dat <- subset(dat, subset = Use) ## NOT SURE WHAT THIS IS
        
        return(dat)
    } else
        warning("no data downloaded")
    return(NULL)
}