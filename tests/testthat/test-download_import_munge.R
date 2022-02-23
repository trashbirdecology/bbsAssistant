test_that("download_bbs_data, import_bbs_data, and munge_bbs_data functioning seemingly correctly", {

  sb_id = sb_items[which.max(sb_items$release_year), ]$sb_item
  tempdir <- tempdir()
  loc = download_bbs_data(sb_id, overwrite = TRUE, bbs_dir = tempdir)

  testthat::expect_true(tolower("50-stopdata.zip") %in% tolower(list.files(loc)))

  sb_id = sb_items$sb_item[sb_items$year_end == max(sb_items$year_end)]
  dat = import_bbs_data(bbs_dir = loc, sb_id = sb_id)

  # testthat::expect_length(dat, 7)
  testthat::expect_true(nrow(dat$observations) > 1)

    testthat::expect_message(munge_bbs_data(dat, states = "floriduh"))

    munged.default = munge_bbs_data(dat)
    testthat::expect_true(nrow(munged.default) >= 73000)


    munged.subset     = munge_bbs_data(
      bbs_list = dat,
      states = "florida",
      year.range = 1996,
      zero.fill = TRUE
    )
    testthat::expect_true(nrow(munged.subset) == 1)


    d1 = munge_bbs_data(dat, zero.fill = FALSE, species="house sparrow")
    d2 = munge_bbs_data(dat, zero.fill = TRUE, species="house sparrow")

    testthat::expect_true(nrow(d1) < nrow(d2))



  })
