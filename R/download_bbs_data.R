#' @title Download the BBS dataset files associated with a single ScienceBase identifier.
#' @description This is functionally sbtools::item_file_download, but forces the overwrite_file=TRUE condition, and specifies the directory to store item files.
#' @param sb_id Alphanumeric character. Equals the USGS Science Base identifier for a BBS dataset release.
#' @param sb_dir Directory for storing the downloaded files for sb_id
#' @param overwrite Logical, default=TRUE. TRUE will overwrite existing files for sb_id if already exists within sb_dir
#' @keywords Internal

download_bbs_data <-
    function(sb_id = NULL,
             sb_dir = NULL,
             overwrite = FALSE) {
        # browser()
        if (is.null(sb_id)) {
            message("sb_id not specified. Downloading the most recent version of the BBS dataset.")
            # data(sb_items)#, package="bbsAssistant")
            sb_id = sb_items[which.max(sb_items$release_year), ]$sb_item
        }


        if (is.null(sb_dir)) {
            dir.create("data-in", showWarnings = FALSE)
            sb_dir = paste0("data-in/", sb_id)
            dir.create(sb_dir, showWarnings = FALSE)
        }


        # Download all files associated with the ScienceBase item (sb_id)
        ## sbtools does this inside item_file_download, but it throws an error stopping all other functions.
        ind = c("50-StopData.zip") %in% list.files(sb_dir)
        if ((ind &
             overwrite) | !ind) {
            sbtools::item_file_download(
                sb_id = sb_id,
                dest_dir = sb_dir,
                overwrite_file = TRUE
            )
        } else
            ("The 50-StopData already exists in sb_dir and overwrite==FALSE. Not overwriting existing files.")


        return(sb_dir)
    }
