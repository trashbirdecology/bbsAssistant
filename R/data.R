# trend_ests_core_1966to2017 ----------------------------------------------

#' Trend estimates for the core BBS area, 1966-2017
#'
#' More detail TBD
#'
#' @format Describe the format of df:
#' \describe{
#'   \item{Credibility Code}{Color code corresponding to the quality of the data for the species/region combination (R=Red, Y=Yellow, B=Blue). Descriptions of the categories can be found [here] (https://www.mbr-pwrc.usgs.gov/bbs/trendmap17/credinfo.html)}
#'   \item{Sample Size}{Color code corresponding to the quality of the data for the species/region combination (R=Red, Y=Yellow, B=Blue). Descriptions of the categories can be found [here] (https://www.mbr-pwrc.usgs.gov/bbs/trendmap17/credinfo.html)}
#'   \item{Precision}{Color code corresponding to the quality of the data for the species/region combination (R=Red, Y=Yellow, B=Blue). Descriptions of the categories can be found [here] (https://www.mbr-pwrc.usgs.gov/bbs/trendmap17/credinfo.html)}
#'   \item{Abundance}{Color code corresponding to the quality of the data for the species/region combination (R=Red, Y=Yellow, B=Blue). Descriptions of the categories can be found [here] (https://www.mbr-pwrc.usgs.gov/bbs/trendmap17/credinfo.html)}
#'   \item{Significance}{Color code corresponding to the quality of the data for the species/region combination (R=Red, Y=Yellow, B=Blue). Descriptions of the categories can be found [here] (https://www.mbr-pwrc.usgs.gov/bbs/trendmap17/credinfo.html)}
#'   \item{AOU}{Five-digit species identification number according to the bird species checklist of the American Ornithologist Union (AOU)}
#'   \item{Region}{Regions are states, Provinces, Bird Conservation Regions (BCR), BBS Regions, Canada (excluding NF and YK), US (lower 48 states), and Survey-wide (excluding data from Alaska and NF)}
#'   \item{Species Name}{Common name accoridng to the bird species checklist of the American Ornithologist Union (AOU)}
#'   \item{Region Name}{Full name of the region in North American according to its region code}
#'   \item{N Routes}{Three-digit-code that identifies the route; unique within states}
#'   \item{Trend}{Ratio of annual indices for the first and last year of the interval of interest}
#'   \item{2.5% CI}{Lower 95% confidence interval (2.5%) of the posterior distribution of the trend esitmate}
#'   \item{97.5% CI}{Upper 95% confidence interval (97.5%) of the posterior distribution of the trend estimate}
#'   \item{Relative Abundance}{Estimated relative abundance of species/region}
#' }
#' @source \url{https://www.mbr-pwrc.usgs.gov/bbs/BBS_1966-2017_core_trend_revised_v2.csv}
"trend_ests_core_1966to2017"


# annual_index_expanded_1966to2017 ----------------------------------------
#' Annual population trend indices for species/regions in the expanded BBS region, 1966-2017
#'
#' Description TBD
#'
#' @format Describe the format of df:
#' \describe{
#'   \item{AOU}{Five digit species identification number according to the bird species checklist of the American Ornithologist Union (AOU)}
#'   \item{Region}{Regions are states, Provinces, Bird Conservation Regions (BCR), BBS Regions, Canada (excluding NF and YK), US (lower 48 states), and Survey-wide (excluding data from Alaska and NF)}
#'   \item{Year}{Four digit year of survey, from 1966-2017}
#'   \item{Index}{Annual index of species/region abundance estimated using a hierarchical model}
#'   \item{2.5% CI}{Lower 95% confidence interval (2.5%) of the annual index of abundance}
#'   \item{97.5% CI}{Upper 95% confidence interval (97.5%) of the annual index of abundance}
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
#'   \item{AOU}{Five digit species identification number according to the bird species checklist of the American Ornithologist Union (AOU)}
#'   \item{Region}{Regions are states, Provinces, Bird Conservation Regions (BCR), BBS Regions, Canada (excluding NF and YK), US (lower 48 states), and Survey-wide (excluding data from Alaska and NF)}
#'   \item{Year}{Four digit year of survey, from 1966-2017}
#'   \item{Index}{Annual index of species/region abundance estimated using a hierarchical model}
#'   \item{2.5% CI}{Lower 95% confidence interval (2.5%) of the annual index of abundance}
#'   \item{97.5% CI}{Upper 95% confidence interval (97.5%) of the annual index of abundance}
#' }
#' @source \url{https://www.mbr-pwrc.usgs.gov/bbs/inde_1966-2017_core_v2.csv}
"annual_index_core_1966to2017"



# region_codes ----------------------------------------
#' Contains country and state numbers, and the associated zip filenames.#' 
#'
#' 
#'
#' @format Describe the format of df:
#' \describe{
#'   \item{CountryNum}{BBS country codes associated with United States (484), Mexico (484), and Canada (840)}
#'   \item{StateNum}{BBS state numbers associated with each 'State' and 'CountryNum'}
#'   \item{State}{The proper name of the (US/MEX) state or (CAN) province}
#'   \item{zip_states}{The filename of the .zip compressed BBS count data located on the FTP server. These files do not exist for Mexican states, so == NA}
#' }
#' @source \url{ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/RegionCodes.txt}
"region_codes"




