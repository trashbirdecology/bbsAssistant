#' @description Unzips and imports the routes.zip (routes.csv) file associated with each BBS dataset. 
#' @title Import the route-level covariates/metadata associated with the BBS dataset.
#' @param sb_dir Directory for the ScienceBase (sb) item.
#' @export import_routes

import_routes <- function(sb_dir){
# Unzip the States.zip into the SB item directory  (sb_dir) 
    unzip(list.files(sb_dir, full.names=TRUE, pattern="routes.zip"), exdir = sb_dir)
    
    routes <- readr::read_csv(list.files(sb_dir, full.names=TRUE, pattern="routes.csv")) %>% 
        dplyr::mutate(StateNum = as.integer(StateNum),
               CountryNum = as.integer(CountryNum))
    
 return(routes)
}
