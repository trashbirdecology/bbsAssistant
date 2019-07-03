<!-- PLEASE DO NOT EDIT README.md BY HAND. Please render README.rmd! -->

Function Manual
---------------

For function descriptions and examples please see the
[manual](/man/bbsAssistant_0.0.0.9000.pdf).

Contributions
-------------

If you would like to contribute, please submit a pr or email me
(jessicaleighburnett at gmail). I am especially interested in having
another set of eyes and hands to transfer and clean up the functions
listed in [Issue
1](https://github.com/TrashBirdEcology/bbsAssistant/issues/1).

Simple Runthrough of `bbsAssistant`
-----------------------------------

Installing package and loading dependencies
-------------------------------------------

``` r
# devtools::install_github("trashbirdecology/bbsAssistant", dependencies = TRUE)
library(bbsAssistant)
library(rvest)
library(gdata)
library(feather)
library(stringr)
library(readr)
library(magrittr)
library(glue)
library(dplyr)
```

Downloading the BBS data from USGS FTP
--------------------------------------

### Define and/or create local directories

This function will create, if it does not already exist, folder
**./bbsData/** within which to locally store BBS data and results.
**NOTE**: If the directory exists, it will not overwrite files. If the
bbs data already exists inside bbsDir, then we will create a logical to
NOT download the data (see below). If you wish to download more, or
overwrite existing data, please specify downloadBBSData=TRUE or remove
.zip files from **/bbsData/**.

``` r
# Create a directory to store and/or load the BBS data as feathers
bbsDir <- here::here("bbsData/")
dir.create(bbsDir)
```

### Download the BBS data, import, and save R objects to file.

If necessary, download all the state data. This takes 10-15 minutes, so
only run if you have not recently downloaded the BBS data.

``` r
# a. Load the regional .txt file from Patuxent's FTP server (you must be connected to the internet to perform this step)
regions <- get_regions()

# b. Create a series or one filenames for states, regions
regionFileName <- regions$zipFileName %>% na.omit()

# c. Let's limit the data downloaded, since downloading all regions is expensive. The state or province names are truncated, so in many cases we don't want to specify eg. 'Florida.zip'
regionFileName.use <- regionFileName[which(str_detect(regionFileName, "Flori")==TRUE)]

# d.  Download and unzip the BBS raw count data to a temporary location and import as R object
flBBS <- get_bbsData(file=regionFileName.use)
```

    ## [1] "Data were imported from the FTP server"

``` r
# e. Get the route information
routes <- get_routeInfo()

# e. Append route information to the count data
flBBS <- left_join(flBBS, routes)
glimpse(flBBS)
```

    ## Observations: 139,735
    ## Variables: 23
    ## $ routedataid       <int> 6234830, 6234830, 6234830, 6234830, 6234830, 6…
    ## $ countrynum        <int> 840, 840, 840, 840, 840, 840, 840, 840, 840, 8…
    ## $ statenum          <int> 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25…
    ## $ route             <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ rpid              <int> 101, 101, 101, 101, 101, 101, 101, 101, 101, 1…
    ## $ year              <int> 1967, 1967, 1967, 1967, 1967, 1967, 1967, 1967…
    ## $ aou               <int> 1840, 2000, 2010, 2890, 3100, 3131, 3160, 3390…
    ## $ count10           <dbl> 0, 0, 0, 12, 1, 0, 3, 0, 0, 0, 0, 0, 0, 2, 2, …
    ## $ count20           <dbl> 0, 0, 0, 22, 0, 0, 2, 0, 0, 0, 0, 0, 1, 7, 0, …
    ## $ count30           <dbl> 1, 0, 0, 7, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0…
    ## $ count40           <dbl> 30, 3, 1, 7, 0, 1, 2, 1, 0, 0, 0, 1, 0, 6, 2, …
    ## $ count50           <dbl> 5, 0, 0, 12, 0, 0, 0, 0, 1, 0, 0, 0, 2, 5, 1, …
    ## $ stoptotal         <dbl> 3, 1, 1, 37, 1, 1, 7, 1, 1, 1, 1, 1, 2, 11, 5,…
    ## $ speciestotal      <dbl> 36, 3, 1, 60, 1, 1, 7, 1, 1, 1, 1, 1, 3, 20, 5…
    ## $ routeID           <chr> "25 1", "25 1", "25 1", "25 1", "25 1", "25 1"…
    ## $ routename         <fct> OAK GROVE, OAK GROVE, OAK GROVE, OAK GROVE, OA…
    ## $ active            <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
    ## $ latitude          <dbl> 30.92918, 30.92918, 30.92918, 30.92918, 30.929…
    ## $ longitude         <dbl> -87.40794, -87.40794, -87.40794, -87.40794, -8…
    ## $ stratum           <int> 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4…
    ## $ bcr               <int> 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27…
    ## $ routetypeid       <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ routetypedetailid <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…

``` r
# f. Save the unzipped files to disk.
export_bbsFeathers(dataIn = flBBS,
                newDir  = bbsDir,
                filename = regionFileName.use)
```

If the BBS data was downloaded previously and saved as .feather, we can
import it using `import_bbsFeathers`. The code below is particularly
useful if you are importing multiple files…

``` r
feathers <- NULL
featherNames <- list.files(bbsDir, pattern = ".feather")
featherNames <- str_c("/", featherNames) #add separator
for (i in 1:length(featherNames)) {
  feather <- NULL
  feather <- import_bbsFeathers(newDir  = bbsDir,
                              filename = featherNames[i])
  feathers <- rbind(feathers, feather)
  rm(feather)
}

# you will notice the imported data slightly differs from the original bbs data in that # cols is far fewer
ncol(feathers); ncol(flBBS)
```

    ## [1] 9

    ## [1] 23

``` r
# for now, let's just stick with the flBBS data frame. 
rm(feathers) # remove feathers from file
```

If you wish to download and/or import ALL the data, you might choose to
do so in a loop. Note: this is expensive! The following are not run in
this example.

``` r
# Throw a warning if files exist
    if(length(list.files(bbsDir, pattern = "*.feather")) > 0 ){
        downloadBBSData = FALSE
    }else(
        {dir.create(bbsDir)
        downloadBBSData = TRUE}
        )
## Download ALL the regions of BBS data
if(downloadBBSData==TRUE){
for(i in 1:length(regionFileName)){
        bbsData <-  import_bbsData(
            # arguments for get_bbsData()
            file = regionFileName[i],
            dir =  "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/States/",
            year = NULL,
            aou = NULL,
            countrynum = NULL,
            states = NULL,
            #  arguments for get_routeInfo():
            routesFile = "routes.zip",
            routesDir =  "ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/",
            RouteTypeID = 1,
            # one or more of c(1,2,3)
            Stratum = NULL,
            BCR = NULL
        )
# d. Save the unzipped files to disk.
export_bbsFeathers(dataIn  = bbsData,
                newDir  = bbsDir,
                filename = regionFileName[i])
# e. Clear object from memory
rm(bbsData)
} # end section I. loop
}else(message(paste0("NOT DOWNLOADING BBS DATA. If you wish to download the BBS data, please remove files from directory: ",bbsDir))) # end if-else to download the data
```

Or import a lot of data files.

``` r
feathers <- NULL
featherNames <- list.files(bbsDir, pattern = ".feather")
featherNames <- str_c("/", featherNames) #add separator
for (i in 1:length(featherNames)) {
  feather <- NULL
  feather <- import_bbsFeathers(newDir  = bbsDir,
                              filename = featherNames[i]) 
  feathers <- rbind(feathers, feather)
  rm(feather)
 
}
```

Optional: Subset BBS data by taxonomic groupings, functional traits.
--------------------------------------------------------------------

### Subset individual species

First, let’s retrieve the species list from the BBS FTP server.

``` r
spp <- get_speciesList()
glimpse(spp)
```

    ## Observations: 750
    ## Variables: 9
    ## $ seq              <dbl> 6, 7, 8, 9, 10, 11, 13, 18, 19, 21, 22, 23, 24,…
    ## $ aou              <dbl> 1770, 1780, 1760, 1690, 1691, 1700, 1710, 1730,…
    ## $ commonName       <chr> "Black-bellied Whistling-Duck", "Fulvous Whistl…
    ## $ frenchCommonName <chr> "Dendrocygne à ventre noir", "Dendrocygne fauve…
    ## $ scientificName   <chr> "Dendrocygna autumnalis", "Dendrocygna bicolor"…
    ## $ order            <chr> "Anseriformes", "Anseriformes", "Anseriformes",…
    ## $ family           <chr> "Anatidae", "Anatidae", "Anatidae", "Anatidae",…
    ## $ genus            <chr> "Dendrocygna", "Dendrocygna", "Anser", "Anser",…
    ## $ species          <chr> "autumnalis", "bicolor", "canagicus", "caerules…

``` r
# This data frame contains common and scientific names, AOU numbers, taxonomic designations, and a taxonomic order (seq) for convenient sorting.
```

We can sort by AOU \# (e.g. House Sparrow aou = 06882)

``` r
subset_speciesList(myData = flBBS, aou.ind = 06882) %>% glimpse()
```

    ## Observations: 138,393
    ## Variables: 23
    ## $ routedataid       <int> 6234830, 6234830, 6234830, 6234830, 6234830, 6…
    ## $ countrynum        <int> 840, 840, 840, 840, 840, 840, 840, 840, 840, 8…
    ## $ statenum          <int> 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25…
    ## $ route             <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ rpid              <int> 101, 101, 101, 101, 101, 101, 101, 101, 101, 1…
    ## $ year              <int> 1967, 1967, 1967, 1967, 1967, 1967, 1967, 1967…
    ## $ aou               <int> 1840, 2000, 2010, 2890, 3100, 3131, 3160, 3390…
    ## $ count10           <dbl> 0, 0, 0, 12, 1, 0, 3, 0, 0, 0, 0, 0, 0, 2, 2, …
    ## $ count20           <dbl> 0, 0, 0, 22, 0, 0, 2, 0, 0, 0, 0, 0, 1, 7, 0, …
    ## $ count30           <dbl> 1, 0, 0, 7, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0…
    ## $ count40           <dbl> 30, 3, 1, 7, 0, 1, 2, 1, 0, 0, 0, 1, 0, 6, 2, …
    ## $ count50           <dbl> 5, 0, 0, 12, 0, 0, 0, 0, 1, 0, 0, 0, 2, 5, 1, …
    ## $ stoptotal         <dbl> 3, 1, 1, 37, 1, 1, 7, 1, 1, 1, 1, 1, 2, 11, 5,…
    ## $ speciestotal      <dbl> 36, 3, 1, 60, 1, 1, 7, 1, 1, 1, 1, 1, 3, 20, 5…
    ## $ routeID           <chr> "25 1", "25 1", "25 1", "25 1", "25 1", "25 1"…
    ## $ routename         <fct> OAK GROVE, OAK GROVE, OAK GROVE, OAK GROVE, OA…
    ## $ active            <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
    ## $ latitude          <dbl> 30.92918, 30.92918, 30.92918, 30.92918, 30.929…
    ## $ longitude         <dbl> -87.40794, -87.40794, -87.40794, -87.40794, -8…
    ## $ stratum           <int> 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4…
    ## $ bcr               <int> 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27…
    ## $ routetypeid       <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ routetypedetailid <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…

We could merge the bbs count data with the species list to avoid having
to refer to AOU, then just subset using species name (e.g. ’House
Sparrow).

``` r
flBBS <- left_join(flBBS, spp)
flBBS %>% filter(commonName=="House Sparrow") %>% glimpse()
```

    ## Observations: 1,342
    ## Variables: 31
    ## $ routedataid       <int> 6234830, 6168506, 6170632, 6169702, 6174820, 6…
    ## $ countrynum        <int> 840, 840, 840, 840, 840, 840, 840, 840, 840, 8…
    ## $ statenum          <int> 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25…
    ## $ route             <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ rpid              <int> 101, 101, 101, 101, 101, 101, 101, 101, 101, 1…
    ## $ year              <int> 1967, 1969, 1970, 1971, 1972, 1973, 1974, 1975…
    ## $ aou               <dbl> 6882, 6882, 6882, 6882, 6882, 6882, 6882, 6882…
    ## $ count10           <dbl> 1, 0, 0, 1, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0…
    ## $ count20           <dbl> 3, 3, 5, 1, 3, 1, 0, 5, 0, 0, 5, 0, 1, 2, 0, 2…
    ## $ count30           <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
    ## $ count40           <dbl> 2, 0, 1, 8, 1, 2, 0, 3, 0, 0, 2, 4, 1, 1, 0, 1…
    ## $ count50           <dbl> 5, 4, 8, 8, 19, 4, 9, 5, 5, 1, 4, 0, 0, 6, 13,…
    ## $ stoptotal         <dbl> 8, 5, 7, 6, 8, 5, 5, 5, 3, 1, 4, 1, 2, 4, 2, 3…
    ## $ speciestotal      <dbl> 11, 7, 14, 18, 23, 7, 10, 13, 7, 1, 11, 4, 2, …
    ## $ routeID           <chr> "25 1", "25 1", "25 1", "25 1", "25 1", "25 1"…
    ## $ routename         <fct> OAK GROVE, OAK GROVE, OAK GROVE, OAK GROVE, OA…
    ## $ active            <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
    ## $ latitude          <dbl> 30.92918, 30.92918, 30.92918, 30.92918, 30.929…
    ## $ longitude         <dbl> -87.40794, -87.40794, -87.40794, -87.40794, -8…
    ## $ stratum           <int> 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4…
    ## $ bcr               <int> 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27…
    ## $ routetypeid       <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ routetypedetailid <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ seq               <dbl> 1199, 1199, 1199, 1199, 1199, 1199, 1199, 1199…
    ## $ commonName        <chr> "House Sparrow", "House Sparrow", "House Sparr…
    ## $ frenchCommonName  <chr> "Moineau domestique", "Moineau domestique", "M…
    ## $ scientificName    <chr> "Passer domesticus", "Passer domesticus", "Pas…
    ## $ order             <chr> "Passeriformes", "Passeriformes", "Passeriform…
    ## $ family            <chr> "Passeridae", "Passeridae", "Passeridae", "Pas…
    ## $ genus             <chr> "Passer", "Passer", "Passer", "Passer", "Passe…
    ## $ species           <chr> "domesticus", "domesticus", "domesticus", "dom…

We can also use the `subset_SpeciesList` as a convenient way to
**remove** taxonomic groups from the BBS data.

``` r
subset_speciesList(flBBS, fam.ind = "Passeridae") 
subset_speciesList(flBBS, fam.ind = c("Passeridae", "Parulidae")) 
```

Using web scraping to retrieve species trend estimates and regional credibility scores
--------------------------------------------------------------------------------------

Another great function of this package is the ability to retrieve data
credibility and species trend estimates from the BBS results using the
function `get_credibility_trends`. As an example, we retrieve the
credibility scores and species trend estimates for **House Sparrows in
Florida**.

``` r
# cred <- bbsAssistant::get_credibility_trends() # default here is Florida House Sparrows.
# glimpse(cred)
# 
# # credibility colors correspond with the color scheme used on the BBS results page
# cred %>% distinct(credibilityNumber, credibilityColor, credibilityClass)
# 
# # Trend estimates are also listed here for Florida House Sparrow population
# cred %>% 
#     filter(Species == "House Sparrow")
```

### Steps for obtaining argument ‘url’ in `get_credibility_trends`:

First, visit the USGS Patuxent Wildlife Research Center’s [website for
BBS results](https://www.mbr-pwrc.usgs.gov/) Online
<a href="https://www.mbr-pwrc.usgs.gov/" class="uri">https://www.mbr-pwrc.usgs.gov/</a>.

Next, enable the drop-down **Survey Results**, and choose **Trend
Estimates (by region)** (left) and choose the desired region
(e.g. Florida):

<img src="/images/regcred_select_trendests_byregion.png" width="300" /><img src="/images/regcred_select_fl.png" width="300" />

Finally, copy the URL address for the page including the results and
credibility measures (e.g. Florida):

<img src="/images/regcred_fl_ex.png" width="600" />
