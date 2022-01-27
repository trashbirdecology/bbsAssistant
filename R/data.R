# region_codes ------------------------------------------------------------
#' Country and State Codes
#'
#' See \url{https://www.sciencebase.gov/catalog/item/52b1dfa8e4b0d9b325230cd9}
#' \describe{
#'   \item{CountryNum}{alpha-country codes used by the BBS. (840=United States of America; 484=Mexico; 124=Canada)}
#'   \item{StateNum}{state numbers associated with each State and CountryNum, assigned by the BBS}
#'   \item{State}{proper name of the state or province as provided by BBS office}
#'   \item{ISO_a2}{ISO 2-character code for Country}
#'   \item{ISO_3166-2}{ISO character code for Country and State/Territory/Province}
#'   \item{State}{English name associated with ISO_3166-2. Names appearing in the BBS region codes list with accented characters were munged by development team slightly.}
#'   \item{name_fr}{French name associated with ISO_3166-2. Names appearing in the BBS region codes list with accented characters were munged by development team slightly.}
#'   \item{name_es}{Spanish (Espanol) name associated with ISO_3166-2. Names appearing in the BBS region codes list with accented characters were munged by development team slightly.}
#' }
#'
"region_codes"

# species_list ------------------------------------------------------------
#' Species List Associated with Most Recent BBS Dataset Release
#'
#' A species list is provided by the BBS office in ScienceBase data releases.See the ScienceBase catalog for metadata regarding taxonomic classifications.
#' @format A \code{data.frame} with 756 rows and 9 variables
#' \describe{
#'   \item{Seq}{row identifier used by BBS}
#'   \item{AOU}{species-level numeric code used by BBS}
#'   \item{English_Common_Name}{Common name in English}
#'   \item{French_Common_Name}{Common name in French}
#'   \item{Spanish_Common_Name}{Common name in Spanish}
#'   \item{ORDER}{taxonomic order}
#'   \item{Family}{taxonomic family}
#'   \item{Genus}{taxonomic genus}
#'   \item{Species}{taxonomic species epithet}
#' @source \url{https://www.sciencebase.gov/catalog/item/52b1dfa8e4b0d9b325230cd9}
#' @rdname species_list
"species_list"


# SB ITEMS ----------------------------------------------------------------
#' Table of USGS ScienceBase Products for the North American Breeding Bird Survey (BBS)
#'
#' A lookup table that is manually updated by the package maintainers.
#'   The table can be used as a reference for identifying BBS data availability on USGS ScienceBase and is called internally when downloading datasets.
#' @format A data frame containing 7 rows and 9 columns
#' \describe{
#'   \item{sb_parent}{unique identifier associated with a ScienceBase parent item (often the project identifier).}
#'   \item{sb_item}{ScienceBase unique identifier associated with each dataset release.}
#'   \item{sb_title}{Title of the item as retrieved from ScienceBase.}
#'   \item{release_year}{Year of the dataset release.}
#'   \item{data_type}{One of c("observations", "results"). ScienceBase items are assigned one of the two to distinguish between the analysis results (results) and the original observations dataset release (observations).}
#'   \item{year_start}{Earliest year of data in the associated dataset.}
#'   \item{year_end}{Earliest year of data in the associated dataset.}
#'   \item{legacy_format}{Used to specify whether the observations dataset is in a different format than more recent releases. This is defined by maintainers but based off of ScienceBase documentation.}
#'   \item{sb_link}{URL pointing to the ScienceBase item. Used to download ScienceBase Items using package sbtools}
#' }
#'
"sb_items"

