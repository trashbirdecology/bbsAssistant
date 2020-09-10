test_that("`get_bbs_data` should run without arguments specified", {
  devtools::load_all()
  list <- get_bbs_data() 

  expect_true(is.list(list))
  expect_failure(expect_false(is.list(list)))
    
})
