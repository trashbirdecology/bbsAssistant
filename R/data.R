
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


