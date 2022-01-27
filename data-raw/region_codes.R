## Parsing the complex XML data associated with the more recent BBS data releases is proving not worth the time, right now.
## Until I get some help making the region_codes import automatic, we are doing it by hand.
## This is the script for automating the creation of the dataset using

## Not sure why but when this code to produce region_codes runs during cmd check it fails.
## Therefore, will silence the code here and require user to re-run when updates necessary.... ugh.

# BBS codes (edited by JLB)
{bbs_codes <- structure(list(CountryNum = c(484, 484, 484, 484, 484, 484, 484,
                                              484, 484, 484, 484, 484, 484, 484, 484, 484, 484, 484, 484, 484,
                                              484, 484, 484, 484, 484, 484, 484, 484, 484, 484, 484, 484, 484,
                                              840, 840, 124, 840, 840, 124, 840, 840, 840, 840, 840, 840, 840,
                                              840, 840, 840, 840, 840, 840, 840, 840, 124, 840, 840, 840, 840,
                                              840, 840, 840, 840, 840, 124, 840, 840, 840, 840, 124, 840, 840,
                                              124, 124, 124, 840, 840, 124, 840, 840, 124, 840, 124, 840, 124,
                                              840, 840, 840, 840, 840, 840, 840, 840, 840, 840, 840, 124),
                               StateNum = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
                                            15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
                                            30, 31, 32, 48, 2, 3, 4, 6, 7, 11, 14, 17, 18, 21, 22, 25,
                                            27, 33, 34, 35, 36, 38, 39, 42, 44, 45, 46, 47, 49, 50, 51,
                                            52, 53, 54, 55, 56, 58, 59, 60, 61, 57, 63, 64, 43, 65, 62,
                                            66, 67, 68, 69, 72, 75, 74, 76, 77, 79, 80, 81, 82, 83, 85,
                                            87, 88, 89, 90, 91, 92, 93), State = c("Aguascalientes",
                                                                                   "Baja California", "Baja California Sur", "Campeche", "Chiapas",
                                                                                   "Chihuahua", "Coahuila", "Colima", "Mexico City", "Durango",
                                                                                   "Guanajuato", "Guerrero", "Hidalgo", "Jalisco", "México",
                                                                                   "Michoacán", "Morelos", "Nayarit", "Nuevo León", "Oaxaca",
                                                                                   "Puebla", "Querétaro", "Quintana Roo", "San Luis Potosí",
                                                                                   "Sinaloa", "Sonora", "Tabasco", "Tamaulipas", "Tlaxcala",
                                                                                   "Veracruz", "Yucatán", "Zacatecas", "México Country", "ALABAMA",
                                                                                   "ALASKA", "Alberta", "ARIZONA", "ARKANSAS", "British Columbia",
                                                                                   "CALIFORNIA", "COLORADO", "CONNECTICUT", "DELAWARE", "District of Columbia",
                                                                                   "FLORIDA", "GEORGIA", "IDAHO", "ILLINOIS", "INDIANA", "IOWA",
                                                                                   "KANSAS", "KENTUCKY", "LOUISIANA", "MAINE", "Manitoba", "MARYLAND",
                                                                                   "MASSACHUSETTS", "MICHIGAN", "MINNESOTA", "MISSISSIPPI",
                                                                                   "MISSOURI", "MONTANA", "NEBRASKA", "NEVADA", "New Brunswick",
                                                                                   "NEW HAMPSHIRE", "NEW JERSEY", "NEW MEXICO", "NEW YORK",
                                                                                   "Newfoundland and Labrador", "NORTH CAROLINA", "NORTH DAKOTA",
                                                                                   "Northwest Territories", "Nova Scotia", "Nunavut", "OHIO",
                                                                                   "OKLAHOMA", "Ontario", "OREGON", "PENNSYLVANIA", "Prince Edward Island",
                                                                                   "PUERTO RICO", "Quebec", "RHODE ISLAND", "Saskatchewan",
                                                                                   "SOUTH CAROLINA", "SOUTH DAKOTA", "TENNESSEE", "TEXAS", "UTAH",
                                                                                   "VERMONT", "VIRGINIA", "WASHINGTON", "WEST VIRGINIA", "WISCONSIN",
                                                                                   "WYOMING", "Yukon"), zip_states = c(NA, NA, NA, NA, NA, NA,
                                                                                                                       NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
                                                                                                                       NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "Alabama.zip",
                                                                                                                       "Alaska.zip", "Alberta.zip", "Arizona.zip", "Arkansa.zip",
                                                                                                                       "BritCol.zip", "Califor.zip", "Colorad.zip", "Connect.zip",
                                                                                                                       "Delawar.zip", NA, "Florida.zip", "Georgia.zip", "Idaho.zip",
                                                                                                                       "Illinoi.zip", "Indiana.zip", "Iowa.zip", "Kansas.zip", "Kentuck.zip",
                                                                                                                       "Louisia.zip", "Maine.zip", "Manitob.zip", "Marylan.zip",
                                                                                                                       "Massach.zip", "Michiga.zip", "Minneso.zip", "Mississ.zip",
                                                                                                                       "Missour.zip", "Montana.zip", "Nebrask.zip", "Nevada.zip",
                                                                                                                       "NBrunsw.zip", "NHampsh.zip", "NJersey.zip", "NMexico.zip",
                                                                                                                       "NYork.zip", "Newfoun.zip", "NCaroli.zip", "NDakota.zip",
                                                                                                                       "NWTerri.zip", "NovaSco.zip", "Nunavut.zip", "Ohio.zip",
                                                                                                                       "Oklahom.zip", "Ontario.zip", "Oregon.zip", "Pennsyl.zip",
                                                                                                                       "PEI.zip", NA, "Quebec.zip", "RhodeIs.zip", "SCaroli.zip",
                                                                                                                       "SDakota.zip", "Saskatc.zip", "Tenness.zip", "Texas.zip",
                                                                                                                       "Utah.zip", "Vermont.zip", "Virgini.zip", "W_Virgi.zip",
                                                                                                                       "Washing.zip", "Wiscons.zip", "Wyoming.zip", "Yukon.zip")), row.names = c(NA,
                                                                                                                                                                                                 -97L), class = "data.frame")

}

bbs_codes <-
  bbs_codes %>%
  dplyr::mutate(
    CountryNum = as.integer(CountryNum),
    StateNum   = as.integer(StateNum)
  ) %>%
  dplyr::select(-zip_states) %>%
  ## Remove Mexico Country -- not sure what this is.
  dplyr::filter(tolower(State) != "méxico country") %>%
  dplyr::mutate(State=tolower(State))

## ISO CODES
iso.codes <- rnaturalearth::ne_states() %>%
  as.data.frame() %>%
  # tibble::column_to_rownames(name_en) %>%
  dplyr::select(name_en, iso_3166_2, iso_a2, name_fr, name_es) %>%
  dplyr::mutate(name_en=tolower(name_en))

# need to SLIGHTLY munge the ISO code name_en to match BBS
iso.codes$name_en[which(iso.codes$iso_3166_2=="US-DC")] <- "district of columbia"
iso.codes <- iso.codes %>% dplyr::rename(State=name_en)

## TEST
stopifnot(all(bbs_codes$State %in% iso.codes$name_en))

# Merge Lookup Tables
region_codes <- dplyr::left_join(bbs_codes, iso.codes)

# Write the data to package files as .RDA

usethis::use_data(region_codes, overwrite = TRUE)



