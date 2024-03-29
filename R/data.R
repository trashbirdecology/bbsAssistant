# bbs_obs  (most recent version of bbs observations) --------------------------------------------------------------
#' Contains the most recent release of the BBS observations dataset.
#' @format A data frame with 6797797 rows and 14 columns (as of 2020-09-09).
#' \describe{
#'   \item{AOU}{Numeric AOU code.}
#'   \item{Count10}{...}
#'   \item{Count20}{...}
#'   \item{Count30}{...}
#'   \item{Count40}{...}
#'   \item{Count50}{...}
#'   \item{CountryNum}{BBS country codes associated with United States-840, Mexico-484, and Canada-124}
#'   \item{Route}{...}
#'   \item{RouteDataID}{...}
#'   \item{RPID}{Route run type}
#'   \item{SpeciesTotal}{...}
#'   \item{State}{The proper name of the US or Mexican state or Canadian province}
#'   \item{StateNum}{BBS state numbers associated with each 'State' and 'CountryNum'}
#'   \item{StopTotal}{Number of individuals of a given species ('AOU') identified by the observer at the end of every 10 stop within the route.}
#'   \item{Year}{Year in which the BBS observations was taken.}
#' }
#' @source \url{https://www.sciencebase.gov/catalog/item/52b1dfa8e4b0d9b325230cd9}
"bbs_obs"

# sb_items ------------------------------------------------------------
#' A lookup table that is manually updated by the package maintainers. It is used as a quick reference to identify which datasets are available for import from ScienceBase, and are compatible with this package.
#' @format A data frame containing N rows and 5 columns
#' \describe{
#'   \item{sb_parent}{ScienceBase unique identifier associated with the parent item (often the project identifier).}
#'   \item{sb_item}{ScienceBase unique identifier associated with each dataset release.}
#'   \item{sb_title}{Title of the item as retrieved from ScienceBase.}
#'   \item{release_year}{Year of the dataset release.}
#'   \item{data_type}{One of c("observations", "results"). ScienceBase items are assigned one of the two to distinguish between the analysis results (results) and the original observations dataset release (observations).}
#'   \item{year_start}{Earliest year of data in the associated dataset.}
#'   \item{year_end}{Earliest year of data in the associated dataset.}
#'   \item{legacy_format}{Used to specify whether the observations dataset is in a different format than more recent releases. This is defined by maintainers but based off of ScienceBase documentation.}
#' }
"sb_items"

# region_codes ------------------------------------------------------------
#' Country and state codes and associated zip filenames
#' @format A data frame:
#' \describe{
#'   \item{CountryNum}{Integer. BBS country codes associated with United States-840, Mexico-484, and Canada-124}
#'   \item{StateNum}{Integer. BBS state numbers associated with each 'StateNum' and 'CountryNum'}
#'   \item{State}{Character. The proper name of the US or Mexican state or Canadian province.}
#'   \item{zip_states}{Character. The filename of the .zip compressed BBS count data located on the FTP server. These files do not exist for Mexican states, so == NA}
#' }
#' @source \url{https://www.sciencebase.gov/catalog/item/52b1dfa8e4b0d9b325230cd9}
"region_codes"

# species_list (currently just aou data from url) --------------------------------------------------------------
#' Taxonomic information from the American Ornithological Society's AOU code.
#' @format A data frame with 2158 rows and 17 variables.
#' \describe{
#'   \item{AOU}{Numeric AOU code.}
#'   \item{avibase.id}{Identifier for Avibase database. Source \url{http://avibase.bsc-eoc.org/}}
#'   \item{rank}{...}
#'   \item{common_name}{English common name.}
#'   \item{order}{Phylogenetic order.}
#'   \item{family}{Phylogenetic family}
#'   \item{subfamily}{Phylogenetic sub-family}
#'   \item{genus}{Phylogenetic genera}
#'   \item{species}{Phylogenetic species epithet}
#'   \item{status_accidental}{...}
#'   \item{status_hawaiin}{}
#'   \item{status_introduced}{...}
#'   \item{status_misplaced}{...}
#'   \item{status_extinct}{...}
#'   \item{status_nonbreeding}{...}
#' }
#' @source Most recent version of species list associated with BBS data at SpeciesList.txt at \url{http://checklist.aou.org/taxa.csv?type=charset%3Dutf-8%3Bsubspecies%3Dno%3B"}
"species_list"


# sauer_results  (the most recent version of bbs analytical results released by Dr. John Sauer on Sciencebase) --------------------------------------------------------------
#' Contains the most recent release of the BBS observations dataset.
#' The data object is a list, wherein the list names (names(sauer_results)) correspond with the .csv filenames provided in ScienceBase; call `bbsAssistant::sb_items` for more information.
#' @format A list containing a varying number of data frames associated with the most recent release of analysis results by Sauer et al. Please visit the `source` for more information, including metadata which describes each results file.
#'  \describe{
#'  NOTE: Please see the respective ScienceBase item for greater detail of variables (data frame columns; see "sb_items" hyperlink for relevant sb_id)
#'  NOTE: Not all columns are described here, only those associated with the 2020 release.
#'  @details The object, sauer_results, comprises (currently) 4 data frames, each containing the results of different analyses as described in original metadata.
#'  \itemize{ # the list of objects available for sauer_results
#'  \item{@param BBS_1966-2018_core_best_trend}{...}
#'  \item{@param BBS_1993-2018_expanded_trend_best}{...}
#'  \item{@param inde_best_1993-2018_expanded}{...}
#'  \item{@param inde_best_1966-2018_core}{...}
#'  }
#' 
#' @source \url{https://www.sciencebase.gov/catalog/item/5ea1e02c82cefae35a16ebc4}
#' 
"sauer_results"
