#' @title Download and import BBS, NACC, and AOU species list
#' @description Read in list of species names, alpha codes, and taxonomic information from various sources (BBS, AOU/AOS, IBP, NACC).
#' For more information on species alpha codes please visit https://www.birdpop.org/pages/birdSpeciesCodes.php
#' For more information on AOU/AOS/NACC species checklists please visit http://checklist.aou.org/
#'    Portions of this function (lines for importing and munging the BBS species list, specieslist.txt) were borrowed from the function [`rBBS::getSpNames()`](https://github.com/oharar/rBBS/blob/master/R/GetSpNames.R). This package is not actively maintained, therefore we export it via `bbsAssistant`.
#' @param bbs.spp.url URL for SpeciesList.txt file, retrieved via FTP.
#' @param nacc.spp.url URL for the NACC species checklist, which contains taxonomic sorting information no available in BBS SpeciesList.
#' @param aou.alpha URL for the 4- and 6-letter alpha codes associated with latin names (source: IBP).
#' @param data.dir Location of where to save the compressed and decompressed species lists and taxonomic files. Defaults to ~/raw-data
#' @return A list comprising the BBS species list (bbs.spp), the [NACC species checklist](http://checklist.aou.org/taxa.csv?type=charset%3Dutf-8%3Bsubspecies%3Dno%3B) (nacc.spp), and the AOU alpha checklist (aou.alpha). 
#' @export get_species 
#' 

get_species <- function(bbs.spp.url = "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/SpeciesList.txt",
                        nacc.spp.url = "http://checklist.aou.org/taxa.csv?type=charset%3Dutf-8%3Bsubspecies%3Dno%3B",
                        aou.alpha.url = "https://www.birdpop.org/docs/misc/IBPAOU.zip",
                        data.dir = paste0(getwd(), "/raw-data/")) {
    # make sure the data.dir exists
    suppressWarnings(dir.create(data.dir))
    
    # Retrieve and munge the BBS specieslist.txt
    temp <- list.files(data.dir, pattern = "SpeciesList.txt")
    if (length(temp) == 0) {
        # if it does not exist then download, munge, and write locally to avoid having to create internet connection.
        All <-
            scan(
                bbs.spp.url,
                what = "character",
                sep = "\n",
                encoding = "latin1"
            )
        Delimiter <- grep("^-", All)
        
        ColNames <-
            strsplit(All[Delimiter - 1], split = '[[:blank:]]+')[[1]]
        Widths <-
            nchar(strsplit(All[Delimiter], split = '[[:blank:]]+')[[1]])
        
        Lines <- sapply(All[-(1:Delimiter)], function(str, w) {
            trimws(substring(str, c(1, cumsum(w[-length(w)])), cumsum(w)))
        }, w = Widths + 1)
        colnames(Lines) <- NULL
        rownames(Lines) <- ColNames
        
        bbs.spp <- as.data.frame(t(Lines), stringsAsFactors = FALSE)
        bbs.spp$Seq <- as.numeric(bbs.spp$Seq)
        bbs.spp$AOU <- as.numeric(bbs.spp$AOU)
        names(bbs.spp) <-
            c(
                "seq",
                "aou",
                "common_eng",
                "common_fr",
                "latin",
                "order",
                "family",
                "genus",
                "species"
            )
        
        write.table(x = bbs.spp,
                    file = paste0(data.dir, "SpeciesList.txt"))
    } else
        (bbs.spp <- read.table(paste0(data.dir, "SpeciesList.txt")))
    
    
    
    # NACC species checklist (this takes a few seconds)
    temp <- list.files(data.dir,pattern="nacc.txt")
    if(length(temp)==0){ # if it does not exist then download, munge, and write locally to avoid having to create internet connection.
        nacc.spp <- read.csv(url(nacc.spp.url))
        write.table(x= nacc.spp, file = paste0(data.dir,"nacc.txt"))
    }else(nacc.spp <- read.table(paste0(data.dir,"nacc.txt")))
    
    
    
    # AOU Alpha codes linked to latin names
    temp <- list.files(data.dir,pattern="aou_alpha.txt")
    if(length(temp)==0){ # if it does not exist then download, munge, and write locally to avoid having to create internet connection.
        
        download.file(url = aou.alpha.url, destfile = paste0(data.dir,"aou_alpha.zip"))
        
            #grab the name of the file that is to be extracted from the .zip...
            aou.unzip.path <- paste0(data.dir, unzip(paste0(data.dir,"aou_alpha.zip"), 
                                                    list=TRUE)[1])
            #now actually extract it to file.
            fn <- list.files(data.dir,"aou_alpha.zip", full.names=TRUE)
            unzip(fn, exdir = data.dir) 
            #rename this file to something more intuitive...
            file.rename(from = aou.unzip.path,to = paste0(data.dir, "aou_alpha.txt"))
        

        aou.alpha <- read.csv(paste0(data.dir, "aou_alpha.txt"))

    }else(aou.alpha <- read.csv(paste0(data.dir, "aou_alpha.txt")))

    
    # Combine data frames into a single list for export
    species.lists <- list(bbs.spp, nacc.spp, aou.alpha)
    names(species.lists) <-c("BBS","NACC","AOU")
    return(species.lists)
    
    
    
    
}
