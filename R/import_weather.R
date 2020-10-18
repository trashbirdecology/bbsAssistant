#' @description Unzips and imports the Weather.zip (into weather.csv) file associated with each BBS dataset. 
#' @title Import the weather conditions associated with route-level observations. 
#' @param sb_dir Directory for the ScienceBase (sb) item.
#' @export import_weather
#' 
import_weather <- function(sb_dir){
    # Unzip the States.zip into the SB item directory  (sb_dir) 
    unzip(list.files(sb_dir, full.names=TRUE, pattern="eather.zip"), exdir = sb_dir)
    
    weather <- readr::read_csv(list.files(sb_dir, full.names=TRUE, pattern="weather.csv")) %>% 
        dplyr::mutate(StateNum = as.integer(StateNum),
                      CountryNum = as.integer(CountryNum))
    
    return(weather)
}
