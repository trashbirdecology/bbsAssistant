#' @title Import Species Metadata
#' @description Imports the file specieslist.txt. Is subsequently appended to the BBS dataset in \code{import_bbs_data()}
#'
#' @title Import the species list comprising names and numeric identifiers.
#' @param bbs_dir Directory for the ScienceBase (sb) item.
#' @importFrom dplyr left_join
#' @importFrom readr read_fwf
#' @export import_species_list
import_species_list <- function(bbs_dir){
    fn <- list.files(bbs_dir, full.names=TRUE, pattern="SpeciesList")

    # read first 50 lines to determine n linse to skip
    species_list <- readr::read_fwf(fn, n_max = 50, show_col_types = FALSE)

    # newest version has different n rows of text at the top so use line row to
    # find start of table
    ln_row <- stringr::str_which(species_list[[1]], "---")

    species_list <- readr::read_fwf(fn, skip = ln_row - 2, show_col_types = FALSE)## currently the best function for guessing the fixed widths...
    ## unfortunately, need to manually assign row 1 as header and remove the "line" row
    # names=as.vector(c(species_list[1,]))

    temp <- lapply(species_list[1, ], as.character)
    species_list <- species_list[-c(1:2),]

    colnames(species_list) <- temp

    species_list$AOU <- as.integer(as.character(species_list$AOU))

    ## Join this species list with the package data list
    species_list <- dplyr::left_join(species_list,
                                     bbsAssistant::species_list %>% select(-Seq),
                                     by = dplyr::join_by(AOU, English_Common_Name,
                                                  Spanish_Common_Name, ORDER, Family,
                                                  Genus, Species))

    return(species_list)
}
