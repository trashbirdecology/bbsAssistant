#' Make Identifying Variable for Routes
#'
#' Creates a new variable, \code{RTENO}, if dataframe has columns \code{c("CountryNum", "StateNum", "Route")}
#'
#' @param df a flat data object.
#' @usage make.rteno(df)
#' @export make.rteno


make.rteno <- function(df){
  ## create variable RTENO
  ## unique identifier for each route, which comprises unique country, state and route nums
  ## only applies to data frames in the bbs list with particular existing vars.
  if(all(c("CountryNum","StateNum","Route") %in% names(df))){
    RTENO=paste0(
      stringr::str_pad(df$CountryNum, width=3, side="left", pad="0"),
      stringr::str_pad(df$StateNum, width=2, side="left", pad="0"),
      stringr::str_pad(df$Route, width=3, side="left", pad="0"))
    df = df %>% dplyr::mutate(RTENO=RTENO)

  }else(return(df))
}

