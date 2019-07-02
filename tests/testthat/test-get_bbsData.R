test_that("bbs data import from FTP server:: make sure all necessary columns exist", {
  
        expect_true(all(sort(names(dat)) ==    c("aou","count10","count20","count30","count40","count50",     
                                                 "countrynum","route", "routedataid","rpid","speciestotal","statenum",    
                                                 "stoptotal","year")))
})
