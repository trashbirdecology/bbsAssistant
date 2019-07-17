context("get-routeInfo")


test_that("object 'routeDat' contains only two countries", {
    skip_on_travis()
    routeDat <- get_routeInfo()
    expect_equal(length(unique(routeDat$countrynum)), 2)
})

test_that(" routeDat$statenum == integer", {
    testthat::skip_on_travis()
    testthat::skip_if_offline()
    
    if(!exists("routeDat"))   routeDat <- get_routeInfo()
    expect_true(is.integer(routeDat$statenum))
})

test_that(" routeDat$route == integer", {
    testthat::skip_on_travis()
    testthat::skip_if_offline()
    if(!exists("routeDat"))   routeDat <- get_routeInfo()
    expect_true(is.integer(routeDat$route))
})

test_that(" routeDat$latitude == numeric", {
    testthat::skip_on_travis()
    testthat::skip_if_offline()
    if(!exists("routeDat"))   routeDat <- get_routeInfo()
    expect_true(is.numeric(routeDat$latitude))
})

test_that(" routeDat$longitude == numeric", {
    testthat::skip_on_travis()
    testthat::skip_if_offline()
    if(!exists("routeDat"))   routeDat <- get_routeInfo()
    expect_true(is.numeric(routeDat$longitude))
})

