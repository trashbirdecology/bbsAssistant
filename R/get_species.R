#' #' title Munge the Species List
#' #' description This function is called in `get_bbs_data()` to munge the BBS species list with the AOU and NACC species lists. 
#' #' Resulting dataframe containing species names, alpha codes, and taxonomic information from various sources (currently uses BBS codes; to do:AOU/AOS, IBP, NACC).
#' #' For more information on species alpha codes please visit https://www.birdpop.org/pages/birdSpeciesCodes.php
#' #' For more information on AOU/AOS/NACC species checklists please visit http://checklist.aou.org/
#' #' Portions of this function (code for munging the BBS species text file, specieslist.txt) were borrowed or adapted from the function [`rBBS::getSpNames()`](https://github.com/oharar/rBBS/blob/master/R/GetSpNames.R). This package is not actively maintained, therefore we have released it in `bbsAssistant`
#' #' param aou Location of the compressed file for IBP's AOU taxonomic information and codes. 
#' #' param nacc Location of the file for NACC taxonomic information and codes. 
#' #' 
#' 
#' 
#' get_species <- function(sb_id = NULL,
#'                         dir = NULL, 
#'                         nacc = "http://checklist.aou.org/taxa.csv?type=charset%3Dutf-8%3Bsubspecies%3Dno%3B",
#'                         aou = "https://www.birdpop.org/docs/misc/IBPAOU.zip"
#' ) {
#'     
#'     if(is.null(dir))
#'     
#' }