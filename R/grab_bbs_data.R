#' @title Downloads and Imports the BBS Observations and Associated Metadata
#' @description
#' This function will download, unpack, and import the BBS dataset and associated metadata for a single dataset release. Defaults to the most recent version of the BBS dataset.
#' Wrapper for internal functions download_bbs_data(), unpack_bbs_data(), and import_bbs_data().
#' @param sb_id ScienceBase item number/identifier, used in sbtools.
#' @param sb_dir The location where the BBS data will be stored. If not specified, will create a directory within the working directory called "data-raw."
#' @param overwrite Logical. Defaults to FALSE. FALSE will not download files if they exist in the specified directory.
#' @export grab_bbs_data

## NEED TO ADD A NEST FEATURE--list or data frame, where data frame is a collapsed version of the list, with the citation removed
grab_bbs_data <- function(sb_id=NULL, sb_dir=NULL, overwrite=FALSE){

if(is.null(sb_id)){
    message("`sb_id` not specified. Downloading the most recent version of the BBS dataset.")
    # data("sb_items", package="bbsAssistant")
    sb_id=sb_items[which.max(sb_items$release_year),]$sb_item
  }

   if(is.null(sb_dir)){
    dir.create("data-in", showWarnings = FALSE)
    sb_dir=paste0("data-in/", sb_id)
    dir.create(sb_dir, showWarnings = FALSE)
  }

## DOWNLOAD THE DATA FROM SOURCE
temp.dir <- download_bbs_data(sb_id=sb_id, sb_dir=sb_dir, overwrite = overwrite)

## IMPORT
bbs <- import_bbs_data(sb_dir = temp.dir, sb_id=sb_id)

return(bbs)

}




