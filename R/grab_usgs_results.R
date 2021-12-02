#' Download and Import the Most Recent USGS BBS Analytical Results
#'
#' Downloads and imports the analytical results published on ScienceBase.
#' Refers to internal dataset \code{sb_items} to capture the most recent ScienceBase identifier, sb_id,
#'
#' @usage
#' grab_usgs_results()
#' @export grab_usgs_results

grab_usgs_results <- function(){
  # munge the sb_items object to obtain the most recent version of the results.
  sb_items <-
    sb_items %>%
    dplyr::filter(data_type %in% c("sauer_results") &
                    release_year == max(release_year))

  sb_id <- sb_items$sb_item


  # Download the data to temp dir Create subdirectory for the sb_id files  -----------------------------------------------------------------
  mydir <- tempdir()
  sbtools::item_file_download(sb_id = sb_id,
                              dest_dir = mydir,
                              overwrite_file = TRUE)

  # Import ------------------------------------------------------------------
  fns <- list.files(mydir, pattern = "trend|inde", full.names = TRUE)
  list.files(sb_dir)
  # Bring them in --------------------------------------------------------
  ## This needs to be improved, but fine for now.
  usgs_results <- list()
  for (i in seq_along(fns)) {
    if (grep(".csv", fns[i], value = FALSE)) {
      temp <- readr::read_csv(fns[i])
    } else{
      print('break')
      next
    }
    usgs_results[[i]] <- temp
    if (exists("temp"))
      rm(temp)
    names(usgs_results)[i] <-
      gsub(".*/(.+).csv*", "\\1", fns[i])
    ## for some reason roxygen translation is **Removing the list names**
    ## therefore^, I have annoying added a variable to determine the
  }

  return(usgs_results)
}
