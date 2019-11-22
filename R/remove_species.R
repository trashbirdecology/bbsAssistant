#' @title Subset BBS dataframe by removing species or taxonomic groups. 
#' @description Subset the BBS dataframe by specifying particular taxonomic groups or species to remove from the species list. Quickly remove species from the dataframe by one or more of the following taxonomic groups: __family__ (fam.ind), __order__ (order.ind), __AOU #__ (aou.ind).
#' @param myData 
#' @param fam.ind Character vector containing one or more families (e.g., Tyrannidae) to __remove__ from the data frame.
#' @param order.ind Character vector containing one or more orders (e.g., Podicipediformes) to __remove__ from the data frame.
#' @param latin.ind Character vector containing one or more latin names (species-level) to __remove__ from the data frame. 
#' @export
#' @example 
remove_species <- function(myData, fam.ind=NULL, order.ind=NULL, aou.ind=NULL, latin.ind ) {
    
    
    ## Subset by taxonomic families
    if (!is.null(fam.ind)) {
        myData <- myData %>%
            dplyr::filter(!family %in% fam.ind)
    }
    
    
    ## Subset by taxonomic order
    if (!is.null(order.ind)) {
        myData <- myData %>%
            dplyr::filter(!order %in% order.ind)
    }
    
    ## Subset by AOU specific numbers.
    if (!is.null(aou.ind)) {
        myData <- myData %>%
            dplyr::filter(!aou %in% aou.ind)
    }
    
    
    ## Subset by AOU specific numbers.
    if (!is.null(latin.ind)) {
        myData <- myData %>%
            dplyr::filter(!aou %in% aou.ind)
    }
    
    return(myData)
    
}

