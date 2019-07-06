#' @title Download USGS Breeding Bird Survey data to file and import into the environment.
#' @description This function downloads a select subset or all the BBS data from the FTP server using the .txt file downloaded from get_regions() or using specified regions (e.g. Florida, Florida.zip). The data are saved to a temporary folder. This function was adapted from **oharar/rBBS** package. Note: this function requires an internet connection. If the bbs data are on file, please specify in the parameter `file`.
#' @param file One file name including the .zip extension ("stateX.zip"). Preferably download a single state at a time, otherwise run time will take >1 minutes.
#' @param dir URL to the StatesFiles.
#' @param year Vector of years. Default = NULL (all years).
#' @param aou Vector of AOU numeric codes. Default = NULL (all species). (For species list visit the BBS [FTP site]("ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/SpeciesList.txt").
#' @param countrynum Vector of country ID #'s. Default = NULL (all countryNums).
#' @param states Vector of state names Default = NULL (all states).
#' @importFrom magrittr %>%
#' @return If download successful, a dataframe with the results.
#' @examples
#' # download all species and years from Nebraska.
#'
#' \dontrun{
#' NE <- getDataBBS(file = "Nebrask.zip")
#' }
#'
#' @export get_bbsData
#'
get_bbsData <- function(file,
                        dir =  "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/States/",
                        year = NULL,
                        aou = NULL,
                        countrynum = NULL,
                        states = NULL) {
    # Download and unzip the files as specified by file.
    dat <-
        get_unzip(ZipName = paste0(dir, file),
                  FileName = gsub("^Fifty", "fifty", gsub("zip", "csv", file)))
    
    # Force col names to lowercase
    names(dat) <- tolower(names(dat))
    
# Subset the data if specified
## by country
if (!is.null(countrynum)) dat <- dat %>%
    filter(countrynum %in% countrynum)

## by state/region
if (!is.null(states))
    dat <- dat %>%
    filter(statenum %in% states)

## by year
if (!is.null(year))
        dat <- dat %>%
        filter(year %in% year)
    
## by species (aou codes)
if (!is.null(aou)) dat <- dat %>%
    filter(AOU %in% aou)
    
    
# Fix the statenum    
    if (nrow(dat) > 0) {
        dat$routeID <-
            paste(dat$statenum, dat[, grep("^[Rr]oute$", names(dat))])
        
print("Data were imported from the FTP server")
return(dat)
    } else
        warning("No data were imported from the FTP server. Check subsetting parameters.")
return(NULL)
}

