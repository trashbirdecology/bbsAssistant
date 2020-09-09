#' @title Read BBS data from local file into R environment.
#' @description 
#' @param sb_dir
#' @param state
#' @param country
#' 
#' 
import_bbs_data <- function(sb_dir, state=NULL, country=NULL){
    
# Get list of the available obesrvation filenames -----------------------------------------------------------
state.fns <- list.files(paste0(sb_dir, "/States/"), pattern=".csv", full.names=TRUE)
if(length(state.fns)==0){stop("No State-level csv files were found in ", sb_dir, "/States/", "./n/n", "Please ensure the data were downloaded and unpacked in the correctly location. Sorry :(")}

# Subset filenames by params state, country -------------------------------
##NEED TO ADD THIS FUNCITONALITY...
# state.fns %>% filter()    
    

# Load desired files into environment as a single dataframe -------------------------------------
state.data <- NULL
for(i in seq_along(state.fns)){
    message("Attempting to import file ", state.fns[i], " (File ",i," of ", length(state.fns), ")")
    suppressMessages( temp <- readr::read_csv(state.fns[i]), classes = ) # suppress all the messages about column types...bleh need to resolve this
    temp <- temp %>% 
        dplyr::mutate(StateNum = as.integer(StateNum), 
               CountryNum = as.integer(CountryNum) 
        )
    state.data <- dplyr::bind_rows(temp, state.data)
    
    }

# Join state.data with observation data with route metadata -------------------------------
routes  <-  suppressMessages(import_routes(sb_dir))

names(routes)
names(state.data)

# END FUNCTION ------------------------------------------------------------
return(bbs_data)
}