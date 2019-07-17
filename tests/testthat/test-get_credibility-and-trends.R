context("test-get_credibility-and-trends")

test_that("Dummy test", {
  expect_true(2 == 2 )
})

# test_that("Check the credibility scores object (df) is as expected. ", {
#   skip_on_travis()
#   skip_if_offline()
#   df <- get_credibility_trends()
#     expect_true(class(df)=="data.frame")
#     expect_true(class(df$Species) %in% c("factor","character"))
#     
#     colnames =  c(
#         "CI_2.5_1966_2015" ,
#         "CI_2.5_2005_2015" ,
#         "CI_97.5_1966_2015" ,
#         "CI_97.5_2005_2015",
#         "N"   ,
#         "Trend_1966_2015",
#         "RA"  ,
#         "Trend_2005_2015")
#     
#     t = sapply(df[colnames], class)
# 
#     for(i in seq_along(colnames)){
#         expect_true(t[i] %in% c("numeric","integer"))
#         
#     }
#     
#         
#     
#   expect_true(all(sort(names(df))==
#                     c("CI_2.5_1966_2015" , "CI_2.5_2005_2015" , "CI_97.5_1966_2015" ,
#                       "CI_97.5_2005_2015", "credibilityClass" ,
#                       "credibilityColor" , "credibilityNumber", "N"   ,              "RA"  ,              "Species"        ,
#                       "Trend_1966_2015",   "Trend_2005_2015" )
#                     ))
# 
# 
#     })
# 