#' @title Read BBS data from local file into R environment. 
#' @description  Called inside `get_bbs_data()` but can be used independently if the user has already downloaded the data and provides the correct location for sb_dir. 
#' @param sb_id Identifier for SB item
#' @param sb_dir Directory location for the ScienceBase item.
#' @param state Optional. Imports certain files based on producer-supplied state/province codes or English names.
#' @param country Optional. Imports certain files based on producer-supplied country/nation codes or English names.
#' @export import_bbs_data

import_bbs_data <- function(sb_id, sb_dir, state=NULL, country=NULL){

# Get list of the available observation filenames -----------------------------------------------------------
state.fns <- list.files(paste0(sb_dir, "/States/"), pattern=".csv", full.names=TRUE)
if(length(state.fns)==0){stop("No State-level csv files were found in ", sb_dir, "/States/", "./n/n", "Please ensure the data were downloaded and unpacked in the correctly location. Sorry :(")}

# Subset filenames by params state, country -------------------------------
## NEED TO ADD THIS FUNCITONALITY...
# i.e., state.fns %>% filter()    
    
# Load desired observation files (per state) into environment as a single dataframe -------------------------------------
observations <- NULL
for(i in seq_along(state.fns)){
    message("Attempting to import file ", state.fns[i], " (File ",i," of ", length(state.fns), ")")
    suppressMessages( temp <- readr::read_csv(state.fns[i]), classes = ) # suppress all the messages about column types...bleh need to resolve this
    temp <- temp %>% 
        dplyr::mutate(StateNum = as.integer(StateNum), 
               CountryNum = as.integer(CountryNum) 
        )
    observations <- dplyr::bind_rows(temp, observations)
    }

# Load the route level metadata for this dataset release -------------------------------
routes  <-  suppressMessages(bbsAssistant::import_routes(sb_dir))
weather <-  suppressMessages(bbsAssistant::import_weather(sb_dir))
# unique(routes$StateNum) %in% unique(state.data$StateNum) # THIS SHOULD BE A TEST!
# unique(state.data$RouteDataID) %>% length() # should also be a test....


# Get dataset citation(s) -------------------------------------------------
citation <- sbtools::item_get_fields(sb_id, "citation")

# Get species list (Currently abides to AOU standards per BBS metadata) --------------------------------------------------
# data(species_list, package="bbsAssistant")
species_list <- bbsAssistant::species_list


# Load in the emost recent observations data -------------------------------
bbs_obs <- bbsAssistant::bbs_obs


# Add filtering/subsetting functions for states, countries, species -------


# Create a list of data and information to export or return to `get_bbs_data`----------------------------------dfnames <-
bbs <- list(observations, routes, weather, citation, species_list)
names(bbs) <-
    c("observations",
      "routes",
      "weather",
      "citation",
      "species_list")

# END FUNCTION ------------------------------------------------------------
return(bbs)
}
