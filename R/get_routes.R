#' @title Download and import the route-level information via FTP (USGS BBS)
#' @description This function downloads information about route location from the BBS FTP server.
#' @param data.dir Location for storing the routes.zip and unzipped file(s). We recommend storing this in the raw-data directory. 
#' @param routes.url URL for location of the routes.zip folder.
#' @param route.type Default = 1 (roadside surveys only). One or more numbers indicating route substrate (1=roadside;2=water;3=off-road; Default = 1, roadside only).
#' @param bbs.stratum Vector of BBS physiographic stratum codes by which to filter the routes.
#' @param bcr.num A vector of Bird Conservation Region codes where by which to filter the routes.
#' @return A dataframe containing route-level information. 
#' @param active.only Logical. Default=TRUE. Keep only active routes (ie.. Active==1). 
#' @param overwrite Logical. Default NULL. Will force overwrite existing file named "routes.csv" if it exists in data.dir. If NULL will prompt user to specify overwrite. 
#' @importFrom magrittr %>%
#' @export get_routes
#' @examples
#' # download and import the BBS route information
#' \dontrun{
#' routes <- get_routes()
#' }
#'

get_routes <- function(
    routes.url =  "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/routes.zip",
    data.dir = here::here("raw-data/"), 
    active.only = TRUE,
    route.type = 1,
    bbs.stratum = NULL,
    bcr.num = NULL, 
    overwrite=NULL
    ) {
    
    suppressWarnings(dir.create(data.dir))

    # Prompt to overwrite the routes data
    if(is.null(overwrite) & "routes.csv" %in% list.files(data.dir)){
       choice <- menu(c("Yes, download most recent version of routes.csv", "No, import existing routes.csv from local directory "))
       if(choice==1) overwrite <- TRUE
       if(choice==2) overwrite <- FALSE
       rm(choice)
    }

        
    if(overwrite | !("routes.csv" %in% list.files(data.dir))){ # if user wants to overwrite OR data DNE then download and unzip to file in data.dir
    # specify where routes.zip will be saved
    routes.local.path = paste0(data.dir, "/routes.zip")
    
    # Download route-level information 
    download.file(url=routes.url, destfile = routes.local.path)
    
    # unzip routes.zip
    unzip(routes.local.path, exdir = data.dir, overwrite = TRUE)
    }
   

    # read in the unzipped file
    routes <- read.csv(list.files(data.dir, pattern="routes.csv", full.names = TRUE))
    
    
    # Join region codes to the route information
    if(!exists("region_codes")) data(region_codes) # laod region_codes
    
    routes <- merge(routes, region_codes ) %>% dplyr::select(-zip_states)
    
    ##### FILTER THE ROUTES #######
    # Keep only active routes
    if(active.only) routes <- routes %>% dplyr::filter(Active==1)
    
    # Filter the routes if specified
    if (!is.null(bbs.stratum)) {
        routes <- routes %>%
            dplyr::filter(stratum %in% bbs.stratum)
    }
    
    # BCR numbers 
    if (!is.null(bcr.num)) {
        routes <- routes %>%
            dplyr::filter(BCR %in% bcr.num)
    }
    
    # BBS route types (e.g. road, water, offroad)
    if (!is.null(route.type)) {
        routes <- routes %>%
            dplyr::filter(RouteTypeID %in% route.type)
    }
    
    routes$State <- as.character(routes$State)
    routes$RouteName <- as.character(routes$RouteName)
    
    return(routes)
}
