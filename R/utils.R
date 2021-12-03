
make.dates <- function(x){
    ## create variables julian and date
    ## only applies to data frames in the bbs list with particular existing vars.
    ## called in import_bbs_data
    if(all(c("day","month","year") %in% tolower(names(x)))){
        x= x %>%
            dplyr::mutate(Date = as.Date(paste(Day, Month, Year, sep = "/"), format = "%d/%m/%Y"))
        x= x %>%
            dplyr::mutate(julian=julian(Date, origin=min(x$Date)))

    }else(return(x))
}


