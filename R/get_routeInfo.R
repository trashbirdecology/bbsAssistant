#' @title Download route information from USGS server
#' @description This function downloads information about route location from the BBS FTP server. This function was adapted from **oharar/rBBS** package.
#' @param routeDir Location of the routes.zip folder Should be in DatFiles folder (default).
#' @param routeFile Name of the route information file. Usually "routes.zip".
#' @param routeTypeID One or more numbers indicating route substrate (1=roadside;2=water;3=off-road; Default = 1, roadside only).
#' @param Stratum A vector of BBS physiographic stratum codes by which to filter the routes.
#' @param BCR A vector of Bird Conservation Region codes where by which to filter the routes.
#' @return If download successful, a dataframe with the results.
#'
#' @examples
#' # download BBS route data.
#'
#' \dontrun{
#' RouteInfo <- get_routeInfo()
#' }
#'
#' @export get_routeInfo

get_routeInfo <- function(
    routesFile = "routes.zip",
                     routesDir =  "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/",
                         routeTypeID = 1,
                         # one or more of c(1,2,3)
                         Stratum = NULL,
                         BCR = NULL) {
    # Unzip from FTP server and store as an R object
    routeDat <-
        get_unzip(
            ZipName = paste0(routesDir, routesFile),
            FileName = gsub("^Fifty", "fifty", gsub("zip", "csv", routesFile))
        )
    
    # str(routeDat )
    # Force column names to lowercase
    names(routeDat) <- tolower(names(routeDat))
    
    # Filter the routes if specified
    
        if (!is.null(Stratum)) {
            routeDat <- routeDat %>%
                dplyr::filter(stratum %in% Stratum)
        }
        
        if (!is.null(BCR)) {
            routeDat <- routeDat %>%
                dplyr::filter(BCR %in% BCR)
        }
        
        
        if (!is.null(routeTypeID)) {
            routeDat <- routeDat %>%
                dplyr::filter(RouteTypeID %in% routeTypeID)
        }

    
    
    return(routeDat)
}