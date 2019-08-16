# trend_ests_core_1966to2017 ----------------------------------------------

#' Trend estimates for the core BBS area, 1966-2017
#'
#' More detail TBD
#'
#' @format Describe the format of df:
#' \describe{
#'   \item{Credibility Code}{Color code corresponding to the quality of the data for the species/region combination}
#'   \item{Sample Size}{}
#'   \item{Precision}{}
#'   \item{Abundance}{}
#'   \item{Significance}{}
#'   \item{AOU}{}
#'   \item{Region}{}
#'   \item{Species Name}{}
#'   \item{Region Name}{}
#'   \item{N Routes}{}
#'   \item{Trend}{}
#'   \item{2.5% CI}{}
#'   \item{97.5% CI}{}
#'   \item{Relative Abundance}{}
#' }
#' @source \url{https://www.mbr-pwrc.usgs.gov/bbs/BBS_1966-2017_core_trend_revised_v2.csv}
"trend_ests_core_1966to2017"


# annual_index_expanded_1966to2017 ----------------------------------------
#' Annual population trend indices for species/regions in the exanded BBS region, 1966-2017
#'
#' Description TBD
#'
#' @format Describe the format of df:
#' \describe{
#'   \item{AOU}{}
#'   \item{Region}{}
#'   \item{Year}{}
#'   \item{Index}{}
#'   \item{2.5% CI}{}
#'   \item{97.5% CI}{}
#' }
#' @source \url{https://www.mbr-pwrc.usgs.gov/bbs/inde_1993-2017_expanded.csv}
"annual_index_expanded_1966to2017"


# annual_index_core_1966to2017 ----------------------------------------
#' Annual population trend indices for species/regions in the core BBS region, 1966-2017
#'
#' Description TBD
#'
#' @format Describe the format of df:
#' \describe{
#'   \item{AOU}{}
#'   \item{Region}{}
#'   \item{Year}{}
#'   \item{Index}{}
#'   \item{2.5% CI}{}
#'   \item{97.5% CI}{}
#' }
#' @source \url{https://www.mbr-pwrc.usgs.gov/bbs/inde_1966-2017_core_v2.csv}
"annual_index_core_1966to2017"



# region_codes ----------------------------------------
#' Annual population trend indices for species/regions in the core BBS region, 1966-2017
#'
#' Description TBD
#'
#' @format Describe the format of df:
#' \describe{
#'   \item{CountryNum}{BBS country codes associated with United States (484), Mexico (484), and Canada (840)}
#'   \item{StateNum}{BBS state numbers associated with each 'State' and 'CountryNum'}
#'   \item{State}{The proper name of the (US/MEX) state or (CAN) province}
#'   \item{zip_states}{The filename of the .zip compressed BBS count data located on the FTP server. These files do not exist for Mexican states, so == NA}
#' }
#' @source \url{https://www.mbr-pwrc.usgs.gov/bbs/inde_1966-2017_core_v2.csv}
"annual_index_core_1966to2017"




