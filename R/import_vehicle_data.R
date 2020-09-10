#' @description Unzips and imports the VehicleData.zip (into weather.csv) file associated with each BBS dataset. 
#' @title Import the VehicleData (number of vehicles observed during each stop).
#' @param sb_dir Directory for the ScienceBase (sb) item.
#' @export import_vehicle_data

 
import_vehicle_data <- function(sb_dir){
    # Unzip the States.zip into the SB item directory  (sb_dir) 
    unzip(list.files(sb_dir, full.names=TRUE, pattern="ehicleData.zip"), exdir = sb_dir)
    
    # this is a bug in the files that come into the system from sciencebase... 
    if(length(list.files(sb_dir, full.names=TRUE, pattern="VehicleData.csv"))==0){
        unzip(list.files(paste0(sb_dir,"/VehicleData/"), full.names=TRUE, pattern="ehicleData.zip"), exdir = sb_dir)
    }

    vehicles <- readr::read_csv(list.files(sb_dir, full.names=TRUE, pattern="VehicleData.csv")) %>% 
        dplyr::mutate(StateNum = as.integer(StateNum),
                      CountryNum = as.integer(CountryNum))
    
    return(vehicles)
}
