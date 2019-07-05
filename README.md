<!-- PLEASE DO NOT EDIT README.md BY HAND. Please render README.rmd! -->

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Travis build
status](https://travis-ci.org/trashbirdecology/bbsAssistant.svg?branch=master)](https://travis-ci.org/trashbirdecology/bbsAssistant)
[![Coverage
status](https://codecov.io/gh/trashbirdecology/bbsAssistant/master/graph/badge.svg)](https://codecov.io/github/trashbirdecology/bbsAssistant?branch=master)

Function Manual
===============

For function descriptions and examples please see the
[manual](/man/bbsAssistant_0.0.0.9000.pdf).

Contributions
=============

If you would like to contribute, please submit a pr or email
(jessicaleighburnett at gmail). I am especially interested in having
another set of eyes and hands to transfer and clean up the functions
listed in [Issue
1](https://github.com/TrashBirdEcology/bbsAssistant/issues/1).

Brief Overview of bbsAssistant Features
=======================================

Installing package and loading dependencies
-------------------------------------------

``` r
# devtools::install_github("trashbirdecology/bbsAssistant", dependencies = TRUE, force=FALSE)
library(bbsAssistant)
library(rvest)
library(gdata)
library(feather)
library(tidyverse)
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

We can subset by species AOU \# (e.g. House Sparrow aou = 06882)

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
flBBS %>% filter(commonName=="House Sparrow") %>% head(2)
```

    ##   routedataid countrynum statenum route rpid year  aou count10 count20
    ## 1     6234830        840       25     1  101 1967 6882       1       3
    ## 2     6168506        840       25     1  101 1969 6882       0       3
    ##   count30 count40 count50 stoptotal speciestotal routeID routename active
    ## 1       0       2       5         8           11    25 1 OAK GROVE      0
    ## 2       0       0       4         5            7    25 1 OAK GROVE      0
    ##   latitude longitude stratum bcr routetypeid routetypedetailid  seq
    ## 1 30.92918 -87.40794       4  27           1                 1 1199
    ## 2 30.92918 -87.40794       4  27           1                 1 1199
    ##      commonName   frenchCommonName    scientificName         order
    ## 1 House Sparrow Moineau domestique Passer domesticus Passeriformes
    ## 2 House Sparrow Moineau domestique Passer domesticus Passeriformes
    ##       family  genus    species
    ## 1 Passeridae Passer domesticus
    ## 2 Passeridae Passer domesticus

We can also use the `subset_SpeciesList` as a convenient way to
**remove** taxonomic groups from the BBS data.

``` r
subset_speciesList(flBBS, fam.ind = "Passeridae") 
# subset_speciesList(flBBS, fam.ind = c("Passeridae", "Parulidae")) # or remove multiple fams
```

Getting species trend estiamte and credibility measures
-------------------------------------------------------

There are two options for obtaining the species trends estimates and
credibility measures: 1) download the entire region-species csvs for
various anlaysis or 2) provide a URl to species- or region-specific
estimates for the 1966-2015 trend esimates. \#\#\# Option 1: Download
CSV for all species-region combinations The function
`get_analysis_results` allows you to specify an analysis type, and
upload all species-regions combination estimates or annual indices to
object.

Let’s look at Florida House Sparrow trend estimates for Florida:

``` r
results <- get_analysis_results(analysis = "trend.ests") # default here is to obtain the 1966-2015 species trend estimates
results %>% filter(Species.Name=="House Sparrow", Region.Code=="FLA") %>% glimpse()
```

    ## Observations: 1
    ## Variables: 14
    ## $ Regional.Credibility.Measure                    <fct> G
    ## $ Sample.Size.Indicator                           <fct> G
    ## $ Precision.Indicator                             <fct> G
    ## $ Relative.Abundance.Indicator                    <fct> G
    ## $ AOU.Number                                      <int> 6882
    ## $ Region.Code                                     <fct> FLA
    ## $ Species.Name                                    <fct> House Sparrow
    ## $ Region                                          <fct> Florida
    ## $ Sample.Size                                     <int> 83
    ## $ X1966.2015.Trend.Estimates                      <dbl> -7.08
    ## $ X1966.2015.Credible.Interval.for.Trend.Estimate <fct> "(  -7.99,  -6.1…
    ## $ X.2005.2015.Trend.Estimates.                    <fct> -8.25
    ## $ X2005.2015.Credible.Interval.for.Trend.Estimate <fct> "( -11.30,  -5.2…
    ## $ X.Relative.Abundance.                           <dbl> 6.44

Let’s look at Florida House Sparrow annual trend estimates for Florida
1966-2016 analysis:

``` r
results <- get_analysis_results(analysis = "annual.inds.2016") # default here is to obtain the 1966-2015 species trend estimates
results %>% filter(AOU.Number=='s06882',
                   Region.Code=="S05") -> temp

ggplot(temp,aes(Year, Annual.Index))+
    geom_point()
```

![](README_files/figure-markdown_github/get_analysis_results2-1.png)

### Options 2: Using web scraping to retrieve region-specific estiamtes

Another useful feature of this package is the ability to retrieve data
credibility and species trend estimates from the BBS results using the
function `get_credibility_trends`. This function allows the user to
input a url to the region- or species-specific results page (see
instructions below), as opposed to using function
`get_analysis_results`. As an example, we retrieve the credibility
scores and species trend estimates for **House Sparrows in Florida**.

``` r
cred <- get_credibility_trends() # default here is Florida House Sparrows.
glimpse(cred)
```

    ## Observations: 135
    ## Variables: 12
    ## $ Species           <chr> "Pied-billed Grebe", "Herring Gull", "Ring-bil…
    ## $ N                 <int> 35, 8, 18, 48, 6, 17, 20, 12, 43, 17, 75, 71, …
    ## $ Trend_1966_2015   <dbl> -6.13, -2.74, 2.17, -1.96, 6.52, 4.28, -4.27, …
    ## $ CI_2.5_1966_2015  <chr> "-9.78", "-9.59", "-3.65", "-4.20", "-4.98", "…
    ## $ CI_97.5_1966_2015 <chr> "-2.32", "4.02", "8.87", "0.35", "19.72", "10.…
    ## $ Trend_2005_2015   <dbl> -12.97, 6.43, 5.03, -1.73, 7.66, 7.55, -3.11, …
    ## $ CI_2.5_2005_2015  <chr> "-26.53", "-11.42", "-11.36", "-5.81", "-13.28…
    ## $ CI_97.5_2005_2015 <chr> "-0.14", "24.99", "25.80", "2.18", "38.90", "3…
    ## $ RA                <dbl> 0.06, 0.05, 0.18, 217.08, 0.03, 0.04, 0.88, 0.…
    ## $ credibilityNumber <chr> "2", "2", "2", "0", "2", "2", "1", "2", "0", "…
    ## $ credibilityColor  <fct> Red, Red, Red, Blue, Red, Red, Yellow, Red, Bl…
    ## $ credibilityClass  <fct> important_deficiency, important_deficiency, im…

``` r
# credibility colors correspond with the color scheme used on the BBS results page
cred %>% distinct(credibilityNumber, credibilityColor, credibilityClass)
```

    ##   credibilityNumber credibilityColor     credibilityClass
    ## 1                 2              Red important_deficiency
    ## 2                 0             Blue        no_deficiency
    ## 3                 1           Yellow           deficiency

``` r
# Trend estimates are also listed here for Florida House Sparrow population
cred %>%
    filter(Species == "House Sparrow")
```

    ##         Species  N Trend_1966_2015 CI_2.5_1966_2015 CI_97.5_1966_2015
    ## 1 House Sparrow 83           -7.08            -7.99             -6.10
    ##   Trend_2005_2015 CI_2.5_2005_2015 CI_97.5_2005_2015   RA
    ## 1           -8.25           -11.30             -5.28 6.44
    ##   credibilityNumber credibilityColor credibilityClass
    ## 1                 0             Blue    no_deficiency

#### Steps for obtaining argument ‘url’ in `get_credibility_trends`:

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
