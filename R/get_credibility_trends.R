#' @description A function using web scraping tools to retrieve region-specific species trend estimates [@sauer2017north] and data credibility ratings. Current functionality does not include retrieving estimates per species, but rather per region.
#' @title Scrape BBS data credibility scores and population trend estimates from BBS website
#' @references Regional Credibility Measures information can be found online at <https://www.mbr-pwrc.usgs.gov/bbs/credhm09.html>
#' @param url The url location of the web page to be scraped. Currently, you will have to specify this url. Default url is House Sparrows in Florida.

get_credibility_trends <-
    function(url = "https://www.mbr-pwrc.usgs.gov/cgi-bin/atlasa15.pl?FLA&2&15&csrfmiddlewaretoken=3YKakk7LxT2ki6NSpl4mstudYCqdW02C") {
        #Specifying the EXAMPLE url for desired website to be scraped
        # if(is.null(url)) url <- 'https://www.mbr-pwrc.usgs.gov/cgi-bin/atlasa15.pl?FLA&2&15&csrfmiddlewaretoken=3YKakk7LxT2ki6NSpl4mstudYCqdW02C' # Florida example
        # if(is.null(url)) url <- 'https://www.mbr-pwrc.usgs.gov/cgi-bin/atlasa15.pl?KAN&2&15&csrfmiddlewaretoken=3YKakk7LxT2ki6NSpl4mstudYCqdW02C' # Kansas example
        
        #Reading the HTML code from the website
        webpage <- read_html(url)
        
        # Get the  credibility ratings which are scored by the USGS BBS team according to colors (red, yellow, and blue)
        # grab images from xml nodes
        dotList <-
            webpage %>%
            html_nodes("img") %>%
            html_attrs() %>%
            as.list()
        
        
        # This could be a little cleaner, but works. Drop heading and summary images, make dataframe with indexes
        dotKey <- data.frame(
            credibilityColor = c("Red", "Yellow", "Blue"),
            credibilityClass = c("important_deficiency", "deficiency", "no_deficiency"),
            credibilityNumber = c("2", "1", "0")
        )
        
        dotDF <-
            data.frame(credibilityNumber = unlist(dotList[4:length(dotList)])) %>%
            mutate(credibilityNumber = substr(credibilityNumber, 6, 6)) %>%
            left_join(dotKey, by = "credibilityNumber")
        
        # Scrape trend data from the website
        spp_credibility_trends <- webpage %>%
            html_nodes("#maincontent") %>%
            html_text() %>%
            strsplit(split = "\n") %>%
            unlist() %>%
            as.list()
        
        # munge the trend data
        spp_credibility_trends <-
            spp_credibility_trends[5:(length(spp_credibility_trends) - 1)] %>%
            unlist() %>%
            tibble() %>%
            #mutate(value = gsub(" ", ".", value)) %>%
            # tidyr::extract( # not sure which package she was usign for extract
                extract(
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
                "(.............................)(....)(.........)(....................)(.........)(....................)(.........)",
                convert = TRUE
            ) %>%
            mutate(
                CI_95_1966_2015 = gsub("\\(", "", CI_95_1966_2015),
                CI_95_1966_2015 = gsub("\\)", "", CI_95_1966_2015),
                CI_95_2005_2015 = gsub("\\(", "", CI_95_2005_2015),
                CI_95_2005_2015 = gsub("\\)", "", CI_95_2005_2015),
                Species = gsub("\\(all forms\\)", "", Species),
                Species = gsub("\\(all f\\)", "", Species),
                Species = gsub("\\(all fo\\)", "", Species),
                Species = gsub("\\(all\\)", "", Species)
            ) %>%
            separate(
                CI_95_1966_2015,
                into = c("CI_2.5_1966_2015", "CI_97.5_1966_2015"),
                sep = ","
            ) %>%
            separate(
                CI_95_2005_2015,
                into = c("CI_2.5_2005_2015", "CI_97.5_2005_2015"),
                sep = ","
            ) %>%
            mutate(Species = gsub("\\(*", "", Species)) %>%
            cbind(dotDF) %>% trim()
        
        
        return(spp_credibility_trends)
        
    }
