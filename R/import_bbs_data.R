#' @title Read BBS data from local file into R environment. 
#' @description  Called inside `get_bbs_data()` but can be used independently.
#' @param sb_dir Directory location for the ScienceBase item.
#' @param state Optional. Imports certain files based on producer-supplied state/province codes or English names.
#' @param country Optional. Imports certain files based on producer-supplied country/nation codes or English names.

import_bbs_data <- function(sb_dir, state, country){
    
# Get list of the available obesrvation filenames -----------------------------------------------------------
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
    observations <- dplyr::bind_rows(temp, state.data)
    }

# Load the route level metadata for this dataset release -------------------------------
routes  <-  suppressMessages(import_routes(sb_dir))
weather <-  suppressMessages(import_weather(sb_dir))
# unique(routes$StateNum) %in% unique(state.data$StateNum) # THIS SHOULD BE A TEST!
# unique(state.data$RouteDataID) %>% length() # should also be a test....


# Get dataset citation(s) -------------------------------------------------
citation <- sbtools::item_get_fields(sb_id, "citation")

# Create a list of data and information to export or return to `get_bbs_data` ----------------------------------
bbs <- list(observations, routes, weather, citation)
names(bbs) <- c("observations", "routes", "weather", "citation")


# END FUNCTION ------------------------------------------------------------
return(bbs)
}