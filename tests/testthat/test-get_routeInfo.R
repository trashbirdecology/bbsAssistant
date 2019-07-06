context("get-routeInfo")

test_that("object 'routeDat' contains only two countries", {
    if(!exists('routeDat')) routeDat <- get_routeInfo()
    expect_equal(length(unique(routeDat$countrynum)), 2)
})



test_that(" routeDat$statenum == integer", {
    if(!exists('routeDat')) routeDat <- get_routeInfo()
    expect_true(is.integer(routeDat$statenum))
})

test_that(" routeDat$route == integer", {
    if(!exists('routeDat')) routeDat <- get_routeInfo()
    expect_true(is.integer(routeDat$route))
})

test_that(" routeDat$latitude == numeric", {
    if(!exists('routeDat')) routeDat <- get_routeInfo()
    expect_true(is.numeric(routeDat$latitude))
})

test_that(" routeDat$longitude == numeric", {
    if(!exists('routeDat')) routeDat <- get_routeInfo()
    expect_true(is.numeric(routeDat$longitude))
})
