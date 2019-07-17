context("test-get_speciesList")


test_that("Ensure import of specieslist.txt is correct by checking col names",
          {
              testthat::skip_on_travis()
              testthat::skip_if_offline()
              
              spp <- get_speciesList()
              expect_true(all(
                  sort(names(spp)) == c(
                      "aou",
                      "commonName",
                      "family",
                      "frenchCommonName",
                      "genus",
                      "order",
                      "scientificName",
                      "seq",
                      "species"
                  )
              ))
              
          })
