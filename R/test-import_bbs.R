context("import_bbs")

test_that("Function `import_bbs` successfully unzipped and imported all BBS state files data into the environment"
          {
              tempdir <- here::here("tests/temp-dir/")
              sn<-c("FLORIDA", "NebraskA")
                  
              # detele unzipped files to make sure function operates as expected.
             for(i in seq_along(sn)) if(file.exists(sn[i])) unlink(sn[i]) #state files
              if(file.exists(paste0(tempdir,"routes.csv"))) unlink(paste0(tempdir, "routes.csv"))     # routes.csv
              
              df <- import_bbs(data.dir  = tempdir, state.names = sn)
              
              expect_equal(length(unique(df$State)),2)
              
              expect_true(file.exists(paste0(tempdir, "routes.csv")))
              
          })

