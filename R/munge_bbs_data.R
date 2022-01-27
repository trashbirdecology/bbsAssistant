#' @title Subset BBS observations data by one or more species of interest.
#' @description ...
#' @param year.range value(s) of year(s) by which to subset the data. If not specified will return all data in the dataset.
#' @param bbs_list A list with element "species_list", obtained from running bbsAssistant::get_bbs_data()...
#' @param species A vector of one or more species (using English Common Name) to subset the data by. Capitalization ignored.
#' @param genera vector of one or more genera  to retain in data
#' @param states vector of one or more states/territorties/sub-national political regions (see data(region_codes))
#' @param countries vector of one or more nations/countries (see data(region_codes))
#' @param order  vector of one or more orders to retain in data
#' @param family vector of one or more families to retain in data
#' @param QualityCurrentID an index used to indicate the quality of the BBS data. See BBS metadata at USGS ScienceBase for more infromation. Suggest keeping this value at 1 unless you know what you're doing
#' @param zero.fill If TRUE and a single species is provided in 'species', this function will output list$observations with zero-filled data.
#' @param active.only Logical. If TRUE keep only active routes. Discontinued routes will be discarded.
#' @param observations.output return the object as a list of data frames ("list") or a single data frame ("flat" or "df" or "data.frame")
#' @param keep.stop.level.data logical TRUE will keep the stop-level data and metadata. FALSE will remove these and provide only mean values or sums.
#' @importFrom dplyr mutate filter across group_by ungroup all_of
#' @export
munge_bbs_data <-
  function(bbs_list,
           states = NULL, #chacer vecr of ISO or english names. see region_codes
           countries = NULL, #chacer vecr of ISO or english names see region_codes
           species = NULL,
           genera=NULL,
           order=NULL,
           family=NULL,
           zero.fill = TRUE,
           year.range = 1966:lubridate::year(Sys.Date()),
           keep.stop.level.data = FALSE,
           QualityCurrentID = 1,
           active.only = FALSE,
           observations.output = "flat"
           ) {


# ARG CHECKS --------------------------------------------------------------
stopifnot(tolower(observations.output) %in% c("flat", "df","data.table","data.frame", "list"))
## add binded variables to avoid RCMD CHECK WHINING
Date <- ObsN <- Active <- AOU <- RTENO <-Year <-iso_3166_2<- iso_a2 <- NULL

# SUBSET BY SPATIAL INDEXES ---------------------------------------------------
# grab region codes
region_codes <- bbsAssistant::region_codes
# by country
if(!is.null(countries)){
  region_codes <- region_codes %>% dplyr::filter(tolower(iso_a2) %in% tolower(countries))
}
# by state/terr/prov
if(!is.null(states)){
  region_codes <- region_codes %>% dplyr::filter(tolower(gsub("-","", iso_3166_2)) %in% tolower(gsub("-","",states)))
}
if(nrow(region_codes)<1)stop("Region codes for countries and/or states not found. \nCall `bbsAssistant::region_codes` to ensure you are properly specifying regions.\n")

# filter the bbs data by region_codes
bbs_list$observations <- bbs_list$observations[ bbs_list$observations$CountryNum %in% region_codes$CountryNum,]
bbs_list$observations <- bbs_list$observations[ bbs_list$observations$StateNum %in% region_codes$StateNum,]
stopifnot(nrow(bbs_list$observations)>=1)

# TEMPORAL SUBSETTING -----------------------------------------------------
bbs_list$observations <- bbs_list$observations %>% dplyr::filter(Year %in% year.range)
stopifnot(nrow(bbs_list$observations)>=2)

# GRAB A LIST OF ALL SAMPLED ROUTES -------------------------------------------------------------------------
##before further subsetting, we want to grab an index of which routes were sampled each year (after we subset by year and spatial extent/loc)
sampled <-  bbs_list$observations %>%
  dplyr::distinct(Year, RTENO)
stopifnot(all(sampled$RTENO %in% bbs_list$routes$RTENO))

# TAXONOMIC SUBSETTING ----------------------------------------------------
## grab relevant taxonomic names and codes for subsetting BBS by species
if(is.null(species)){species <- unique(bbs_list$observations$AOU)}else{
  species <- tolower(species)
  sl      <- bbs_list$species_list
  inds = tolower(c(species, genera, family, order))
  cols = tolower(c("English_Common_Name", "Scientific_Name", "Family", "Genus","ORDER", "Species", "AOU", "AOU4", "AOU6"))
  aous.keep <- NULL
##i know there's a way to clean up with filter_Across or at or something but w/ev for now...
  for(i in seq_along(cols)){
    col.ind <- which(tolower(names(sl))==cols[i])
    row.ind <- which(tolower(sl[[col.ind]]) %in% inds)
    aous.keep <- c(sl$AOU[row.ind], aous.keep)
  }
  stopifnot(!is.null(aous.keep))
  ## now remove the unwanted species from observations
  bbs_list$observations <- bbs_list$observations %>% dplyr::filter(AOU %in% aous.keep)
} # end species subsetting

# BBS PROTOCOL SUBSETTING -----------------------------------------------------
bbs_list$weather <- bbs_list$weather %>% dplyr::filter(QualityCurrentID %in% QualityCurrentID)
if(active.only) bbs_list$routes  <- bbs_list$routes %>% dplyr::filter(Active==1)

# CREATE ROUTE-LEVEL MEANS AND SUMS ----------------------------------------
  cols.stop <- c(paste0("Stop", c(1:50))) # stop-level counts
  cols.wind <- c(paste0("Wind", c(1:50)))
  cols.noise <- c(paste0("Noise", c(1:50))) # stop-level noise covar
  cols.car <- c(paste0("Car", c(1:50))) # stop-level car covar
bbs_list$observations <-
  bbs_list$observations %>%
  mutate(RouteTotal=rowSums(dplyr::across(dplyr::all_of(cols.stop))))
bbs_list$vehicle_data <- bbs_list$vehicle_data %>%
  mutate(CarMean= round(rowSums(dplyr::across(dplyr::all_of(cols.car)))/50)) # rounded
bbs_list$vehicle_data <- bbs_list$vehicle_data %>%
  mutate(NoiseMean= round(rowSums(dplyr::across(dplyr::all_of(cols.noise)))/50)) # rounded
bbs_list$vehicle_data <- bbs_list$vehicle_data %>%
  mutate(WindMean= round(rowSums(dplyr::across(dplyr::all_of(cols.car)))/50)) # rounded

# REMOVE STOP.LEVEL DATA (if specified) -----------------------------------
if(!keep.stop.level.data){
  # now remove all the unwanted columns
  cols=c(cols.stop, cols.noise, cols.car)
  if (!keep.stop.level.data) {
    for (i in seq_along(bbs_list)) {
      x=bbs_list[[i]]
      if(is.null(nrow(x)))next()
      bbs_list[[i]] <- x[,!(names(x) %in% cols)]
    }
  }
}# end keep.stop.level.data


# ZERO-FILL DATA ----------------------------------------------------------
if(zero.fill){
  if(is.null(species)|length(aous.keep)!=1){
      message(
        "When zero.fill=TRUE, a single species should be provided in argument `species`. Not zero-filling the data.\n"
      )}else{
        # bbs_list$observations <-
        sampled$AOU        <- unique(bbs_list$observations$AOU)[1]
        sampled$RouteTotal <- 0
        bbs_list$observations <- bbs_list$observations %>%
          dplyr::full_join(sampled)
              }
  }#end zero-fill data

# FILTER ALL LIST ELEMENTS FOR RTENO --------------------------------------
## this section identifies all the RTENOs common to list elements and removes others.
# define all common rtenos
rteno.filter <- Reduce(intersect, list(bbs_list$observations$RTENO,
                                       bbs_list$routes$RTENO,
                                       bbs_list$weather$RTENO,
                                       bbs_list$vehicle_data$RTENO))
# filter out of all relevant data frames..
for(i in seq_along(bbs_list)){
  if(!"RTENO" %in% names(bbs_list[[i]]))next()
  bbs_list[[i]] <- bbs_list[[i]] %>% dplyr::filter(RTENO %in% rteno.filter)
}


# MUNGE COLUMNS -----------------------------------------------------------
# Make a new variable for DATE
bbs_list <- lapply(bbs_list, function(x) { x <- make.dates(x) })
bbs_list <- lapply(bbs_list, function(x) { x <- make.rteno(x) }) # add RTENO where it doesn't exist yet
bbs_list <- lapply(bbs_list, function(x) x <- x[!(tolower(names(x)) %in% "routedataid")])


# CREATE VARIABLE FOR OBSERVER FIRST YEARS --------------------------------
bbs_list$metadata <- bbs_list$weather %>%
      ##create binary for if observer's first year on the BBS and on the route
  dplyr::group_by(ObsN) %>% #observation identifier (number)
  dplyr::mutate(ObsFirstYearBBS = ifelse(Date == min(Date), 1, 0)) %>%
  dplyr::group_by(ObsN, RTENO, Year) %>%
  dplyr::mutate(ObsFirstYearRoute = ifelse(Date == min(Date), 1, 0)) %>%
      dplyr::ungroup() # to be safe

# MAKE FLAT DATA OBJECT ---------------------------------------------------
if(observations.output!="list"){
  cat("Collapsing BBS data and metadata into a single data frame.\n")
    df <- dplyr::left_join(bbs_list$observations, bbs_list$vehicle_data)
    df <- dplyr::left_join(df, bbs_list$routes)
    df <- dplyr::left_join(df, bbs_list$metadata)
    df <- dplyr::left_join(df, bbs_list$weather)
    bbs_list <- df
    rm(df)
}

return(bbs_list)

}
