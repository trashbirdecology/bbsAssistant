context("get_regions")

RegionCodes <- get_regions()

test_that("Region data contains US and CA countries & the countryNum column name is assigned correctly.", {
    
    if(!exists('RegionCodes')) RegionCodes <- get_regions()
  
    expect_true(
      124 %in% unique(RegionCodes$countryNum) &
                   840 %in% unique(RegionCodes$countryNum)
                )     
    })

test_that("Region data contains US and CA countries & the stateName column name is assigned correctly.", {
    
    if(!exists('RegionCodes')) RegionCodes <- get_regions()
    
    expect_true(
        "FLORIDA" %in% unique(RegionCodes$stateName) 
    )     
})

