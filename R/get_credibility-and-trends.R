## IN DEV 01 July 2019

#Loading the rvest package
library('rvest')
library(stringr)
library(tidyverse)
library(gdata)

#Specifying the url for desired website to be scraped
url <- 'https://www.mbr-pwrc.usgs.gov/cgi-bin/atlasa15.pl?KAN&2&15&csrfmiddlewaretoken=3YKakk7LxT2ki6NSpl4mstudYCqdW02C'

#Reading the HTML code from the website
webpage <- read_html(url)

# Get colored dot credibility ratings -LW

# grab images from xml nodes

webpage %>% 
  html_nodes("img") %>% 
  html_attrs()%>%
  as.list() -> dotList

# this is ugly, but works. Drop heading and summary images, make dataframe with indexes

dotKey = data.frame(credibilityColor = c("Red", "Yellow", "Blue"),
                    credibilityClass = c("important_deficiency", "deficiency", "no_deficiency"),
                    credibilityNumber = c("2", "1", "0"))

dotDF =    data.frame(credibilityNumber = unlist(dotList[4:length(dotList)])) %>%
           mutate(credibilityNumber = substr(credibilityNumber, 6, 6)) %>%
           left_join(dotKey, by = "credibilityNumber")
    
# Scrape trend data

webpage %>%
  html_nodes("#maincontent") %>%
  html_text() %>%
  strsplit(split = "\n") %>%
  unlist() %>%
  as.list() -> spp_credibility_trends

# clean up trend data

spp_credibility_trends[5:(length(spp_credibility_trends) - 1)] %>%
unlist() %>% 
  as_tibble() %>%
  #mutate(value = gsub(" ", ".", value)) %>%
  extract(value, c("Species", "N", "Trend_1966_2015",
                   "CI_95_1966_2015", "Trend_2005_2015",
                   "CI_95_2005_2015", "RA"), "(.............................)(....)(.........)(....................)(.........)(....................)(.........)",
                convert=TRUE) %>%
  mutate(CI_95_1966_2015 = gsub("\\(", "", CI_95_1966_2015),
         CI_95_1966_2015 = gsub("\\)", "", CI_95_1966_2015),
         CI_95_2005_2015 = gsub("\\(", "", CI_95_2005_2015),
         CI_95_2005_2015 = gsub("\\)", "", CI_95_2005_2015),
         Species = gsub("\\(all forms\\)", "", Species),
         Species = gsub("\\(all f\\)", "", Species),
         Species = gsub("\\(all fo\\)", "", Species),
         Species = gsub("\\(all\\)", "", Species)) %>%
  separate(CI_95_1966_2015, into = c("CI_2.5_1966_2015", "CI_97.5_1966_2015"), sep = ",") %>%
  separate(CI_95_2005_2015, into = c("CI_2.5_2005_2015", "CI_97.5_2005_2015"), sep = ",") %>%
  mutate(Species = gsub("\\(*","",Species)) %>%
  cbind(dotDF) %>% trim() -> spp_credibility_trends

  
