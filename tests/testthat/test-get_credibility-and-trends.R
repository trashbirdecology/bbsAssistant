context("test-get_credibility-and-trends")

library(rvest)
library(gdata)
library(xml2)
library(dplyr)
library(tidyr)

df <- get_credibility_trends()

test_that("Check the credibility scores object (df) is as expected. ", {
    expect_true(class(df)=="data.frame")
    expect_true(class(df$Species)=="character")
    expect_true(class(df$N)=="integer")
    expect_true(all(sort(names(df))==
                    c("CI_2.5_1966_2015" , "CI_2.5_2005_2015" , "CI_97.5_1966_2015" ,
                      "CI_97.5_2005_2015", "credibilityClass" ,
                      "credibilityColor" , "credibilityNumber", "N"   ,              "RA"  ,              "Species"        ,
                      "Trend_1966_2015",   "Trend_2005_2015" )
                    ))


    })

