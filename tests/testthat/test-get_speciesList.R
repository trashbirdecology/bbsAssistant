test_that("Ensure import of specieslist.txt is correct by checking col names", {
expect_true(all(
        sort(names(spp))==c(
        "aou","commonName","family",
        "frenchCommonName", "genus","order",  
        "scientificName","seq","species"))
        )
    
})
