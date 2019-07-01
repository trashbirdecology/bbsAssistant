# GetUnzip #########################################################
#' @title Downloads and unzips a zip archive
#' @param ZipName file to download
#' @param FileName file to unzip to
#' @details Used internally. If ZipName begins with 'http' or 'ftp', then download and unzip to
#'   Filename and return as a dataframe. Otherwise, unzip Zipname and return as a data.frame.
#' @return A dataframe
#' @export GetUnzip
#'
GetUnzip <- function(ZipName, FileName) {
    if (grepl('^[hf]t+p', ZipName)) {
        temp <- tempfile()
        download.file(ZipName, temp, quiet = FALSE)
        data <- read.csv(unz(temp, FileName))
        unlink(temp)
    } else {
        data <- read.csv(unz(ZipName, FileName))
    }
    data
}