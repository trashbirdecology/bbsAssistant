context("download_bbs")

test_that("Expect at least 62 .zip files to be downloaded via FTP"
          {
              testthat::skip_on_travis()
              testthat::skip_if_offline()
           
                 
              tempdir <- here::here("tests/temp-dir/")
              
              # Delete the tempdir to ensure the menu in `download_bbs` is not triggered.
              if(dir.exists(tempdir)) unlink(tempdir, recursive = TRUE)                  
              # create dir...
              dir.create(tempdir)
              
              # download two state files
              download_bbs(data.dir = tempdir, state.names = c("FloriDa", "NebrASKA"))
              files <- list.files(tempdir)
              expect_true(length(files)==2, label = "Number of downloaded state files using function download_bbs does not equal 62. Please check to see if PWRC updated the files...")
              
              })

