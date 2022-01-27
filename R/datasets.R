#' Region Codes Lookup Table
#'
#' Country and state codes used by BBS combined with ISO-3166-2 and ISO-a2
#'
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
#' @source <https://www.sciencebase.gov/catalog/item/52b1dfa8e4b0d9b325230cd9>
"region_codes"


#' ScienceBase Items Lookup Table
#'
#' A lookup table that is manually updated by the package maintainers.
#'   The table can be used as a reference for identifying BBS data availability on USGS ScienceBase and is called internally when downloading datasets.
#'
#' \describe{
#'   \item{sb_parent}{unique identifier associated with a ScienceBase parent item (often the project identifier).}
#'   \item{sb_item}{ScienceBase unique identifier associated with each dataset release.}
#'   \item{sb_title}{Title of the item as retrieved from ScienceBase.}
#'   \item{release_year}{Year of the dataset release.}
#'   \item{data_type}{One of c("observations", "results"). ScienceBase items are assigned one of the two to distinguish between the analysis results (results) and the original observations dataset release (observations).}
#'   \item{year_start}{Earliest year of data in the associated dataset.}
#'   \item{year_end}{Earliest year of data in the associated dataset.}
#'   \item{legacy_format}{Used to specify whether the observations dataset is in a different format than more recent releases. This is defined by maintainers but based off of ScienceBase documentation.}
#'   \item{sb_link}{a URL pointing to the ScienceBase item. Used to download ScienceBase Items using package sbtools}
#' }
#'
"sb_items"


#' Species List Lookup Table
#'
#' Species List Associated with Most Recent BBS Dataset Release
#'
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
#'   \item{Scientific_Name}{comprised of the Genus and Species as provided in BBS dataset}
#'   \item{AOU4}{4-letter alpha code from IBP AOU data (Seq4) <https://www.birdpop.org/pages/birdSpeciesCodes.php>. Ths should be double-checked when using for analytical purposes. }
#'   \item{AOU6}{4-letter alpha code from IBP AOU data (Seq6)<https://www.birdpop.org/pages/birdSpeciesCodes.php>. Ths should be double-checked when using for analytical purposes. }
#'   }
#'
"species_list"
