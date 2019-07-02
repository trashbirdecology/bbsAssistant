#' @description This function allows the user to subset the BBS data by specific species using AOU numbers.
#' @title Subset the BBS data by species, functional traits, and/or body mass. Default is null.
#' @param myData A data frame containing the BBS data. Must contain the column "aou".
#' @param aou.ind Numeric or vector of numeric values of the AOU codes. These are the species you want to REMOVE from analysis.
#' @param order.ind Character or vector of characters of taxonomic orders to remove
#' @param fam.ind Character or vector of characters of taxonomic family to remove
#' @export subset_speciesList
#' @example
#' # Download the species list text file used by BBS
subset_speciesList <- function(myData,
                        subset.by = NULL,
                        aou.ind = NULL,
                        order.ind = NULL,
                        fam.ind = NULL) {
    #### NEED TO UPDATE THE AOU numbers to reflect this
    ## The AOU species codes can be found at [the BBS FTP site]("ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/SpeciesList.txt").
    ## these are also downloaded using get_bbsAous()
    ## Will update to remove by families and orders for the remove.fowl etc...
    # if("remove.fowl" %in% subset.by){
    #     myData <- myData %>%
    #         filter(!aou %in% c(01290:01780))
    # }
    #
    # if( "remove.shorebirds" %in% subset.by){
    #     myData <- myData %>%
    #         filter(!aou %in% c(1290:1780))
    # }
    #
    # if("remove.shoreWaderFowl" %in% subset.by){
    #     myData <- myData %>%
    #         filter(!aou %in% c(00000:02880))
    # }
    
    
    
    ## Subset by taxonomic families
    if (!is.null(fam.ind)) {
        myData <- myData %>%
            filter(!family %in% fam.ind)
    }
    
    
    ## Subset by taxonomic order
    if (!is.null(order.ind)) {
        myData <- myData %>%
            filter(!order %in% order.ind)
    }
    
    ## Subset by AOU specific numbers.
    if (!is.null(aou.ind)) {
        myData <- myData %>%
            filter(!aou %in% aou.ind)
    }
    
    return(myData)
    
    
}
