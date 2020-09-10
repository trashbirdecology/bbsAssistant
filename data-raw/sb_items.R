## code to prepare `sb_items` dataset goes here

sb_items <-
    readr::read_csv(here::here("/data-raw/sb_items.csv")) %>%
    mutate(
        release_year = as.integer(release_year),
        year_end = as.integer(year_end),
        year_start = as.integer(year_start)
    )

# Save to /data/ ---------------------------------------------------------------
usethis::use_data(sb_items, overwrite = TRUE)
