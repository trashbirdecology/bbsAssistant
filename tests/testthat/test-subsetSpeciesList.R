context("test-subsetSpeciesList")

test_that("Ensure species list subsetting works (by order + fam)",{
    
    spp <- get_speciesList()

    t <- subset_speciesList(spp, fam.ind="Parulidae")
    
    expect_false("Parulidae" %in% t$family )
  
    t <- subset_speciesList(spp, order.ind="Passeriformes")
    expect_false("Passeriformes" %in% t$order )
    
} )   
