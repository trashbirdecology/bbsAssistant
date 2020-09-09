## this function is called inside get_bbs_data
# used to decompress the typically compressed files within the sb item fileset

unpack_bbs_data <- function(
    sb_dir, 
    
)
    
    

# UNPACK STATES.ZIP --------------------------------------------------------------
## when unpacked, this folder contains yet more compressed files for each state/region
state_dir <- paste0(sb_dir,"/States/")
states.zipped <- list.files(state_dir, full.names=TRUE) 
lapply(states.zipped, unzip, exdir=state_dir)


# UNPACK INDIVIDUAL REGIONS -----------------------------------------------
if(exists("regions")){
    
}
