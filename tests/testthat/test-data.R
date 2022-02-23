test_that("sb items lookup table is up to date", {
  ## this test needs improvement to tap into ScienceBase metadata.
  year=as.integer(format(Sys.Date(), "%Y"))

  if(year == 2022) year <- 2021 # no BBS data for 2020 release exist.
  testthat::expect_true(max(sb_items$year_end) >= year-2)
})



test_that("species_list seems ok on the surface", {
  cols=tolower(c("Seq","AOU", "English_Common_Name", "Spanish_Common_Name", "ORDER", "Family","Genus","Species", "AOU4", "AOU6")    )
testthat::expect_true(all(cols %in% tolower(names(species_list))))

})

