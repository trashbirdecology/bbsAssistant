context("get-routeInfo")
library(testthat)

test_that("object 'routeDat' contains only two countries", {
  expect_equal(length(unique(routeDat$countrynum)), 2)
})

test_that(" routeDat$statenum == integer", {
    expect_true(is.integer(routeDat$statenum))
})

test_that(" routeDat$statenum == integer", {
    expect_true(is.integer(routeDat$statenum))
})

test_that(" routeDat$route == integer", {
    expect_true(is.integer(routeDat$route))
})

test_that(" routeDat$latitude == numeric", {
    expect_true(is.numeric(routeDat$latitude))
})

test_that(" routeDat$longitude == numeric", {
    expect_true(is.numeric(routeDat$longitude))
})
