# this is the code for munging the sb_items dataset (maintained by package maintainer, for now)

# Import the raw lookup table ------------------------------------------------------------------
sb_items <- readr::read_csv(here::here("/data-raw/sb_items.csv")) %>% 
    dplyr::mutate(
        release_year = as.integer(release_year), 
        year_start   = as.integer(year_start),
        year_end   = as.integer(year_end) 
    
    )

# Write the data to package files as .RDA ---------------------------------
usethis::use_data(sb_items, overwrite=TRUE)


