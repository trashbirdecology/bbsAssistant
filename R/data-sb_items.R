
#' Table of USGS ScienceBase Products for the North American Breeding Bird Survey (BBS)
#'
#' A lookup table that is manually updated by the package maintainers.
#'   The table can be used as a reference for identifying BBS data availability on USGS ScienceBase and is called internally when downloading datasets.
#'
#' \itemize{
#'   \item sb_parent. unique identifier associated with a ScienceBase parent item (often the project identifier).
#'   \item sb_item.  ScienceBase unique identifier associated with each dataset release.
#'   \item sb_title.  Title of the item as retrieved from ScienceBase.
#'   \item release_year.  Year of the dataset release.
#'   \item data_type.  One of c("observations", "results"). ScienceBase items are assigned one of the two to distinguish between the analysis results (results) and the original observations dataset release (observations).
#'   \item year_start.  Earliest year of data in the associated dataset.
#'   \item year_end.  Earliest year of data in the associated dataset.
#'   \item legacy_format.  Used to specify whether the observations dataset is in a different format than more recent releases. This is defined by maintainers but based off of ScienceBase documentation.
#'   \item sb_link. URL pointing to the ScienceBase item. Used to download ScienceBase Items using package \code{`sbtools`}
#' }
#' @docType data
#' @keywords datasets
#' @usage data(sb_items)
#' @format A data frame containing 7 rows and 9 columns
#' @examples
#' sb_items
#' @name sb_items
NULL
