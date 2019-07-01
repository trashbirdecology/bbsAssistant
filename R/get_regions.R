#' @title Get the list of available data regions from the BBS website 
#' @description  Read in list of regions (State/Prov/TerrName), from RegionCodes.txt, and then extract list of where the 10-stop data is kept
#' @param source The website or location of the BBS data files.  
#' @param bbsDir The location of the local folder containing the bbs raw data. If this folder DNE, a new folder will be created in the working directory.
#' @export get_regions
get_regions <-
    function(
        source = "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/",
             ZipFiles = TRUE, 
             bbsDir = NULL
        ) {

        if(is.null(bbsDir)) {
            bbsDir <- here::here("bbsData")
            dir.create(bbsDir)
        } # end bbsDir creation             
        
File <- paste0(source, "RegionCodes.txt")
# Directory for codes
codesDir <- paste0(bbsDir, "/codes")
dir.create(codesDir)
        
# Download regionCodes.txt, a file containing a list of regional codes
download.file(url = File,
                      destfile = paste0(codesDir, "/RegionCodes.txt"))

# Read in the codes
CountryCodes <- readr::read_table(File, skip = 4,  col_names = F)[1:3, ]

# FIX THE column names ## WOULD LIKE A BETTER SOLUTION
colnames(CountryCodes) <- c("countryNum", "countryName")
        
# Read in the table of regions from file
RegionCodes <- readr::read_table(File, 
                                 skip = 11,
                                 col_names = FALSE)

# Fix column names. ## WOULD LIKE A BETTER SOLUTION
colnames(RegionCodes) <-
            c('countryNum',   'regionCode' , 'stateName')
        
# Get zipfile names
File <- paste0(source, "README.txt")
codesDir <- paste0(bbsDir,"/codes")
dir.create(codesDir)

# Download regionCodes.txt
        download.file(url = File,
                      destfile = paste0(codesDir, "/README.txt"))

readme.all = read.table(
            paste0(codesDir, "/README.txt"),
            sep = "\n",
            fileEncoding = 'Latin1',
            ## WOULD LIKE A BETTER SOLUTION THAN SKIPPING X LINES
               skip = 168
        ) %>% as_tibble()


## WOULD LIKE A BETTER SOLUTION THAN SKIPPING X LINES
readme.all = readme.all[1:62, ]
        
zipf = readme.all %>%
            mutate(V1 =
                       stringr::str_replace(V1,"Comma Delimited","")) %>%
            mutate(zipFileName =
                       stringr::word(V1, 1)) %>%
            mutate(stateName = str_squish(
                toupper(stringr::word(V1, 2:3, -1)))) %>%
            dplyr::select(zipFileName, stateName)
        
RegionCodes <-
    right_join(RegionCodes %>%  filter(countryNum != 484) %>%
                   mutate(stateName = toupper(stateName)),
               zipf)

## Returns a data frame with country code (#), state number (#), state/region name (alpha), and filename
return(RegionCodes)
        
    }

