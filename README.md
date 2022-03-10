**bbsAssistant**: An R package for Downloading and Handling Data and
Information from the North American Breeding Bird Survey (BBS)
================
Last updated: 2022-03-10

<!-- badges: start -->

[![DOI](https://joss.theoj.org/papers/10.21105/joss.01768/status.svg?style=flat-square&logo=appveyor)](https://doi.org/10.21105/joss.01768)
![usgs](https://img.shields.io/badge/USGS-Core-lightgrey.svg?style=flat-square&logo=appveyor)
[![R build
status](https://github.com/trashbirdecology/bbsAssistant/workflows/R-CMD-check/badge.svg?style=flat-square&logo=appveyor)](https://github.com/trashbirdecology/bbsAssistant/actions)
[![License:
CC0](https://img.shields.io/badge/License-CC0%201.0-lightgrey.svg?style=flat-square&logo=appveyor)](https://creativecommons.org/publicdomain/zero/1.0/)
[![Contributors](https://img.shields.io/badge/all_contributors-8-lightgrey.svg?style=flat-square&logo=appveyor)](#contributors)
[![R-CMD-check](https://github.com/trashbirdecology/bbsAssistant/workflows/R-CMD-check/badge.svg)](https://github.com/trashbirdecology/bbsAssistant/actions)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.htm#stablel)
<!-- badges: end -->
<img src=".github/figures/logo.png" align="right" height=140/>

## About

This repository contains the development version of **bbsAssistant**.
Please submit [Issues
here](https://github.com/TrashBirdEcology/bbsAssistant/issues).

This package contains functions for downloading, importing, and munging
the official releases of the [North American Breeding Bird
Survey](https://www.pwrc.usgs.gov/bbs/) (BBS) data [(retrieved from USGS
ScienceBase repository)](https://www.sciencebase.gov/catalog) with the
help of package [sbtools](https://cran.r-project.org/package=sbtools).

<!-- ## Potential Future Developments -->
<!-- - [ ] Functions for creating presence/absence and count matrices for use in JAGS and beyond (see also: https://github.com/trashbirdecology/bbsebird/)  -->
<!-- - [ ] Spatial visualization tools -->
<!-- devtools::check(args = c("--no-examples", "--no-tests")) -->

## Quick Start

``` r
library(bbsAssistant)
# view functions and data in package bbsAssistant
# ls("package:bbsAssistant")
```

## Download, Unpack, and Import the Most Recent Dataset

``` r
bbs <- grab_bbs_data()
```

    ## bbs_dir not specified. bbs dataset will be saved to  data-in/5ea04e9a82cefae35a129d65

``` r
# Optional: specify `sb_id` as the USGS ScienceBase identifier for a specific data release. If sb_id is not supplied, will default to the most recent data release.
```

The object resulting from `bbsAssistant::import_bbs_data()` is a list
comprising the following elements:

``` r
names(bbs)
```

    ## [1] "observations" "routes"       "observers"    "weather"      "species_list"
    ## [6] "citation"     "vehicle_data" "data.dir"

## Filtering by State/Region

Filter the dataset `bbs` using your preferred method. A lookup table is
provided as a package dataset for filtering by country or state using
the BBS codes (see columns CountryNum, StateNum) or ISO alpha codes and
names (see columns iso_3155_2, iso_a2, name_fr, name_es):

``` r
head(bbsAssistant::region_codes, 3)
```

    ##   CountryNum StateNum               State iso_3166_2 iso_a2
    ## 1        484        1      aguascalientes     MX-AGU     MX
    ## 2        484        2     baja california     MX-BCN     MX
    ## 3        484        3 baja california sur     MX-BCS     MX
    ##                   name_fr             name_es
    ## 1          Aguascalientes      Aguascalientes
    ## 2        Basse-Californie     Baja California
    ## 3 Basse-Californie du Sud Baja California Sur

### Filter on species names

View the species lists for your particular dataset by calling:

``` r
head(bbs$species_list,3)
```

    ## # A tibble: 3 x 12
    ##   Seq     AOU English_Common_Name French_Common_N~ Spanish_Common_~ ORDER Family
    ##   <chr> <int> <chr>               <chr>            <chr>            <chr> <chr> 
    ## 1 6      1770 Black-bellied Whis~ "Dendrocygne \x~ Dendrocygna aut~ Anse~ Anati~
    ## 2 7      1780 Fulvous Whistling-~ "Dendrocygne fa~ Dendrocygna bic~ Anse~ Anati~
    ## 3 8      1760 Emperor Goose       "Oie empereur"   Anser canagicus  Anse~ Anati~
    ## # ... with 5 more variables: Genus <chr>, Species <chr>, Scientific_Name <chr>,
    ## #   AOU4 <chr>, AOU6 <chr>

or view the most recent species list (may be the same as yours..):

``` r
head(bbsAssistant::species_list,3)
```

Keep only *Passer domesticus*:

``` r
# grab the aou code for House Sparrow  using common name 
hosp.aou.code <- bbs$species_list$AOU[bbs$species_list$English_Common_Name=="House Sparrow"]
# or genus and species epithet
# hosp.aou.code <-
#   bbs$species_list$AOU[bbs$species_list$Genus == "Passer" &
#                          bbs$species_list$Species == "domesticus"]

# filter the observations along  BBS "AOU" code:
## note spelling but not capitalization matters. 
## can provide species arg as species' common or latin name(s) or as BBS "AOU" code(s)
hosp.df <- munge_bbs_data(bbs_list=bbs, species = hosp.aou.code)
```

    ## Creating a flat data frame as output object.

``` r
                          # species = c("House SPARROW", "passer Domesticus", hosp.aou.code)) 
```

## BBS Data Availability (including sb_id)

There are currently two primary products released from the USGS that are
derived from the annual BBS roadside surveys, the [observations
data](https://www.sciencebase.gov/catalog/item/52b1dfa8e4b0d9b325230cd9)
and the analysis results. The datasets (observations, results) are
permanently and publicly available at [USGS
ScienceBase](https://www.sciencebase.gov).

The most recent annual releases of the observations and results datasets
are stored as data objects in this package (see `data(bbs)`) will be
downloaded as the default in this package, but the user has the option
to specify historical dataset releases should they choose. Please see
the function `get_bbs_data()`.

A lookup table containing the available datasets (N = 7) and analysis
results will be regularly updated, and comprises the following entries:
<table class="table table-striped" style>
<caption>
List of datasets currently available for download at USGS ScienceBase.
Highlighted and bold row indicates the default BBS observations dataset
stored internally in the package.
</caption>
<thead>
<tr>
<th style="text-align:left;">
sb_title
</th>
<th style="text-align:right;">
release_year
</th>
<th style="text-align:left;">
data_type
</th>
<th style="text-align:right;">
year_start
</th>
<th style="text-align:right;">
year_end
</th>
<th style="text-align:left;">
sb_link
</th>
<th style="text-align:left;">
sb_item
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;width: 100em; font-weight: bold;background-color: yellow !important;">
2020 Release - North American Breeding Bird Survey Dataset (1966-2019)
</td>
<td style="text-align:right;font-weight: bold;background-color: yellow !important;">
2020
</td>
<td style="text-align:left;font-weight: bold;background-color: yellow !important;">
observations
</td>
<td style="text-align:right;font-weight: bold;background-color: yellow !important;">
1966
</td>
<td style="text-align:right;font-weight: bold;background-color: yellow !important;">
2019
</td>
<td style="text-align:left;font-weight: bold;background-color: yellow !important;">
sciencebase.gov/catalog/item/5ea04e9a82cefae35a129d65
</td>
<td style="text-align:left;font-weight: bold;background-color: yellow !important;">
5ea04e9a82cefae35a129d65
</td>
</tr>
<tr>
<td style="text-align:left;width: 100em; ">
2019 Release - North American Breeding Bird Survey Dataset (1966-2018)
</td>
<td style="text-align:right;">
2019
</td>
<td style="text-align:left;">
observations
</td>
<td style="text-align:right;">
1966
</td>
<td style="text-align:right;">
2018
</td>
<td style="text-align:left;">
sciencebase.gov/catalog/item/5d65256ae4b09b198a26c1d7
</td>
<td style="text-align:left;">
5d65256ae4b09b198a26c1d7
</td>
</tr>
<tr>
<td style="text-align:left;width: 100em; ">
2018 Release - North American Breeding Bird Survey Dataset (1966-2017)
</td>
<td style="text-align:right;">
2018
</td>
<td style="text-align:left;">
observations
</td>
<td style="text-align:right;">
1966
</td>
<td style="text-align:right;">
2017
</td>
<td style="text-align:left;">
sciencebase.gov/catalog/item/5af45ebce4b0da30c1b448ca
</td>
<td style="text-align:left;">
5af45ebce4b0da30c1b448ca
</td>
</tr>
<tr>
<td style="text-align:left;width: 100em; ">
2017 Release - North American Breeding Bird Survey Dataset (1966-2016)
</td>
<td style="text-align:right;">
2017
</td>
<td style="text-align:left;">
observations
</td>
<td style="text-align:right;">
1966
</td>
<td style="text-align:right;">
2016
</td>
<td style="text-align:left;">
sciencebase.gov/catalog/item/5cf7d4d5e4b07f02a7046479
</td>
<td style="text-align:left;">
5cf7d4d5e4b07f02a7046479
</td>
</tr>
<tr>
<td style="text-align:left;width: 100em; ">
2001-2016 Releases (legacy format) - North American Breeding Bird Survey
Dataset
</td>
<td style="text-align:right;">
2016
</td>
<td style="text-align:left;">
observations
</td>
<td style="text-align:right;">
1966
</td>
<td style="text-align:right;">
2015
</td>
<td style="text-align:left;">
sciencebase.gov/catalog/item/5d00efafe4b0573a18f5e03a
</td>
<td style="text-align:left;">
5d00efafe4b0573a18f5e03a
</td>
</tr>
<tr>
<td style="text-align:left;width: 100em; ">
The North American Breeding Bird Survey, Analysis Results 1966 - 2018
</td>
<td style="text-align:right;">
2020
</td>
<td style="text-align:left;">
usgs_results
</td>
<td style="text-align:right;">
1966
</td>
<td style="text-align:right;">
2018
</td>
<td style="text-align:left;">
sciencebase.gov/catalog/item/5ea1e02c82cefae35a16ebc4
</td>
<td style="text-align:left;">
5ea1e02c82cefae35a16ebc4
</td>
</tr>
<tr>
<td style="text-align:left;width: 100em; ">
The North American Breeding Bird Survey, Analysis Results 1966 - 2017
</td>
<td style="text-align:right;">
2018
</td>
<td style="text-align:left;">
usgs_results
</td>
<td style="text-align:right;">
1966
</td>
<td style="text-align:right;">
2017
</td>
<td style="text-align:left;">
sciencebase.gov/catalog/item/5eab196d82cefae35a2254e0
</td>
<td style="text-align:left;">
5eab196d82cefae35a2254e0
</td>
</tr>
</tbody>
</table>

## Citations

**For the BBS dataset and analysis results**, call
`citation("bbsAssistant")` or see library loading message.

**For general use of the R package bbsAssistant** and/or **companion
paper**:  
Burnett, J.L., Wszola, L., and Palomo-Muñoz, G. (2019). bbsAssistant: An
R package for downloading and handling data and information from the
North American Breeding Bird Survey: U.S. Geological Survey software
release, <https://doi.org/10.5066/P93W0EAW>. *or* Burnett, J.L., Wszola,
L., and Palomo-Muñoz, G. (2019). bbsAssistant: An R package for
downloading and handling data and information from the North American
Breeding Bird Survey. Journal of Open Source Software, 4(44), 1768,
<https://doi.org/10.21105/joss.01768>

## Contributing

## Code of Conduct

Please note that the bbsAssistant project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms. For
questions, comments, or issues, feel free to email the maintainer
[Jessica Burnett](mailto:jburnett@usgs.gov) or submit an
[Issue](https://github.com/TrashBirdEcology/bbsAssistant/issues)
(preferred).
