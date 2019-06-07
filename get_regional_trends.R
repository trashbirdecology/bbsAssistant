#' Get BBS regional trend estimates
#'
#' This function scrapes the HTML of the regional trend estimates webpage, allowing you to obtain regional trend estimates for species by region combinations. A url is required for each region of interest.
#' @param url The webpage of the regional trend estimates from the BBS wepage. Get URL by visiting `url(https://www.mbr-pwrc.usgs.gov/bbs/reglist15.shtml)`. Default is the webpage for the survey-wide trend estimates. 
#' @keywords bbs
#' @export 
#' @examples
#' @imports 
#' get_regional_trends()

get_regional_trends <- function(url = 'https://www.mbr-pwrc.usgs.gov/cgi-bin/atlasa15.pl?SUR&2&15&csrfmiddlewaretoken=3YKakk7LxT2ki6NSpl4mstudYCqdW02Cs'){

#Reading the HTML code from the website
webpage <- read_html(url)

webpage %>% html_text()


spp_credibility_trends <- webpage %>%
    html_nodes("#maincontent") %>% 
    html_text() %>% 
    strsplit(split = "\n") %>%
    unlist() %>%
    .[. != ""] %>% 
    str_replace_all(pattern = "\n", replacement = " ") %>%
    str_replace_all(pattern = "\\(all forms\\)", replacement = "") %>%
    str_replace_all(pattern = "\\(all f", replacement = "") %>%
    str_replace_all(pattern = "\\(all fo", replacement = "") %>%
    str_replace_all(pattern = "\\(all", replacement = "") %>%
    str_replace_all(pattern = "[\\^]", replacement = " ") %>%
    str_replace_all(pattern = "\"", replacement = " ") %>%
    str_replace_all(pattern = "\\s+", replacement = " ") %>%
    str_trim(side = "both") 

# remove the note at the bottom and the first two rows
spp_credibility_trends <- spp_credibility_trends[-c(1,2,length(spp_credibility_trends))]

spp_credibility_trends %>% as_tibble() %>% separate()
    
}





