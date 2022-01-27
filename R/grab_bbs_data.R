#' @title Downloads and Imports the BBS Observations and Associated Metadata
#' @description
#' This function will download, unpack, and import the BBS dataset and associated metadata for a single dataset release. Defaults to the most recent version of the BBS dataset.
#' Wrapper for internal functions download_bbs_data(), unpack_bbs_data(), and import_bbs_data().
#' @param sb_id ScienceBase item number/identifier, used in sbtools.
#' @param bbs_dir The location where the BBS data will be stored. If not specified, will create a directory within the working directory called "data-raw."
#' @param overwrite Logical. Defaults to FALSE. FALSE will not download files if they exist in the specified directory.
#'
#'
#' @export grab_bbs_data
grab_bbs_data <- function(sb_id=NULL, bbs_dir=NULL, overwrite=FALSE){

## NEED TO ADD A NEST FEATURE--list or data frame, where data frame is a collapsed version of the list, with the citation removed
if(is.null(sb_id)){
  sb_items <- bbsAssistant::sb_items
    sb_id=sb_items[which.max(sb_items$release_year),]$sb_item
    message("Argument `sb_id` not specified.\ Using the ScienceBase identifier (sb_id) associated with the ",
            sb_items$release_year[sb_items$sb_item==sb_id],
            " version of the BBS dataset:\n")
  }

   if(is.null(bbs_dir)){
    dir.create("data-in", showWarnings = FALSE)
    bbs_dir=paste0("data-in/", sb_id)
    dir.create(bbs_dir, showWarnings = FALSE)
  }else(stopifnot(dir.exists(bbs_dir)))

## DOWNLOAD THE DATA FROM SOURCE (or not if exists and overwrite=FALSE)
data.in.dir <- bbsAssistant::download_bbs_data(sb_id=sb_id, bbs_dir=bbs_dir, overwrite = overwrite)

## IMPORT
bbs <- import_bbs_data(bbs_dir = data.in.dir, sb_id=sb_id)

return(bbs)

}




