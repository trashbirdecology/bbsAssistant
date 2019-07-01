#' @title Get BBS region names for download route data.
#' @description  Read in list of regions (State/Prov/TerrName), from RegionCodes.txt, and then extract list of where the 10-stop data is kept
#' @export GetRegions
#' @param Dir location of the BBS files. Do not change unless they make major changes.
#' @param bbsDir Location of the folder containing bbs raw data (defined in runthrough.rmd)
#' @export GetRegions
GetRegions <-
    function(Dir = "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/",
             ZipFiles = TRUE, 
             bbsDir = NULL) {
browser()
# Code to use if following section is buggy.. -----------------------------
        if(is.null(bbsDir)) {
            bbsDir <- here::here("bbsData")
            dir.create(bbsDir)
        } # end bbsDir creation             
        # If the functiin doesn't work properly,  use this.
        File <- paste0(Dir, "RegionCodes.txt")
        newDir <- paste0(bbsDir, "/codes")
        dir.create(newDir)
        # Download regionCodes.txt
        download.file(url = File,
                      destfile = paste0(newDir, "/RegionCodes.txt"))
        CountryCodes <- read_table(File, skip = 4,  col_names = F)[1:3, ]
        colnames(CountryCodes) <- c("countryNum", "countryName")
        
        
        RegionCodes <- read_table(File, skip = 11,  col_names = F)
        colnames(RegionCodes) <-
            c('countryNum',   'regionCode' , 'stateName')
        
        # Get zipfile names
        File <- paste0(Dir, "README.txt")
        newDir <- paste0(bbsDir,"/codes")
        dir.create(newDir)
        # Download regionCodes.txt
        
        download.file(url = File,
                      destfile = paste0(newDir, "/README.txt"))
        readme.all = read.table(
            paste0(newDir, "/README.txt"),
            sep = "\n",
            fileEncoding = 'Latin1',
            skip = 168
        ) %>% as_tibble()
        
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
        
        # # Code I want to keep but is being buggy! ---------------------------------
        #             File <- paste0(Dir, "RegionCodes.txt")
        #             CountryWidths <- c(unlist(read.table(
        #                 File,
        #                 skip = 3,
        #                 nrows = 1,
        #                 stringsAsFactors = F
        #             )))
        #             # read in country metadata: use a connection to pass the encoding correctly
        #             con <- file(File, encoding = "Latin1")
        #             CountryCodes <-
        #                 read.fwf(
        #                     con,
        #                     widths = 1 + nchar(CountryWidths),
        #                     skip = 4,
        #                     n = 3,
        #                     header = F,
        #                     stringsAsFactors = F,
        #                     strip.white = TRUE
        #                 )
        #             # read column names
        #             names(CountryCodes) <- c(unlist(read.table(
        #                 File,
        #                 skip = 2,
        #                 nrows = 1,
        #                 stringsAsFactors = FALSE
        #             )))
        #
        #             # Read in state/province/terratory names and code
        #             RegionWidths <- c(unlist(
        #                 read.table(
        #                     File,
        #                     skip = 10,
        #                     nrows = 1,
        #                     stringsAsFactors = FALSE
        #                 )
        #             ))
        #             con <- file(File, encoding = "Latin1")
        #             RegionCodes <-
        #                 read.fwf(
        #                     con,
        #                     widths = 1 + nchar(RegionWidths),
        #                     skip = 11,
        #                     header = FALSE,
        #                     stringsAsFactors = FALSE,
        #                     strip.white = TRUE
        #                 )
        #
        #             # read column names
        #             names(RegionCodes) <- c(unlist(read.table(
        #                 File,
        #                 skip = 9,
        #                 nrows = 1,
        #                 stringsAsFactors = FALSE
        #             )))
        #
        #             RegionCodes$CountryName <- vapply(RegionCodes$countrynum,
        #                                               function(num, CCode) {
        #                                                   CCode$CountryName[num == CCode$CountryNum]
        #                                               }, FUN.VALUE = "character", CCode = CountryCodes)
        #
        #
        #            # GET ZIP FILE NAMES for when I am downloading from the FTP
        #         if (ZipFiles == TRUE) {
        #             readme.all <-
        #                 scan(
        #                     paste0(Dir, "README.txt"),
        #                     sep = "\n",
        #                     what = character(),
        #                     blank.lines.skip = FALSE,
        #                     fileEncoding = "Latin1"
        #                 )
        #             readme.all <- gsub("\t", "", readme.all)
        #             PrecedingLine <- grep("States Directory:", readme.all)
        #             EndLine <-
        #                 which(readme.all[PrecedingLine:length(readme.all)] == "")[1]
        #
        #             ZipF.tmp <-
        #                 strsplit(readme.all[PrecedingLine + (2:(EndLine - 2))], '[ ]{2,}')
        #             ZipF <-
        #                 data.frame(
        #                     State = unlist(lapply(ZipF.tmp, function(x)
        #                         x[3])),
        #                     File = unlist(lapply(ZipF.tmp, function(x)
        #                         x[1])),
        #                     stringsAsFactors = FALSE
        #                 )
        #
        #
        #
        #             RegionCodes$zipFileName <-
        #                 vapply(RegionCodes$`State/Prov/TerrName`,
        #                        function(Name, zipf) {
        #                            #    Name <- "Newfoundland and Labrador"
        #                            file <-
        #                                zipf$File[tolower(zipf$State) == tolower(Name)]
        #                            if (length(file) == 0) {
        #                                Which.file <- vapply(tolower(zipf$State), function(state)
        #                                    any(grepl(
        #                                        paste0("^", state), tolower(Name)
        #                                    )), FUN.VALUE = TRUE)
        #                                file <- zipf$File[Which.file]
        #                            }
        #                            if (length(file) == 0)
        #                                file <- as.character(NA)
        #                            file
        #                        }, FUN.VALUE = "character", zipf = ZipF)
        #         }
        #
        #
        #
        #         RegionCodes <- RegionCodes %>%
        #             dplyr::rename(
        #                 countryNum = countrynum,
        #                 regionCode = RegionCode,
        #                 countryName = CountryName,
        #                 stateName = `State/Prov/TerrName`
        #             )
        #
        
        # Return object -----------------------------------------------------------
        
        
        return(RegionCodes)
        
    }

GetRegions()
