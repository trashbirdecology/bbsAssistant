#' Make Date and Julian Day Variable
#'
#' Creates a new variables, \code{c("Date","julian")}, if dataframe has columns \code{c("Day", "Month", "Year")}
#'
#' @param df a flat data object.
#' @param collapse logical. If TRUE will remove the columns 'Day', 'Month', and 'Year'
#' @usage make.dates(df, collapse=FALSE)
#' @importFrom dplyr mutate select
#' @export make.dates

make.dates <- function(df, collapse=FALSE){

Day <- Month <- Year <- Date  <- NULL # bind variable to avoid CMD CHK WARNING


    ## create variables julian and date
    ## only applies to data frames in the bbs list with particular edfisting vars.
    ## called in import_bbs_data
    if(all(c("Day","Month","Year") %in% names(df))){
        df= df %>%
            dplyr::mutate(Date = as.Date(paste(Day, Month, Year, sep = "/"), format = "%d/%m/%Y"))
        df= df %>%
            dplyr::mutate(julian=julian(Date, origin=min(df$Date)))

    }else(return(df))

    if(collapse) df <- df %>% dplyr::select(-Day, -Month, -Year)

    return(df)
}


