#' @title Downloads and unzips a zip archive to file. 
#' @description This function downloads the BBS data from the USGS FTP server to a temporary file, decompresses the .zip files, and imports the uncompressed .csv file into R. This function was adapted from the function [rBBS::GetUnzip()](https://github.com/oharar/rBBS/blob/master/R/GetUnzip.R).
#' @param ZipName file to download
#' @param FileName file to unzip to
#' @details Used internally. If ZipName begins with 'http' or 'ftp', then download and unzip to
#'   Filename and return as a dataframe. Otherwise, unzip Zipname and return as a data.frame.
#' @return A dataframe
#' @export get_unzip

get_unzip <- function(ZipName, FileName) {
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
