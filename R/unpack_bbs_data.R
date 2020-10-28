#' @title Decompress the BBS observation files as obtained from ScienceBase.
#' @param sb_dir ...
#' @param country ...
#' @param state  ...
#' @param country ...
#' 
#' @export unpack_bbs_data

unpack_bbs_data <- function(
    sb_dir, 
    country, 
    state
){
    
# UNPACK STATES.ZIP --------------------------------------------------------------
# when unpacked, this folder contains yet more compressed files for each state/region
state_dir <- paste0(sb_dir,"/States")
# Unzip the States.zip into the sb_id item directory
unzip(list.files(sb_dir, full.names=TRUE, pattern="States.zip"), exdir = sb_dir)
# all newly created .zip files....
states.zipped <- list.files(state_dir, full.names=TRUE, ".zip") 

# UNPACK ALL STATES FILES -------------------------------------------------
# If neither state nor country are specified, just unpack all the state files. 
if(is.null(state) & is.null(country)){ lapply(states.zipped, unzip, exdir=state_dir)}


# UNPACK INDIVIDUAL STATES, OR STATES BY COUNTRY IF SPECIFIED -----------------------------------------------
# WILL ADD THIS FEATURE SOON!!!!!!


# END FUNCTION ------------------------------------------------------------

}
