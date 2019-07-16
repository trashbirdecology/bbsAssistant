context("test-subsetSpeciesList")

spp <- get_speciesList()
t <- subset_speciesList(spp, fam.ind="Parulidae")
t2 <- subset_speciesList(spp, order.ind="Passeriformes")

test_that("Ensure species list subsetting works (by family)",{
    
    expect_false("Parulidae" %in% t$family )
} )   
    


test_that("Ensure species list subsetting works (by order )",{
    
    expect_false("Passeriformes" %in% t2$order )
    
} ) 
