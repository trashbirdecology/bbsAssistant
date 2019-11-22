#' #' @title Download and import metadata
#' #' @description Downloads and imports metadata file. Primarily used to update the citation to the BBS database.
#' #' @param meta.url URL for metadata file, retrieved via FTP.
#' #' @param citation.to.bib For internal use. Logical. Default = TRUE. Updates the xml citation used
#' 
#' get_citation <- function(
#'     meta.url = "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/MetaData-NABBS_Dataset_1966-2018_v2018_0.xml", 
#'     citation.to.bib=TRUE
#'     ) {
#'     require(XML)
#'     data <- xmlParse(meta.url)
#'     
#'     xml_data <- xmlToList(data)
#'     
#'     xml2::write_xml(x=xml_data, file=)
#'     citation <- xml_data[["idinfo"]][["citation"]]#[["citeinfo"]][["title"]]
#'     
#'     print(xml_data[["idinfo"]][["citation"]])
#'     # Load the packages required to read XML files.
#'     library("XML")
#'     library("methods")
#'     
#'     # Convert the input xml file to a data frame.
#'     xmldataframe <- xmlToDataFrame("ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/MetaData-NABBS_Dataset_1966-2018_v2018_0.xml")
#'     print(xmldataframe[["citation"]][1])
#' }
