# Read in list of species names, from SpeciesList.txt, and then extract list of where the data is kept
#' @title Download species names
#' @description Read in list of species names, from SpeciesList.txt, and then extract list of where the data is kept. This function was borrowed from the function [rBBS::getSpNames()](https://github.com/oharar/rBBS/blob/master/R/getspnames.r).
#' @param Dir ftp URL for directory with data files
#' @return A dataframe
#' @export get_speciesList

get_speciesList <- function(Dir="ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/") {
    File <- paste0(Dir, "SpeciesList.txt")
    
    All <- scan(File, what="character", sep="\n", encoding="latin1")
    Delimiter <- grep("^-", All)
    
    ColNames <- strsplit(All[Delimiter-1], split='[[:blank:]]+')[[1]]
    Widths <- nchar(strsplit(All[Delimiter], split='[[:blank:]]+')[[1]])
    
    Lines <- sapply(All[-(1:Delimiter)], function(str, w) {
        trimws(substring(str, c(1,cumsum(w[-length(w)])), cumsum(w)))
    }, w=Widths+1)
    colnames(Lines) <- NULL
    rownames(Lines) <- ColNames
    
    Lines.df <- as.data.frame(t(Lines), stringsAsFactors = FALSE)
    Lines.df$Seq <- as.numeric(Lines.df$Seq)
    Lines.df$AOU <- as.numeric(Lines.df$AOU)
    names(Lines.df) <- c("seq", "aou", "commonName","frenchCommonName", "scientificName", "order", "family","genus", "species")
    
    Lines.df
    
}
