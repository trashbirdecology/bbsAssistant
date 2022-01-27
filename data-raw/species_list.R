# grab most recent version of data and save the species list as a lookup table
df <- bbsAssistant::grab_bbs_data() ## need to update this to grab data if its already stored inside the local package
bbs <- df[['species_list']]
bbs$AOU <- as.integer(as.character(bbs$AOU))

## Make some amendments for species of interest to align with IBP AOU tax
dup <- bbs[bbs$Genus == "Phalacrocorax",]
dup$Genus <- "Nannopterum"
bbs <- rbind(dup, bbs)

# Create new var for sciname
bbs$Scientific_Name <- paste(bbs$Genus,
                             bbs$Species,
      sep=" ")

## Pull in the official AOU codes
fn=list.files( pattern="IBP-AOS", recursive = TRUE, full.names = TRUE) # from URL
aou <- read.csv(fn)[c("COMMONNAME", "SCINAME", "SPEC", "SPEC6")]
names(aou) <- c("English_Common_Name", "Scientific_Name", "AOU4", "AOU6")

# Merge them
species_list <- merge(bbs, aou)
# stopifnot(!any(is.na(species_list$AOU)))


usethis::use_data(species_list, overwrite = TRUE)

