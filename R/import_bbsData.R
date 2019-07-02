#' @title A wrapper function for downloading raw data, filtering by species names/AOU codes, and merging with route information.
#' @description This function will import BBS data which has already been downloaded to file. Some parts of this function were borrowed from **oharar/rBBS**.  
#' @param dir http:// pr ftp:/ link to bbs data location (here: state files)
#' @param zipFileNames One or more file names ("state.zip"), char vector. Preferably download a single state at a time, otherwise run time will take >1 minutes.
#' @param countrynum Vector of country ID #'s. Default = NULL (all countryNums).
#' @param countryName Vector of country names. Default = NULL (all countryNames).
#' @param aou Vector of AOU #s Default = NULL (all species).
#' @param year Vector of years. Default = NULL (all years).
#' @param states Vector of state names Default = NULL (all states).
#' @param regions Vector of regionCodes. Default = NULL (all regions).
#' @param routeDir Location of the routes.zip folder Should be in DatFiles folder (default).
#' @param routeFile Name of the route information file. Usually "routes.zip".
#' @param RouteTypeID One or more numbers indicating route substrate (1=roadside;2=water;3=off-road; Default = 1, roadside only).
#' @param Stratum A vector of BBS physiographic stratum codes by which to filter the routes.
#' @param BCR A vector of Bird Conservation Region codes where by which to filter the routes.
#' @param file The name of the zipfile to be downloaded from dir
#' @export import_bbsData

import_bbsData <- function(
    file,
    dir ,
    year = NULL,
    aou = NULL,
    countrynum = NULL,
    states = NULL,
    #  getRouteInfo():
    routesFile = "routes.zip",
    routesDir =  "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/",
    RouteTypeID = 1, # one or more of c(1,2,3)
    Stratum = NULL,
    BCR = NULL
){
    
    # Download and munge the Species List from BBS
    ## this aou code is downloaded from the BBS server..
    aous <- get_speciesNames()
    
    # Fix scientific name
    aous$scientificName <-
        str_extract(aous$scientificName, "[A-Z][a-z]+\\ [a-z]+")
    
    # Remove unidentified and hybrid species
    aousEdit  <-
        aous[-grep("unid.", aous$commonName),] # Remove unidentified birds
    aousEdit   <-
        aousEdit[-grep("hybrid", aous$commonName),] # Remove unidentified birds
    
    rm(aous)
    
    
    # Load the .zip files into mem
    bbsData <-
        get_bbsData(file = file,
                   dir =  "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/States/",
                   year = NULL,
                   aou = NULL,
                   countrynum = NULL,
                   states = NULL
        )
    
    
    # Get the route information
    routeDat <- get_routeInfo(routesFile = "routes.zip",
                             routesDir =  "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/",
                             RouteTypeID = 1, # one or more of c(1,2,3)
                             Stratum = NULL,
                             BCR = NULL)
    
    
    
    # Merge the route info with the bbsData
    dataOut <- dplyr::inner_join(bbsData, routeDat)
    
    
    return(dataOut)
    
}

# End Run -----------------------------------------------------------------
