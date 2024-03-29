% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datasets.R
\docType{data}
\name{species_list}
\alias{species_list}
\title{Species List Lookup Table}
\format{
An object of class \code{tbl_df} (inherits from \code{tbl}, \code{data.frame}) with 2385 rows and 11 columns.
}
\usage{
species_list
}
\description{
Species List Associated with Most Recent BBS Dataset Release
}
\details{
\describe{
\item{Seq}{row identifier used by BBS}
\item{AOU}{species-level numeric code used by BBS}
\item{English_Common_Name}{Common name in English}
\item{French_Common_Name}{Common name in French}
\item{Spanish_Common_Name}{Common name in Spanish}
\item{ORDER}{taxonomic order}
\item{Family}{taxonomic family}
\item{Genus}{taxonomic genus}
\item{Species}{taxonomic species epithet}
\item{Scientific_Name}{comprised of the Genus and Species as provided in BBS dataset}
\item{AOU4}{4-letter alpha code from IBP AOU data (Seq4) \url{https://www.birdpop.org/pages/birdSpeciesCodes.php}. This should be double-checked when using for analytical purposes. }
\item{AOU6}{4-letter alpha code from IBP AOU data (Seq6)\url{https://www.birdpop.org/pages/birdSpeciesCodes.php}. This should be double-checked when using for analytical purposes. }
}
}
\keyword{datasets}
