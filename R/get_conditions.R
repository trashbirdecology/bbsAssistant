#' @title Download and import the annual conditions per route  via FTP (USGS BBS)
#' @description This function downloads the 'weather.zip' file from the BBS FTP server. This data contains information on local weather conditions during each survey. Also includes auxiliary information about the survey methods, dates of surveys, and start and end times. This data will typically be incorporated into detection probability functions.
#' @param data.dir Location for storing the routes.zip and unzipped file(s). We recommend storing this in the raw-data directory. 
#' @param conds.url URL for location of the routes.zip folder.
#' @param active.only Logical. Default = FALSE. If true, keeps only the active routes.
#' @param overwrite Logical. Default = NULL. If true, will download and overwrite the existing file "Weather.zip" in data.dir.
#' @return A dataframe containing route-level information. 
#' @importFrom magrittr %>%
#' @export get_conditions
#' @examples
#' # download and import the BBS route information
#' \dontrun{
#' conditions.df <- get_conditions()
#' }
#'
get_conditions <- function(
    conds.url =  "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/Weather.zip",
    data.dir = here::here("raw-data/"), 
    active.only = FALSE, 
    overwrite=NULL
) {
    
    suppressWarnings(dir.create(data.dir))
    
    # Prompt to overwrite the routes data
    if("weather.csv" %in% list.files(data.dir) & is.null(overwrite)){
        choice <- menu(c("Yes, download most recent version of weather.csv", "No, import existing routes.csv from local directory "))
        if(choice==1) overwrite <- TRUE
        if(choice==2) overwrite <- FALSE
    }else(overwrite<-FALSE)

    # if the files don't exist then we must download    
    if(!("weather.csv" %in% list.files(data.dir)) | overwrite){ # if user wants to overwrite OR data DNE then download and unzip to file in data.dir
        # specify where routes.zip will be saved
        cond.local.path = paste0(data.dir, "Weather.zip")
        
        # Download route-level information 
        download.file(url=conds.url, destfile = cond.local.path)
        
        # unzip routes.zip
        unzip(zipfile = cond.local.path, exdir = data.dir, overwrite = TRUE)
    }
    
    
    # read in the unzipped file
    conditions.df <- read.csv(list.files(data.dir, pattern="weather.csv", full.names = TRUE))
    
    # add a real date column...
    conditions.df$Date <- as.Date(with(conditions.df, paste(Year, Month, Day, sep="-")), "%Y-%m-%d")
    
    return(conditions.df)
}

