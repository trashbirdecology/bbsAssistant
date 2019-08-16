#' @title Get data credibility and trends from the BBS analysis results
#' @description The BBS provides regional and state-wide species population trend estimates. They also include a 'data credibility' rating (low, medium, or high deficiencies) for each species-region combination. This function uses web scraping to capture population trends and their credibility ratings.
#' @param url Web address of the region or state for which species' population trends and credibility ratings are to be scraped. Default example is 'Kansas,USA'.
#' @export get_credibility_trends
#' @importFrom magrittr %>%

get_credibility_trends <-
    function(url = 'https://www.mbr-pwrc.usgs.gov/cgi-bin/atlasa15.pl?FLA&2&15&csrfmiddlewaretoken=3YKakk7LxT2ki6NSpl4mstudYCqdW02C') {
        #Reading the HTML code from the specified website (example used == Kansas)
        webpage <- xml2::read_html(url)
        
        # Get colored dot credibility ratings
        # grab images from xml nodes
        ## the credibility ratings (red, yellow, blue) are provided only as "images".
        ## we need to capture the image names to associate a credibility rating to the species-region combination
        dotList <- webpage %>%
            rvest::html_nodes("img") %>%
            rvest::html_attrs() %>%
            as.list()
        
        # this is ugly, but works. Drop heading and summary images, make dataframe with indexes
        dotKey <- data.frame(
            credibilityColor = c("Red", "Yellow", "Blue"),
            credibilityClass = c("important_deficiency", "deficiency", "no_deficiency"),
            credibilityNumber = c("2", "1", "0")
        )
        
        dotDF <- data.frame(credibilityNumber = unlist(dotList[4:length(dotList)])) %>%
            dplyr::mutate(credibilityNumber = substr(credibilityNumber, 6, 6)) %>%
            dplyr::left_join(dotKey, by = "credibilityNumber")
        
        # Scrape trend data
        spp_credibility_trends.temp <- webpage %>%
            rvest::html_nodes("#maincontent") %>%
            rvest::html_text() %>%
            strsplit(split = "\n") %>%
            unlist() %>%
            as.list()
        
        # clean up trend data
        spp_credibility_trends <- spp_credibility_trends.temp[5:(length(spp_credibility_trends.temp) - 1)] %>%
            unlist() %>%
            dplyr::as_tibble() %>%
            # dplyr::mutate(value = gsub(" ", ".", value)) %>%
            tidyr::extract(
                value,
                c(
                    "Species",
                    "N",
                    "Trend_1966_2015",
                    "CI_95_1966_2015",
                    "Trend_2005_2015",
                    "CI_95_2005_2015",
                    "RA"
                ),
                "(.............................)(....)(.........)(....................)(.........)(....................)(.........)"
                # ,
                # convert = TRUE ## What is this? This is not an argument in extract. Please run unit test on this function when fixed.
            ) %>%
            dplyr::mutate(
                CI_95_1966_2015 = gsub("\\(", "", CI_95_1966_2015),
                CI_95_1966_2015 = gsub("\\)", "", CI_95_1966_2015),
                CI_95_2005_2015 = gsub("\\(", "", CI_95_2005_2015),
                CI_95_2005_2015 = gsub("\\)", "", CI_95_2005_2015),
                Species = gsub("\\(all forms\\)", "", Species),
                Species = gsub("\\(all f\\)", "", Species),
                Species = gsub("\\(all fo\\)", "", Species),
                Species = gsub("\\(all\\)", "", Species)
            ) %>%
            tidyr::separate(
                CI_95_1966_2015,
                into = c("CI_2.5_1966_2015", "CI_97.5_1966_2015"),
                sep = ","
            ) %>%
            tidyr::separate(
                CI_95_2005_2015,
                into = c("CI_2.5_2005_2015", "CI_97.5_2005_2015"),
                sep = ","
            ) %>%
            dplyr::mutate(Species = gsub("\\(*", "", Species)) %>%
            cbind(dotDF) 

        # This was here before, not sure why
         # %>% 
         #   glue::trim()

        # I dont liek this alternative, but...we need to force char columns to numeric..
        cols.num <- c( "N", "Trend_1966_2015", "CI_2.5_1966_2015", "CI_97.5_1966_2015", "Trend_2005_2015", "CI_2.5_2005_2015", "CI_97.5_2005_2015", "RA")
        spp_credibility_trends[cols.num] <- sapply(spp_credibility_trends[cols.num],as.numeric)
       
        return(spp_credibility_trends)
    }
