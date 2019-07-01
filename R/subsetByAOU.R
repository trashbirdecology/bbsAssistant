#' @param myData A data frame including the column "aou".
#' @title Subset the BBS data by species, functional traits, and/or body mass. Default is null. 
#' @param subset.by One or more of 'remove.fowl' (removes waterfowl), "remove.shorebirds" (removes shorebirds and waders),  'remove.shoreWaderFowl' (removes shorebirds, waders, and fowl).
# NEED TO INCLUDE @param mass Logical. Retrieves body mass information (Dunning reference).
#' @param aou.ind Numeric or vector of numeric values of the AOU codes. These are the species you want to REMOVE from analysis.
#' @param order.ind Character or vector of characters of taxonomic orders to remove
#' @param fam.ind Character or vector of characters of taxonomic family to remove
#' @export subsetByAOU

subsetByAOU <- function(myData, subset.by = NULL, 
                        aou.ind = NULL, order.ind = NULL, fam.ind = NULL
){
    
    ## The AOU species codes can be found at [the BBS FTP site]("ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/SpeciesList.txt").
    
    
    ## Will update to remove by families and orders for the remove.fowl etc...
    if("remove.fowl" %in% subset.by){
        myData <- myData %>%
            filter(!aou %in% c(1290:1780))
    }
    
    if( "remove.shorebirds" %in% subset.by){
        myData <- myData %>%
            filter(!aou %in% c(1290:1780))
    }
    
    if("remove.shoreWaderFowl" %in% subset.by){
        myData <- myData %>%
            filter(!aou %in% c(0000:2880))
    }
    
    
    
    ## Subset by taxonomic families
    if(!is.null(fam.ind)){
        myData <- myData %>%
            filter(!order %in% fam.ind)
    }
    
    
    ## Subset by taxonomic order
    if(!is.null(order.ind)){
        myData <- myData %>%
            filter(!order %in% order.ind)
    }
    
    ## Subset by AOU specific numbers. 
    if(!is.null(aou.ind)){
        myData <- myData %>%
            filter(!aou %in% aou.ind)
    }
    
    return(myData)
    
    
}