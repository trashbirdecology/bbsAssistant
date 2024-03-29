#' @title Import the BBS Data from a Specified Directory
#'
#' @description Import the BBS observations and metadata into environment.
#' Called inside \code{grab_bbs_data()}. Can be called directly but user must have sb_id and bbs_dir specified.
#' @param sb_id ScienceBase Item identifier. Can be found in \code{sb_items}
#' @param bbs_dir Location of where the ScienceBase item files are located.
#' @importFrom utils unzip
#' @importFrom readr cols col_integer col_character read_csv
#' @importFrom dplyr group_by mutate ungroup
#' @export import_bbs_data
import_bbs_data <- function(bbs_dir, sb_id) {

ObsN <- RTENO <- Date <- TotalSpp  <- NULL # bind variable to avoid CMD CHK WARNING

    # Where to save the unzipped files
    tempdir = tempdir()

    # Create a vector of desired file locations.
    zipF <-
        list.files(path = paste0(bbs_dir),
                   pattern = "50-StopData.zip",
                   full.names = TRUE)
    utils::unzip(zipF, exdir = tempdir) # unzip the top directory b/c not sure its possible to dig two dirs down into a zipped file..
    fns.50stop <-
        paste0(tempdir,
               "/",
               unzip(
                   zipfile = zipF,
                   list = TRUE,
                   exdir = tempdir()
               )$Name)
    fns.50stop <-
        fns.50stop[stringr::str_detect(tolower(fns.50stop), pattern = ".zip")] # to remove the dir that isnt a .zip

    fns.routes <- list.files(path = paste0(bbs_dir),
                             pattern = "routes.zip",
                             full.names = TRUE)
    fns.vehicle <- list.files(path = paste0(bbs_dir),
                              pattern = "ehicle",
                              full.names = TRUE)
    fns.weather <- list.files(path = paste0(bbs_dir),
                              pattern = "eather.zip",
                              full.names = TRUE)


    # define potential columns and desired types to ensure consistency across data files
    col_types <- readr::cols(
      AOU = readr::col_integer(),
      CountryNum = readr::col_integer(),
      Route = readr::col_character(),
      RouteDataID = readr::col_integer(),
      RPID = readr::col_integer(),
      StateNum = readr::col_integer(),
      Year = readr::col_integer()
    )

    # Get observations and routes ---------------------------------------------
    # observations <- sapply(fns, function(x) readr::read_csv(unzip(zipfile = x))) %>%
    # can't figure out how to do this with apply so just looping... le sigh.

    observations <- list()
    for (i in seq_along(fns.50stop)) {
      f <- fns.50stop[i]
      # observations[[i]]  <- data.table::fread(f)
      observations[[i]]  <- readr::read_csv(f, col_types = col_types)
    }
    observations <- dplyr::bind_rows(observations)

    # Get dataset citation(s) -------------------------------------------------
    citation <- sbtools::item_get_fields(sb_id, "citation")

    # Get species list --------------------------------------------------
    species_list <- import_species_list(bbs_dir)

    # Get route metadata -------------------------------------------------------
    routes <-   suppressWarnings(readr::read_csv(fns.routes, col_types = col_types))
    weather <-   suppressWarnings(readr::read_csv(fns.weather, col_types = col_types))
    vehicle_data <-  suppressWarnings(readr::read_csv(unzip(zipfile = fns.vehicle, exdir = tempdir), col_types = col_types)) # keep this as unzip
    # routes <-   suppressWarnings(readr::read_csv(unzip(zipfile = fns.routes, exdir = tempdir), col_types = col_types))
    # weather <-  suppressWarnings(readr::read_csv(unzip(zipfile = fns.weather, exdir = tempdir), col_types = col_types))


    observers <- weather %>%
      make.dates() %>%
      make.rteno() %>%
      dplyr::select(ObsN, RTENO, Date, TotalSpp) %>%
      ##create binary for if observer's first year on the BBS and on the route
      dplyr::group_by(ObsN) %>% #observation identifier (number)
      dplyr::mutate(ObsFirstYearOnBBS = ifelse(Date==min(Date), 1, 0)) %>%
      dplyr::group_by(ObsN, RTENO) %>%
      dplyr::mutate(ObsFirstYearOnRTENO = ifelse(Date==min(Date), 1, 0)) %>%
      dplyr::ungroup() # to be safe

    # Create a list of data and information to export or return to `get_bbs_data`----------------------------------dfnames <-
    list.elements <-
      list("observations",
           "routes",
           "observers",
           "weather",
           "species_list",
           "citation",
           "vehicle_data"
      )
    bbs <- lapply(
      list.elements,
      FUN = function(x) {
        eval(parse(text = paste(x))) %>%
          make.rteno()
      }
    )
    names(bbs) <- list.elements

    # END FUNCTION ------------------------------------------------------------
    return(bbs)
}
