## Parsing the complex XML data associated with the more recent BBS data releases is proving not worth the time, right now.
## Until I get some help making the region_codes import automatic, we are doing it by hand.
## This is the script for automating the creation of the dataset using
library(dplyr)
# Import the raw lookup table ------------------------------------------------------------------

## BBS codes (edited by JLB)
region_codes <- readr::read_csv("./data-raw/region_codes.csv", ) %>%
    dplyr::mutate(
        CountryNum = as.integer(CountryNum),
        StateNum   = as.integer(StateNum)
    ) %>%
  dplyr::select(-zip_states) %>%
## Remove Mexico Country -- not sure what this is.
filter(tolower(State) != "méxico country") %>%
  mutate(State=tolower(State))


## ISO CODES
iso.codes <- rnaturalearth::ne_states() %>%
  as.data.frame() %>%
  # tibble::column_to_rownames(name_en) %>%
  select(name_en, iso_3166_2, iso_a2, name_fr, name_es) %>%
  mutate(name_en=tolower(name_en))

# need to SLIGHTLY munge the ISO code name_en to match BBS
iso.codes$name_en[which(iso.codes$iso_3166_2=="US-DC")] <- "district of columbia"


### TEST
stopifnot(all(region_codes$State %in% iso.codes$name_en))

# Merge Lookup Tables -----------------------------------------------------

region_codes <- left_join(region_codes, iso.codes %>% rename(State=name_en))

# Write the data to package files as .RDA ---------------------------------
usethis::use_data(region_codes, overwrite=TRUE)


