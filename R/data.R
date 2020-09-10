

# sb_items ------------------------------------------------------------
#' A lookup table that is manually updated by the package maintainers. It is used as a quick reference to identify which datasets are available for import from ScienceBase, and are compatible with this package.  
#' @format A data frame:
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

# bbs_obs  (most recent version of bbs observations) --------------------------------------------------------------
#' Contains the most recent release of the BBS observations dataset. 
#' @format A data frame with 6797797 rows and 14 columns (as of 2020-09-09).
#' \describe{
#'   \item{RouteDataID}{}
#'   \item{CountryNum}{BBS country codes associated with United States-840, Mexico-484, and Canada-124}
#'   \item{StateNum}{BBS state numbers associated with each 'State' and 'CountryNum'}
#'   \item{State}{The proper name of the US or Mexican state or Canadian province}
#'   \item{RPID}{Route run type}
#'   \item{Year}{Year in which the BBS observations was taken.}
#'   \item{AOU}{Numeric AOU code.}-0 
#'   \item{StopTotal}{}
#'   \item{Count10}{}
#'   \item{Count20}{}
#'   \item{Count30}{}
#'   \item{Count40}{}
#'   \item{Count50}{}
#' }
#' @source \url{https://www.sciencebase.gov/catalog/item/52b1dfa8e4b0d9b325230cd9}
"bbs_obs"


