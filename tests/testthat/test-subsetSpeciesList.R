context("test-subsetSpeciesList")


test_that("Ensure species list subsetting works (by family, then order)", {
    testthat::skip_on_travis()
    testthat::skip_if_offline()
    
spp <- get_speciesList()
t <- subset_speciesList(spp, fam.ind = "Parulidae")
    expect_false("Parulidae" %in% t$family)
t2 <- subset_speciesList(spp, order.ind = "Passeriformes")
    expect_false("Passeriformes" %in% t2$order)


})


