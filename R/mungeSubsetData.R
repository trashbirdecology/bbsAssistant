#' @description munge the subbsetted data
#' @title Munge the subsetting data
#' @param df A data frame
#' @export mungeSubsetData
#'
mungeSubsetData <- function(df){
    
    if(direction == "East-West"){
        df <- df %>%
            dplyr::rename(sortVar = long)
        
        
    }
    if(direction == "South-North"){
        df <- df %>%
            dplyr::rename(sortVar = lat)
    }
    
    
    birdData <- df %>%
        # sum over species/sites to account for hybrid and UNID races
        dplyr::group_by(sortVar, cellID, direction, dirID, variable,year) %>%
        summarise(value = sum(value)) %>%
        dplyr::group_by(variable) %>%
        # need to arrange by time to make sure the distances are calculated correctly!
        arrange(variable, sortVar) %>%
        ungroup()
    
    return(birdData)
    
}