## Parsing the complex XML data associated with the more recent BBS data releases is proving not worth the time, right now. 
## Until I get some help making the region_codes import automatic, we are doing it by hand. 
## This is the script for automating the creation of the dataset using 

# Import the raw lookup table ------------------------------------------------------------------
region_codes <- readr::read_csv(here::here("/data-raw/region_codes.csv")) %>% 
    mutate(
        CountryNum = as.integer(CountryNum), 
        StateNum   = as.integer(StateNum)
    )


# Write the data to package files as .RDA ---------------------------------
usethis::use_data(region_codes, overwrite=TRUE)


