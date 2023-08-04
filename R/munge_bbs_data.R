#' @title Subset BBS Data by One or More Parameters
#' @description This function subsets the BBS observations using taxonomic, geospatial, or temporal features.
#' @param year.range value(s) of year(s) by which to subset the data. If not specified will return all data in the dataset.
#' @param bbs_list A list with element "species_list", obtained from running bbsAssistant::get_bbs_data()...
#' @param species A vector of one or more species (using English Common Name) to subset the data by. Capitalization ignored.
#' @param genera vector of one or more genera  to retain in data
#' @param states vector of one or more states/territories/sub-national political regions (see data(region_codes))
#' @param countries vector of one or more nations/countries (see data(region_codes))
#' @param order  vector of one or more orders to retain in data
#' @param family vector of one or more families to retain in data
#' @param rpid mostly for internal use. See BBS metadata documentation for more details.
#' @param QualityCurrentID an index used to indicate the quality of the BBS data. See BBS metadata at USGS ScienceBase for more information. Suggest keeping this value at 1 unless you know what you're doing
#' @param zero.fill If TRUE and a single species is provided in 'species', this function will output list$observations with zero-filled data.
#' @param active.only Logical. If TRUE keep only active routes. Discontinued routes will be discarded.
#' @param observations.output return the object as a list of data frames ("list") or a single data frame ("flat" or "df" or "data.frame")
#' @param keep.stop.level.data logical TRUE will keep the stop-level data and metadata. FALSE will remove these and provide only mean values or sums.
#' @importFrom dplyr mutate filter across group_by ungroup all_of distinct left_join full_join select inner_join if_any everything
#' @export munge_bbs_data
munge_bbs_data <-
  function(bbs_list,
           states = NULL,
           countries = NULL,
           species = NULL,
           genera = NULL,
           order = NULL,
           family = NULL,
           zero.fill = TRUE,
           rpid = 101,
           year.range = 1966:lubridate::year(Sys.Date()),
           keep.stop.level.data = FALSE,
           QualityCurrentID = 1,
           active.only = FALSE,
           observations.output = "flat") {

    # HELPER FUNS --------------------------------------------------------------
    ## get list of RTENOS that appear across all relevant data frames in teh bbs list
    .filter.rtenos <- function(x){
      stopifnot(all(c("observations", "routes","weather", "vehicle_data","observers") %in% names(x)))
      out <-
        Reduce(
          intersect,
          list(
            x$observations$RTENO,
            x$routes$RTENO,
            x$weather$RTENO,
            x$vehicle_data$RTENO,
            x$observers$RTENO
          )
        )
      return(out)
    }
    # keep only the RTENOS that appear in the obsevations data frame at any time.
    .remove.rtenos <- function(x){
      stopifnot(is.list(x))
      x.out <- list()
      temp.rtenos <- .filter.rtenos(x)

      for(i in seq_along(x)){
        if(!"RTENO" %in% colnames(x[[i]])){x.out[[i]] <- x[[i]]
        x.out[[i]] <- x[[i]]
        next()}
        x.out[[i]] <- x[[i]] %>%
            dplyr::filter(RTENO %in% temp.rtenos)
      }
      names(x.out) <- names(x)
      rm(x)
      return(x.out)
    }


    # ARG CHECKS --------------------------------------------------------------
    stopifnot(
      tolower(observations.output) %in% c("flat", "df", "data.table", "data.frame", "list")
    )
    stopifnot(
      rpid %in% c(101 ,501, 103, 102, 203)
    )
    ## add binded variables to avoid RCMD CHECK WHINING
    State <-
      StateNum <-
      Date <-
      RouteTotal <-
      ObsN <-
      Active <-
      AOU <-
      RTENO <-
      Year <-
      iso_3166_2 <-
      CountryNum <- RPID <-
      iso_a2 <- ObsFirstYearOnRTENO <- ObsFirstYearOnBBS  <- NULL

    # Change name that matches column to avoid confusion
    QualityCurrentIDIn <- QualityCurrentID

    # SPATIOTEMPORAL SUBSETTING -----------------------------------------------
    ## SPATIAL SUBSETTING OBSERVATIONS ---------------------------------------------------
    # grab region codes
    region_codes <- bbsAssistant::region_codes
    # by country
    if (!is.null(countries)) {
      region_codes <-
        region_codes %>% dplyr::filter(tolower(iso_a2) %in% tolower(countries))
    }
    # by state/terr/prov
    if (!is.null(states)) {
      states <- tolower(gsub("-", "", states)) # munge the states a little
      all.region.codes <- c(
        tolower(region_codes$iso_3166_2),
        gsub("-", "", tolower(region_codes$iso_3166_2)),
        tolower(region_codes$State),
        region_codes$StateNum
      )
      # overlap  <- states[which(states %in% all.region.codes)]
      overlap <-
        all.region.codes[which(all.region.codes %in% states)]

      if (length(overlap) >= 1) {
        region_codes <-
          region_codes %>%
          dplyr::filter(
            gsub("-", "", tolower(StateNum)) %in% overlap |
              gsub("-", "", tolower(State)) %in% overlap |
              gsub("-", "", tolower(iso_3166_2))  %in% overlap
          )
      } else{
        message("states specified in arg `states` were not found. returning all states.")
      }
    } # end states subsetting

    # filter the bbs observations data by all region_codes
    myobs <- bbs_list$observations %>%
      dplyr::filter(CountryNum  %in% region_codes$CountryNum) %>%
      dplyr::filter(StateNum    %in% region_codes$StateNum)

    stopifnot(nrow(myobs) >= 1)

    ## TEMPORAL SUBSETTING OBSERVATIONS -----------------------------------------------------
    myobs <-
      myobs %>% dplyr::filter(Year %in% year.range)
    stopifnot(nrow(myobs) >= 2)

    # BBS PROTOCOL SUBSETTING -----------------------------------------------------
    ## RPID appears in weather and in vehicle data.
    ## the last code in this chunk (.remove.rtenos) should allow only one filter on either
    ### weather or vehicle_data to take place, but needs to be tested.
    myweather <-
      bbs_list$weather %>% dplyr::filter(QualityCurrentID %in% QualityCurrentIDIn &
                                           RPID %in% rpid)
    mycars <- bbs_list$vehicle_data <- bbs_list$vehicle_data %>% dplyr::filter(RPID %in% rpid)

    myroutes <- bbs_list$routes
    if (active.only){
      myroutes  <-
        myroutes %>% dplyr::filter(Active == 1)    }


    # Grab a list of common RTENOS after the basic subsetting occurred --------
    # define myobservers
    myobservers <- bbs_list$observers

    ###
    all.relevant.data <- .remove.rtenos(
      x=list(weather = myweather, observations = myobs, routes = myroutes, vehicle_data = mycars, observers = myobservers))
    # any(is.na(list.filtered$observers$ObsN))


    # DEFINE FILTER FOR FUTURE TAXONOMIC SUBSETTING ----------------------------------------------------
    ## grab relevant taxonomic names and codes for subsetting BBS by species
    if (is.null(species)) {
      species <- unique(all.relevant.data$observations$AOU)
      aous.keep <- unique(species)
    } else{
      species <- tolower(species)
      sl      <- bbs_list$species_list
      inds = tolower(c(species, genera, family, order))
      cols = tolower(
        c(
          "English_Common_Name",
          "Scientific_Name",
          "Family",
          "Genus",
          "ORDER",
          "Species",
          "AOU",
          "AOU4",
          "AOU6"
        )
      )
      aous.keep <- NULL
      ##i know there's a way to clean up with filter_Across or at or something but w/ev for now...
      for (i in seq_along(cols)) {
        col.ind <- which(tolower(names(sl)) == cols[i])
        row.ind <- which(tolower(sl[[col.ind]]) %in% inds)
        aous.keep <- c(sl$AOU[row.ind], aous.keep)
      }
      stopifnot(!is.null(aous.keep))
      aous.keep <- unique(aous.keep)
    } # end create aous.keep

    # MAKE ROUTE_LEVEL DATA -----------------
    ## CREATE ROUTE-LEVEL MEANS AND SUMS ACROSS ALL DATA  ----------------------------------
    cols.stop <- c(paste0("Stop", c(1:50))) # stop-level counts
    cols.wind <- c(paste0("Wind", c(1:50)))
    cols.noise <-
      c(paste0("Noise", c(1:50))) # stop-level noise covar
    cols.car <- c(paste0("Car", c(1:50))) # stop-level car covar

    all.relevant.data$observations <-
      all.relevant.data$observations %>%
      dplyr::mutate(RouteTotal = rowSums(dplyr::across(dplyr::all_of(cols.stop))))

    all.relevant.data$vehicle_data <- all.relevant.data$vehicle_data %>%
      dplyr::mutate(CarMean = round(rowSums(dplyr::across(
        dplyr::all_of(cols.car)
      )) / 50)) # rounded
    all.relevant.data$vehicle_data <- all.relevant.data$vehicle_data %>%
      dplyr::mutate(NoiseMean = round(rowSums(dplyr::across(
        dplyr::all_of(cols.noise)
      )) / 50)) # rounded


    ## REMOVE STOP.LEVEL DATA (if specified) -----------------------------------
    if (!keep.stop.level.data) {
      # now remove all the unwanted columns
      cols = c(cols.stop, cols.noise, cols.car, "RecordedCar")
      for (i in seq_along(all.relevant.data)) {
        x = all.relevant.data[[i]]
        if (is.null(nrow(x)))
          next()
        all.relevant.data[[i]] <- x[,!(names(x) %in% cols)]
      }
      ## remove these columns from all.route.years as well
      # all.route.years <- all.route.years[!colnames(all.route.years) %in% cols]
    }# end keep.stop.level.data

    if(any(is.na(all.relevant.data$vehicle_data$CarMean)))stop("CarMean has NA values")
    if(any(is.na(all.relevant.data$vehicle_data$NoiseMean)))stop("NoiseMean has NA values")
    if(any(is.na(all.relevant.data$observations$RouteTotal)))stop("RouteTotal has NA values")

    # ZERO-FILL DATA ----------------------------------------------------------
    # this finds the RTENO-year combinations that exist in the `sampled` data frame but no in bbs_observations.
    # it ensures all sampled RTENO-year combinations are include.
    if (zero.fill) {
      if (is.null(species) | length(unique(aous.keep)) > 1) {
        message(
          "Warning: when zero.fill=TRUE, a single species should be provided in argument `species`. \n\tReturned data will NOT be zero-filled.\n"
        )
      } else{
        ##
        ## replace all non-aous.keep RouteTotals to ZERO, then
        #### replace the AOU with aous.keep (a single value...)
        #### then keep the max value for route-year combination.
        all.relevant.data$observations <- all.relevant.data$observations %>%
          dplyr::mutate(RouteTotal = ifelse(AOU %in% aous.keep, RouteTotal, 0),
                 AOU        = aous.keep
          ) %>%
          dplyr::group_by(Year, RTENO) %>%
          dplyr::filter(RouteTotal == max(RouteTotal, na.rm = TRUE)) %>%
          dplyr::ungroup() %>%
          dplyr::distinct(RTENO, Year, .keep_all = TRUE)

      }# end inner zero-fill ifelse
    }else{
      ## if zero.fill is not specified, then filter out by aous.keep
      all.relevant.data$observations <- all.relevant.data$observations %>%
        dplyr::filter(AOU %in% aous.keep)
    }#end zero-fill data

    # MUNGE COLUMNS -----------------------------------------------------------
    # Make a new variable for DATE
    all.relevant.data <- lapply(all.relevant.data, function(x) {
      x <- make.dates(x)
    })
    # Ensure each list has RTENO
    all.relevant.data <-
      lapply(all.relevant.data, function(x) {
        x <- make.rteno(x)
      })
    # Remove routedataidenifier
    all.relevant.data <-
      lapply(all.relevant.data, function(x)
        x <- x[!(tolower(names(x)) %in% "routedataid")])

    # MAKE FLAT DATA OBJECT ---------------------------------------------------
    if (observations.output != "list") {
      cat("Creating a flat data frame as output object.\n")
      suppressMessages(bbs_df <- dplyr::inner_join(all.relevant.data$observations, all.relevant.data$vehicle_data)) # suppress join by messages in this chunk

      suppressMessages(bbs_df <- dplyr::inner_join(bbs_df, bbs_list$routes))
      suppressMessages(bbs_df <- dplyr::inner_join(bbs_df, all.relevant.data$observers))
      suppressMessages(bbs_df <- dplyr::inner_join(bbs_df, all.relevant.data$weather))
      bbs_df <- bbs_df %>% dplyr::distinct(AOU, RTENO, Year, ObsN, .keep_all=TRUE)
    }


    # Final Light Munging -----------------------------------------------------
    ### replace "NULL" values with NA
    for (i in seq_along(names(bbs_df))) {
      name = names(bbs_df[i])
      if (tolower(name) %in% c("date", "day", "year"))
        next()
      # skip the date col
      rows = which(bbs_df[name] == "NULL")
      if (length(rows) == 0)
        next()
      bbs_df[rows, name] <- NA
    }
    # names(bbs_df)
    ## ensure the binary variables aren't of class character.
    # cat("wrapping up loose ends..\n")
  bbs_df <-
    bbs_df %>%
    dplyr::mutate(across(c("Assistant", "ObsFirstYearOnRTENO", "ObsFirstYearOnBBS",
                           "EndWind", "StartWind", "EndTemp", "StartTemp"), as.integer))%>%
    dplyr::rename(ObsFirstYearBBS = ObsFirstYearOnBBS,
                  ObsFirstYearRoute = ObsFirstYearOnRTENO)

    ## Create mean wind, sky, temp (these data are only from Stop 1 and Stop 50...)
    bbs_df$WindMean <- abs(bbs_df$EndWind - bbs_df$StartWind) / 2
    bbs_df$TempMean <- abs(bbs_df$EndTemp - bbs_df$StartTemp) / 2 ## if either the sdtart or the end temp or wind are AN, then the MEan will also be NA.

    # RETURN DATA FRAME ------------------------------------------------------------------
    return(bbs_df)

  }
