
#' BBS Results Released by the USGS
#'#'
#' The data object is a list, wherein the list names (names(usgs_results)) correspond with the .csv filenames provided in ScienceBase; call `bbsAssistant::sb_items` for more information.
#'  NOTE: Please see the respective ScienceBase item for greater detail of variables (data frame columns; see "sb_items" hyperlink for relevant sb_id)
#' @format A list containing a varying number of data frames associated with the most recent release of analysis results by Sauer et al. Please visit the `source` for more information, including metadata which describes each results file.
#' @description
#' @details The object, usgs_results, comprises (currently) 4 data frames, each containing the results of different analyses as described in original metadata.
#'  \itemize{
#'  \item BBS_1966-2018_core_best_trend. trends for 1966-2018, BBS core area. See ScienceBase metadata for information.
#'  \item BBS_1993-2018_expanded_trend_best. trends for 1993-2018. See ScienceBase metadata for information.
#'  \item inde_best_1993-2018_expanded. trends for 1993-2018. See ScienceBase metadata for information.
#'  \item nde_best_1966-2018_core. trends for 1966-2018. See ScienceBase metadata for information.
#'  }
#'
#' @docType data
#' @keywords datasets
#' @usage data(usgs_results)
#' @format A list containing 4 data frames
#' @source \url{https://www.sciencebase.gov/catalog/item/5ea1e02c82cefae35a16ebc4}
#' @name usgs_results
#'
NULL
