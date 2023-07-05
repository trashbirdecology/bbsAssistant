# CANNOT RUN THESE TESTS ON CRAN B/C MEMORY LIMIT IS EXCEEDED
test_that(
  "download_bbs_data, import_bbs_data, and munge_bbs_data functioning seemingly correctly",
  {
    sb_id = sb_items[which.max(sb_items$release_year),]$sb_item
    tempdir <- tempdir()
    loc = download_bbs_data(sb_id, overwrite = TRUE, bbs_dir = tempdir)

    testthat::expect_true(tolower("50-stopdata.zip") %in% tolower(list.files(loc)))

    sb_id = sb_items$sb_item[sb_items$year_end == max(sb_items$year_end)]

    loc <- "C:\\Users\\endicotts\\Documents\\gitprojects\\ROFBirds\\analysis\\data\\raw_data\\bbs_2022"

    sp_list <- import_species_list(loc)

    dat = import_bbs_data(bbs_dir = loc, sb_id = sb_id)

    # testthat::expect_length(dat, 7)
    testthat::expect_true(nrow(dat$observations) > 1)

    munged.default = suppressWarnings(munge_bbs_data(bbs_list = dat)) ## suppress an internal warning about zero.filling data
    testthat::expect_true(nrow(munged.default) >= 3470000) # default SB ID as of 20220310 nrows == ~3.3M


    munged.subset     = munge_bbs_data(
      bbs_list = dat,
      states = "florida",
      species = "house sparrow",
      year.range = 2019,
      zero.fill = TRUE
    )
    testthat::expect_true(length(unique(munged.subset$StateNum)) == 1)
    testthat::expect_true(length(unique(munged.subset$AOU)) == 1)
    testthat::expect_true(unique(munged.subset$QualityCurrentID) == 1)
    testthat::expect_true(unique(munged.subset$RPID) == 101)


    d1 = munge_bbs_data(bbs_list = dat, zero.fill = FALSE, species = "house sparrow")
    d2 = munge_bbs_data(bbs_list = dat, zero.fill = TRUE,  species = "house sparrow")

    # should expect fewer observations in the non-zerofilled data because
    ## when zero.fill=FALSE, it is presence-only data
    testthat::expect_true(nrow(d1) < nrow(d2))

  }
)
