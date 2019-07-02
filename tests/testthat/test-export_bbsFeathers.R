library(feather)

test_that("export_bbsFeathers saved to disk correctly, as feather file(s)", {
  expect_true(
     any(".feather" %in% list.files(bbsDir, full.names=TRUE))
  )
})
