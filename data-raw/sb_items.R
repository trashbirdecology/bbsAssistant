## code to prepare `sb_items` dataset goes here
library(dplyr)
sb_items <-
  structure(
    list(
      sb_parent = c(
        "52b1dfa8e4b0d9b325230cd9",
        "52b1dfa8e4b0d9b325230cd9",
        "52b1dfa8e4b0d9b325230cd9",
        "52b1dfa8e4b0d9b325230cd9",
        "52b1dfa8e4b0d9b325230cd9",
        "5ea835e082cefae35a1fada7",
        "5ea835e082cefae35a1fada7"
      ),
      sb_item = c(
        "5ea04e9a82cefae35a129d65",
        "5d65256ae4b09b198a26c1d7",
        "5af45ebce4b0da30c1b448ca",
        "5cf7d4d5e4b07f02a7046479",
        "5d00efafe4b0573a18f5e03a",
        "5ea1e02c82cefae35a16ebc4",
        "5eab196d82cefae35a2254e0"
      ),
      sb_title = c(
        "2020 Release - North American Breeding Bird Survey Dataset (1966-2019)",
        "2019 Release - North American Breeding Bird Survey Dataset (1966-2018)",
        "2018 Release - North American Breeding Bird Survey Dataset (1966-2017)",
        "2017 Release - North American Breeding Bird Survey Dataset (1966-2016)",
        "2001-2016 Releases (legacy format) - North American Breeding Bird Survey Dataset",
        "The North American Breeding Bird Survey, Analysis Results 1966 - 2018",
        "The North American Breeding Bird Survey, Analysis Results 1966 - 2017"
      ),
      release_year = c(2020, 2019, 2018, 2017, 2016, 2020, 2018),
      data_type = c(
        "observations",
        "observations",
        "observations",
        "observations",
        "observations",
        "usgs_results",
        "usgs_results"
      ),
      year_start = c(1966, 1966, 1966, 1966, 1966, 1966, 1966),
      year_end = c(2019, 2018, 2017, 2016, 2015, 2018, 2017),
      legacy_format = c("n", "n", "n", "n", "y", NA, NA),
      sb_link = c(
        "sciencebase.gov/catalog/item/5ea04e9a82cefae35a129d65",
        "sciencebase.gov/catalog/item/5d65256ae4b09b198a26c1d7",
        "sciencebase.gov/catalog/item/5af45ebce4b0da30c1b448ca",
        "sciencebase.gov/catalog/item/5cf7d4d5e4b07f02a7046479",
        "sciencebase.gov/catalog/item/5d00efafe4b0573a18f5e03a",
        "sciencebase.gov/catalog/item/5ea1e02c82cefae35a16ebc4",
        "sciencebase.gov/catalog/item/5eab196d82cefae35a2254e0"
      )
    ),
    row.names = c(NA,-7L),
    class = "data.frame"
  )

sb_items <-   sb_items %>%
  dplyr::mutate(
    release_year = as.integer(release_year),
    year_end = as.integer(year_end),
    year_start = as.integer(year_start)
  )

usethis::use_data(sb_items, overwrite = TRUE)
