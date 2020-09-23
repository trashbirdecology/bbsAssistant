#' @title Download the BBS dataset files associated with a single ScienceBase identifier
#' @description Called inside `get_bbs_data()`. This is functionally sbtools::item_file_download, but forces the overwrite_file=TRUE condition, and specifies the directory to store item files.
#' @param sb_id Temp description
#' @param sb_dir Temp description
#' @export download_bbs_data

download_bbs_data <- function(sb_id, sb_dir){

# Download all files associated with the ScienceBase item (sb_id) 
    sbtools::item_file_download(sb_id = sb_id,
                                dest_dir = sb_dir,
                                overwrite_file = TRUE)
    
}
