
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



make.rteno <- function(x){
    ## create variable RTENO
    ## unique identifier for each route, which comprises unique country, state and route nums
    ## only applies to data frames in the bbs list with particular existing vars.
    if(all(c("CountryNum","StateNum","Route") %in% names(x))){
        RTENO=paste0(
            stringr::str_pad(x$CountryNum, width=3, side="left", pad="0"),
            stringr::str_pad(x$StateNum, width=2, side="left", pad="0"),
            stringr::str_pad(x$Route, width=3, side="left", pad="0"))
        x = x %>% dplyr::mutate(RTENO=RTENO) %>%
            dplyr::select(-CountryNum, -StateNum, -Route) # delete for mem and b/c this info is already captured in RTENO

    }else(return(x))
}


