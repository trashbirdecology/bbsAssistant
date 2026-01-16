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

    # read list in to determine how many ln_row we need to specify (i.e. skip the rows containing useless text.)
    ln_row <-
      stringr::str_which(readr::read_fwf(
        fn,
        show_col_types = FALSE
      )[[1]],
      "---")
    
    species_list <- readr::read_fwf(fn, skip = ln_row - 2,
                                    show_col_types = FALSE)## currently the best function for guessing the fixed widths...
   
    # I think the data is Windows-1252 encoded, so need to convert to UTF to handle downstream issues. 
    ## Read raw bytes from the file
    raw_bytes <- readBin(fn, what = "raw", n = file.info(fn)$size)
    ## Decode Windows-1252 (smart quotes, accents) to UTF-8
    decoded_txt <- iconv(rawToChar(raw_bytes), from = "Windows-1252", to = "UTF-8")
    ## Parse the fixed-width file from the decoded text
    species_list <- readr::read_fwf(
      I(decoded_txt),
      skip = ln_row - 2,
      show_col_types = FALSE
    )
    
    
    # unfortunately, need to manually assign row 1 as header and remove the "line" row
    temp <- lapply(species_list[1, ], as.character)
    species_list <- species_list[-c(1:2),]
    colnames(species_list) <- temp

    
    # # removing french common name due to persistent encoding issues
    # species_list <- species_list |> select(-'French_Common_Name')
    
    species_list$AOU <- as.integer(as.character(species_list$AOU))

    species_list <-species_list |> 
      mutate(Scientific_Name = paste0(Genus," ", Species))
      
    
    ## NOT SURE WHY I WANTED THIS, SO SILENCING FOR NOW
    # ## Join this species list with the package data list -- not sure why i even wnat to store anSL to package
    # species_list <- dplyr::left_join(species_list,
    #                                  bbsAssistant::species_list %>% select(-Seq)#,
    #                                  # by = dplyr::join_by(AOU, English_Common_Name,
    #                                  #              Spanish_Common_Name, ORDER, Family,
    #                                  #              Genus, Species)
    #                                  )

    return(species_list)
}
