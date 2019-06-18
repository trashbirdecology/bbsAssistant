## IN DEV

#Loading the rvest package
library('rvest')
library(stringr)

#Specifying the url for desired website to be scraped
url <- 'https://www.mbr-pwrc.usgs.gov/cgi-bin/atlasa15.pl?KAN&2&15&csrfmiddlewaretoken=3YKakk7LxT2ki6NSpl4mstudYCqdW02C'

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
