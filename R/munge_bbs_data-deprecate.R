#' #' @title Subset BBS Data by One or More Parameters
#' #' @description This function subsets the BBS observations using taxonomic, geospatial, or temporal features.
#' #' @param year.range value(s) of year(s) by which to subset the data. If not specified will return all data in the dataset.
#' #' @param bbs_list A list with element "species_list", obtained from running bbsAssistant::get_bbs_data()...
#' #' @param species A vector of one or more species (using English Common Name) to subset the data by. Capitalization ignored.
#' #' @param genera vector of one or more genera  to retain in data
#' #' @param states vector of one or more states/territories/sub-national political regions (see data(region_codes))
#' #' @param countries vector of one or more nations/countries (see data(region_codes))
#' #' @param order  vector of one or more orders to retain in data
#' #' @param family vector of one or more families to retain in data
#' #' @param rpid mostly for internal use. See BBS metadata documentation for more details.
#' #' @param QualityCurrentID an index used to indicate the quality of the BBS data. See BBS metadata at USGS ScienceBase for more information. Suggest keeping this value at 1 unless you know what you're doing
#' #' @param zero.fill If TRUE and a single species is provided in 'species', this function will output list$observations with zero-filled data.
#' #' @param active.only Logical. If TRUE keep only active routes. Discontinued routes will be discarded.
#' #' @param observations.output return the object as a list of data frames ("list") or a single data frame ("flat" or "df" or "data.frame")
#' #' @param keep.stop.level.data logical TRUE will keep the stop-level data and metadata. FALSE will remove these and provide only mean values or sums.
#' #' @importFrom dplyr mutate filter across group_by ungroup all_of distinct left_join full_join select
#' #' @export munge_bbs_data
#' munge_bbs_data <-
#'   function(bbs_list,
#'            states = NULL,
#'            countries = NULL,
#'            species = NULL,
#'            genera = NULL,
#'            order = NULL,
#'            family = NULL,
#'            zero.fill = TRUE,
#'            rpid = 101,
#'            year.range = 1966:lubridate::year(Sys.Date()),
#'            keep.stop.level.data = FALSE,
#'            QualityCurrentID = 1,
#'            active.only = FALSE,
#'            observations.output = "flat") {
#'     # ARG CHECKS --------------------------------------------------------------
#'     stopifnot(
#'       tolower(observations.output) %in% c("flat", "df", "data.table", "data.frame", "list")
#'     )
#'     stopifnot(
#'       rpid %in% c(101 ,501, 103, 102, 203)
#'     )
#'     ## add binded variables to avoid RCMD CHECK WHINING
#'     State <-
#'       StateNum <-
#'       Date <-
#'       RouteTotal <-
#'       ObsN <-
#'       Active <-
#'       AOU <-
#'       RTENO <-
#'       Year <-
#'       iso_3166_2 <-
#'       iso_a2 <- ObsFirstYearOnRTENO <- ObsFirstYearOnBBS  <- NULL
#'
#'     # SUBSET BY SPATIAL INDEXES ---------------------------------------------------
#'     # grab region codes
#'     region_codes <- bbsAssistant::region_codes
#'     # by country
#'     if (!is.null(countries)) {
#'       region_codes <-
#'         region_codes %>% dplyr::filter(tolower(iso_a2) %in% tolower(countries))
#'     }
#'     # by state/terr/prov
#'     if (!is.null(states)) {
#'       states <- tolower(gsub("-", "", states)) # munge the states a little
#'       all.region.codes <- c(
#'         tolower(region_codes$iso_3166_2),
#'         gsub("-", "", tolower(region_codes$iso_3166_2)),
#'         tolower(region_codes$State),
#'         region_codes$StateNum
#'       )
#'       # overlap  <- states[which(states %in% all.region.codes)]
#'       overlap <-
#'         all.region.codes[which(all.region.codes %in% states)]
#'
#'       if (length(overlap) >= 1) {
#'         region_codes <-
#'           region_codes %>%
#'           dplyr::filter(
#'             gsub("-", "", tolower(StateNum)) %in% overlap |
#'               gsub("-", "", tolower(State)) %in% overlap |
#'               gsub("-", "", tolower(iso_3166_2))  %in% overlap
#'           )
#'
#'       } else{
#'         message("states specified in arg `states` were not found. returning all states.")
#'       }
#'     } # end states subsetting
#'
#'     # filter the input observations data by all region_codes
#'     bbs_list$observations <-
#'       bbs_list$observations[bbs_list$observations$CountryNum %in% region_codes$CountryNum,]
#'     bbs_list$observations <-
#'       bbs_list$observations[bbs_list$observations$StateNum %in% region_codes$StateNum,]
#'     stopifnot(nrow(bbs_list$observations) >= 1)
#'
#'     ## TEMPORAL SUBSETTING -----------------------------------------------------
#'     bbs_list$observations <-
#'       bbs_list$observations %>% dplyr::filter(Year %in% year.range)
#'     stopifnot(nrow(bbs_list$observations) >= 2)
#'
#'     # GRAB A LIST OF ALL SAMPLED ROUTES -------------------------------------------------------------------------
#'     ## before further subsetting, we want to grab an index of which routes were sampled each year (after we subset by year and spatial extent/loc)
#'     all.samples <-  bbs_list$observations %>%
#'       dplyr::distinct(Year, RTENO, .keep_all = TRUE)
#'     stopifnot(all(all.samples$RTENO %in% bbs_list$routes$RTENO))
#'     stopifnot(nrow(all.samples) >= 1)
#'
#'     # TAXONOMIC SUBSETTING ----------------------------------------------------
#'     ## grab relevant taxonomic names and codes for subsetting BBS by species
#'     if (is.null(species)) {
#'       species <- unique(bbs_list$observations$AOU)
#'       aous.keep <- unique(species)
#'     } else{
#'       species <- tolower(species)
#'       sl      <- bbs_list$species_list
#'       inds = tolower(c(species, genera, family, order))
#'       cols = tolower(
#'         c(
#'           "English_Common_Name",
#'           "Scientific_Name",
#'           "Family",
#'           "Genus",
#'           "ORDER",
#'           "Species",
#'           "AOU",
#'           "AOU4",
#'           "AOU6"
#'         )
#'       )
#'       aous.keep <- NULL
#'       ##i know there's a way to clean up with filter_Across or at or something but w/ev for now...
#'       for (i in seq_along(cols)) {
#'         col.ind <- which(tolower(names(sl)) == cols[i])
#'         row.ind <- which(tolower(sl[[col.ind]]) %in% inds)
#'         aous.keep <- c(sl$AOU[row.ind], aous.keep)
#'       }
#'       stopifnot(!is.null(aous.keep))
#'       ## now remove the unwanted species from observations
#'       bbs_list$observations <-
#'         bbs_list$observations %>% dplyr::filter(AOU %in% aous.keep)
#'     } # end species subsetting
#'
#'     # BBS PROTOCOL SUBSETTING -----------------------------------------------------
#'     bbs_list$weather <-
#'       bbs_list$weather %>% dplyr::filter(QualityCurrentID %in% QualityCurrentID &
#'                                            RPID %in% rpid)
#'     bbs_list$vehicle_data <- bbs_list$vehicle_data %>% dplyr::filter(RPID %in% rpid)
#'
#'     if (active.only)
#'       bbs_list$routes  <-
#'       bbs_list$routes %>% dplyr::filter(Active == 1)
#'
#'     # CREATE ROUTE-LEVEL MEANS AND SUMS ACROSS STOP-LEVEL DATA ----------------------------------
#'     cols.stop <- c(paste0("Stop", c(1:50))) # stop-level counts
#'     cols.wind <- c(paste0("Wind", c(1:50)))
#'     cols.noise <-
#'       c(paste0("Noise", c(1:50))) # stop-level noise covar
#'     cols.car <- c(paste0("Car", c(1:50))) # stop-level car covar
#'     bbs_list$observations <-
#'       bbs_list$observations %>%
#'       dplyr::mutate(RouteTotal = rowSums(dplyr::across(dplyr::all_of(cols.stop))))
#'     bbs_list$vehicle_data <- bbs_list$vehicle_data %>%
#'       dplyr::mutate(CarMean = round(rowSums(dplyr::across(
#'         dplyr::all_of(cols.car)
#'       )) / 50)) # rounded
#'     bbs_list$vehicle_data <- bbs_list$vehicle_data %>%
#'       dplyr::mutate(NoiseMean = round(rowSums(dplyr::across(
#'         dplyr::all_of(cols.noise)
#'       )) / 50)) # rounded
#'
#'     ## REMOVE STOP.LEVEL DATA (if specified) -----------------------------------
#'     if (!keep.stop.level.data) {
#'       # now remove all the unwanted columns
#'       cols = c(cols.stop, cols.noise, cols.car)
#'       for (i in seq_along(bbs_list)) {
#'         x = bbs_list[[i]]
#'         if (is.null(nrow(x)))
#'           next()
#'         bbs_list[[i]] <- x[,!(names(x) %in% cols)]
#'       }
#'       ### remove these columsn from all.samples as well
#'       all.samples <- all.samples[!colnames(all.samples) %in% cols]
#'
#'     }# end keep.stop.level.data
#'
#'     # ZERO-FILL DATA ----------------------------------------------------------
#'     # this finds the RTENO-year combinations that exist in the `sampled` data frame but no in bbs_observations.
#'     # it ensures all sampled RTENO-year combinations are include.
#'     if (zero.fill) {
#'       if (is.null(species) | length(unique(aous.keep)) != 1) {
#'         cat(
#'           "FYI: when zero.fill=TRUE, a single species should be provided in argument `species`. Not zero-filling the data.\n"
#'         )
#'       } else{
#'         ##
#'         ## force the AOU code to the unique in observations
#'         all.samples$AOU        <-
#'           unique(bbs_list$observations$AOU)
#'         ## force count to zero
#'         all.samples$RouteTotal <- 0
#'
#'         ## append the data to observations
#'         bbs_list$observations <- bbs_list$observations %>%
#'           dplyr::full_join(all.samples) %>%
#'           dplyr::group_by(RTENO, Year) %>%
#'           dplyr::filter(RouteTotal == max(RouteTotal, na.rm = TRUE)) %>%
#'           dplyr::ungroup() %>%
#'           dplyr::distinct(RTENO, Year, .keep_all = TRUE)
#'
#'       }# end inner zero-fill ifelse
#'     }#end zero-fill data
#'
#'
#'     # FILTER ALL LIST ELEMENTS FOR RTENO --------------------------------------
#'     ## this section identifies all the RTENOs common to list elements and removes others.
#'     # define all common rtenos
#'     rteno.filter <-
#'       Reduce(
#'         intersect,
#'         list(
#'           bbs_list$observations$RTENO,
#'           bbs_list$routes$RTENO,
#'           bbs_list$weather$RTENO,
#'           bbs_list$vehicle_data$RTENO,
#'           bbs_list$observers$RTENO
#'         )
#'       )
#'
#'     # keep only data with RTENO in rteno.filter across all relevant data frames in the list
#'     for (i in seq_along(bbs_list)) {
#'       if (!"RTENO" %in% names(bbs_list[[i]]))
#'         next()
#'       bbs_list[[i]] <-
#'         bbs_list[[i]] %>% dplyr::filter(RTENO %in% rteno.filter)
#'     }
#'
#'
#'     # MUNGE COLUMNS -----------------------------------------------------------
#'     # Make a new variable for DATE
#'     bbs_list <- lapply(bbs_list, function(x) {
#'       x <- make.dates(x)
#'     })
#'     bbs_list <-
#'       lapply(bbs_list, function(x) {
#'         x <- make.rteno(x)
#'       }) # add RTENO where it doesn't exist yet
#'     bbs_list <-
#'       lapply(bbs_list, function(x)
#'         x <- x[!(tolower(names(x)) %in% "routedataid")])
#'
#'     # CREATE VARIABLE FOR OBSERVER FIRST YEARS --------------------------------
#'     bbs_list$metadata <- bbs_list$weather %>%
#'       ##create binary for if observer's first year on the BBS and on the route
#'       dplyr::group_by(ObsN) %>% #observation identifier (number)
#'       dplyr::mutate(ObsFirstYearBBS = ifelse(Date == min(Date), 1, 0)) %>%
#'       dplyr::group_by(ObsN, RTENO, Year) %>%
#'       dplyr::mutate(ObsFirstYearRoute = ifelse(Date == min(Date), 1, 0)) %>%
#'       dplyr::ungroup() # to be safe
#'
#'     # Ensure No Duplicate Observations ----------------------------------------
#'     bbs_list$observations <- bbs_list$observations %>%
#'       distinct(RTENO, Year, AOU, .keep_all = TRUE)
#'
#'     # MAKE FLAT DATA OBJECT ---------------------------------------------------
#'     if (observations.output != "list") {
#'       cat("Collapsing BBS data and metadata into a single data frame.\n")
#'       df <-
#'         dplyr::left_join(bbs_list$observations, bbs_list$vehicle_data)
#'       df <- dplyr::left_join(df, bbs_list$routes)
#'       df <- dplyr::left_join(df, bbs_list$metadata)
#'       df <- dplyr::left_join(df, bbs_list$weather)
#'       df <-
#'         dplyr::left_join(
#'           df,
#'           bbs_list$observers %>% dplyr::select(-ObsFirstYearOnBBS , -ObsFirstYearOnRTENO)
#'         )
#'       bbs_df <- df %>% distinct(AOU, RTENO, Year, ObsN, .keep_all=TRUE)
#'       rm(df)
#'     }
#'
#'     ### again, ensure no duplicate observations
#'
#'     # Final Light Munging -----------------------------------------------------
#'     ### replace "NULL" values with NA
#'     for (i in seq_along(names(bbs_df))) {
#'       name = names(bbs_df[i])
#'       if (tolower(name) %in% c("date", "day", "year"))
#'         next()
#'       # skip the date col
#'       rows = which(bbs_df[name] == "NULL")
#'       if (length(rows) == 0)
#'         next()
#'       bbs_df[rows, name] <- NA
#'     }
#'     ## ensure the binary variables aren't of class character.
#'     bbs_df$Assistant <- as.integer(bbs_df$Assistant)
#'     bbs_df$ObsFirstYearRoute <- as.integer(bbs_df$ObsFirstYearRoute)
#'     bbs_df$ObsFirstYearBBS <- as.integer(bbs_df$ObsFirstYearBBS)
#'     bbs_df$StartTemp <- as.integer(bbs_df$StartTemp)
#'     bbs_df$EndTemp <- as.integer(bbs_df$EndTemp)
#'
#'     ## Create mean wind, sky, temp (these data are only from Stop 1 and Stop 50...)
#'     bbs_df$WindMean <- abs(bbs_df$EndWind - bbs_df$StartWind) / 2
#'     bbs_df$TempMean <- abs(bbs_df$EndTemp - bbs_df$StartTemp) / 2
#'
#'     # RETURN DATA FRAME ------------------------------------------------------------------
#'     return(bbs_df)
#'
#'   }
