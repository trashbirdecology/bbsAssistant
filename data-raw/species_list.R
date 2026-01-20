# Code to prepare species_list package data

devtools::load_all()
# grab most recent version of data and save the species list as a lookup table
df <- grab_bbs_data()
# df <- grab_bbs_data(sb_id = sb_id, bbs_dir = loc) ## need to update this to grab data if its already stored inside the local package
sl <- df[['species_list']]
sl$AOU <- as.integer(as.character(sl$AOU))

# For now, remove french common name because BBS provides non-ASCII
# bbs <- bbs |> select(-any_of("French_Common_Name"))


# ## Make some amendments for species to align with IBP AOU tax
# dup <- bbs[bbs$Genus == "Phalacrocorax",]
# dup$Genus <- "Nannopterum"
# bbs <- rbind(dup, bbs)

# Create new var for sciname
sl$Scientific_Name <- paste(sl$Genus,
                            sl$Species, sep=" ")

## Pull in the official AOU codes
fn=list.files( pattern="IBP-AOS", recursive = TRUE, full.names = TRUE) # from URL
aou <- read.csv(fn[1])[c("COMMONNAME", "SCINAME", "SPEC", "SPEC6")]
names(aou) <- c("English_Common_Name", "Scientific_Name", "AOU4", "AOU6")


species_list <- left_join(sl, aou)
# Merge them

# species_list <- dplyr::full_join(sl %>% dplyr::select(-AOU4, -AOU6), aou) #%>%
#   # secondary join by just sci name causes issues for ones that have multiple forms with same sci name
#   dplyr::full_join(aou %>% select(Scientific_Name, AOU4_2 = AOU4))%>%
#   dplyr::mutate(AOU4 = dplyr::coalesce(AOU4, AOU4_2))
# stopifnot(!any(is.na(species_list$AOU)))
#
#
# species_list <- dplyr::full_join(
#   species_list,
#   napop_sp %>% select(-c(Removal, Distance, Family), AOU4_2 = Species),
#   by = c(English_Common_Name = "Common_Name", "Scientific_Name")
# ) %>%
#   dplyr::mutate(AOU4 = dplyr::coalesce(AOU4, AOU4_2))

# sometimes scientific names are different ... need to be reconciled Using more
# recent IBP list will help but then won't work for older, probably need list
# that matches the data release year...

usethis::use_data(species_list, overwrite = TRUE)

