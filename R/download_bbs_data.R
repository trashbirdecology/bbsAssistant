#' @title 
#' @description Called inside `get_bbs_data()`.
#' @param sb_id
#' @param sb_dir

download_bbs_data <- function(sb_id, sb_dir){

# Download all files associated with the ScienceBase item (sb_id) ------------------------------------------

item.files<-sbtools::item_file_download(sb_id = sb_id,
                                dest_dir = sb_dir, 
                            overwrite_file = TRUE)   

    
    
# END FUNCTION ------------------------------------------------------------
return(item.files)
}
