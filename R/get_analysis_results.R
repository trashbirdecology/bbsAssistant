#' @title Get annual abundance indices from BBS analyses. 
#' @description Downloads all species-regions annual abundances indices from various .csv files on the BBS analysis results page. See <https://www.mbr-pwrc.usgs.gov/bbs/BBSAnalysis_Results_Metadata_1966_2017_v3.xml> for metadata for analysis results and trend estiamtes. 
#' @param analysis Default = "trend.ests". Must be one of :c("annual.inds.2016", "trend.ests","core.trend.revised.2017", "core.2017","expanded.2017","core.twedt.revised.2017")
#' @param url Web link to the .csv file for annual abundance indices. Default = NULL.
#' @export get_analysis_results

get_analysis_results <-
    function(url = NULL, 
             analysis = "trend.ests"
             ) {
        
        if(!analysis %in% c("annual.inds.2016", "trend.ests","core.trend.revised.2017",
                            "core.2017","expanded.2017","core.twedt.revised.2017")) error("Please specify arg 'analysis'")
        
        if(analysis=="trend.ests") url <- "https://www.mbr-pwrc.usgs.gov/bbs/BBS_Trend_Estimates_2015_7-29-2016.csv"
        if(analysis=="annual.inds.2016") url <- "https://www.mbr-pwrc.usgs.gov/bbs/BBS_Annual_Indices_Estimates_2015_7-29-2016.csv"
        if(analysis=="core.trend.revised.2017") url <- "https://www.mbr-pwrc.usgs.gov/bbs/BBS_1966-2017_core_trend_revised_v2.csv"
        if(analysis=="core.2017") url <- "https://www.mbr-pwrc.usgs.gov/bbs/inde_1966-2017_core_v2.csv"
        if(analysis=="expanded.2017") url <- "https://www.mbr-pwrc.usgs.gov/bbs/inde_1993-2017_expanded.csv"
        if(analysis=="core.twedt.revised.2017") url <- "https://www.mbr-pwrc.usgs.gov/bbs/BBS_1966-2017_core_twedt_trend_revised.csv"
        
        
        df  <- read.csv(url)
        
    }