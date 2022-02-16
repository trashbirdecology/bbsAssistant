**bbsAssistant**: An R package for downloading and handling data and
information from the North American Breeding Bird Survey.
================
Last updated: 2022-02-16

<!-- badges: start -->

[![DOI](https://joss.theoj.org/papers/10.21105/joss.01768/status.svg?style=flat-square&logo=appveyor)](https://doi.org/10.21105/joss.01768)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-lightgrey.svg?style=flat-square&logo=appveyor)](https://www.tidyverse.org/lifecycle/#maturing)
![usgs](https://img.shields.io/badge/USGS-Core-lightgrey.svg?style=flat-square&logo=appveyor)
[![R build
status](https://github.com/trashbirdecology/bbsAssistant/workflows/R-CMD-check/badge.svg?style=flat-square&logo=appveyor)](https://github.com/trashbirdecology/bbsAssistant/actions)
[![License:
CC0](https://img.shields.io/badge/License-CC0%201.0-lightgrey.svg?style=flat-square&logo=appveyor)](http://creativecommons.org/publicdomain/zero/1.0/)
[![Contributors](https://img.shields.io/badge/all_contributors-8-lightgrey.svg?style=flat-square&logo=appveyor)](#contributors)
<!-- ![downloads](https://img.shields.io/github/downloads/trashbirdecology/bbsAssistant/total?style=flat-square&logo=appveyor) -->
<!-- ![dependencies](https://img.shields.io/librariesio/github/trashbirdecology/bbsassistant?style=flat-square&logo=appveyor) -->
<!-- [![Travis build status](https://travis-ci.org/trashbirdecology/bbsAssistant.svg?branch=main)](https://travis-ci.org/trashbirdecology/bbsAssistant) -->
[![R-CMD-check](https://github.com/trashbirdecology/bbsAssistant/workflows/R-CMD-check/badge.svg)](https://github.com/trashbirdecology/bbsAssistant/actions)
<!-- badges: end -->
<img src=".github/figures/logo.png" align="right" height=140/>

## About

This repository contains the development version of **bbsAssistant**.
Please submit [Issues
here](https://github.com/TrashBirdEcology/bbsAssistant/issues).

This package contains functions for downloading, importing, and (soon)
visualizing the annual USGS release of the [North American Breeding Bird
Survey](https://www.pwrc.usgs.gov/bbs/) (BBS) dataset [(retrieved from
USGS ScienceBase repository)](https://sciencebase.gov/).

## Quick Start

``` r
library(bbsAssistant)
# view functions and data in package bbsAssistant
# ls("package:bbsAssistant")
```

## Download, Unpack, and Import the Most Recent Dataset

``` r
bbs_list <- grab_bbs_data()
```

    ## bbs_dir not specified. bbs dataset will be saved to  data-in/5ea04e9a82cefae35a129d65

``` r
# Optional: specify `sb_id` as the USGS ScienceBase identifier for a specific data release. If sb_id is not supplied, will default to the most recent data release.
```

The object resulting from `bbsAssistant::import_bbs_data()` is a list
comprising the following elements:

``` r
names(bbs_list)
```

    ## [1] "observations" "routes"       "observers"    "weather"      "species_list"
    ## [6] "citation"     "vehicle_data" "data.dir"

## Filtering by State/Region

Filter the dataset `bbs` using your preferred method. A lookup table is
provided as a package dataset for filtering by country or state using
the BBS codes (see columns ‘CountryNum’ and ‘StateNum’) or ISO alpha
codes and names (see columns ‘iso_3155_2,’‘iso_a2,’‘name_fr,’‘name_es’):

``` r
bbsAssistant::region_codes
```

    ##    CountryNum StateNum                     State iso_3166_2 iso_a2
    ## 1         484        1            aguascalientes     MX-AGU     MX
    ## 2         484        2           baja california     MX-BCN     MX
    ## 3         484        3       baja california sur     MX-BCS     MX
    ## 4         484        4                  campeche     MX-CAM     MX
    ## 5         484        5                   chiapas     MX-CHP     MX
    ## 6         484        6                 chihuahua     MX-CHH     MX
    ## 7         484        7                  coahuila     MX-COA     MX
    ## 8         484        8                    colima     MX-COL     MX
    ## 9         484        9               mexico city     MX-DIF     MX
    ## 10        484       10                   durango     MX-DUR     MX
    ## 11        484       11                guanajuato     MX-GUA     MX
    ## 12        484       12                  guerrero     MX-GRO     MX
    ## 13        484       13                   hidalgo     MX-HID     MX
    ## 14        484       14                   jalisco     MX-JAL     MX
    ## 15        484       15                    méxico     MX-MEX     MX
    ## 16        484       16                 michoacán     MX-MIC     MX
    ## 17        484       17                   morelos     MX-MOR     MX
    ## 18        484       18                   nayarit     MX-NAY     MX
    ## 19        484       19                nuevo león     MX-NLE     MX
    ## 20        484       20                    oaxaca     MX-OAX     MX
    ## 21        484       21                    puebla     MX-PUE     MX
    ## 22        484       22                 querétaro     MX-QUE     MX
    ## 23        484       23              quintana roo     MX-ROO     MX
    ## 24        484       24           san luis potosí     MX-SLP     MX
    ## 25        484       25                   sinaloa     MX-SIN     MX
    ## 26        484       26                    sonora     MX-SON     MX
    ## 27        484       27                   tabasco     MX-TAB     MX
    ## 28        484       28                tamaulipas     MX-TAM     MX
    ## 29        484       29                  tlaxcala     MX-TLA     MX
    ## 30        484       30                  veracruz     MX-VER     MX
    ## 31        484       31                   yucatán     MX-YUC     MX
    ## 32        484       32                 zacatecas     MX-ZAC     MX
    ## 33        840        2                   alabama      US-AL     US
    ## 34        840        3                    alaska      US-AK     US
    ## 35        124        4                   alberta      CA-AB     CA
    ## 36        840        6                   arizona      US-AZ     US
    ## 37        840        7                  arkansas      US-AR     US
    ## 38        124       11          british columbia      CA-BC     CA
    ## 39        840       14                california      US-CA     US
    ## 40        840       17                  colorado      US-CO     US
    ## 41        840       18               connecticut      US-CT     US
    ## 42        840       21                  delaware      US-DE     US
    ## 43        840       22      district of columbia      US-DC     US
    ## 44        840       25                   florida      US-FL     US
    ## 45        840       27                   georgia      US-GA     US
    ## 46        840       33                     idaho      US-ID     US
    ## 47        840       34                  illinois      US-IL     US
    ## 48        840       35                   indiana      US-IN     US
    ## 49        840       36                      iowa      US-IA     US
    ## 50        840       38                    kansas      US-KS     US
    ## 51        840       39                  kentucky      US-KY     US
    ## 52        840       42                 louisiana      US-LA     US
    ## 53        840       44                     maine      US-ME     US
    ## 54        124       45                  manitoba      CA-MB     CA
    ## 55        840       46                  maryland      US-MD     US
    ## 56        840       47             massachusetts      US-MA     US
    ## 57        840       49                  michigan      US-MI     US
    ## 58        840       50                 minnesota      US-MN     US
    ## 59        840       51               mississippi      US-MS     US
    ## 60        840       52                  missouri      US-MO     US
    ## 61        840       53                   montana      US-MT     US
    ## 62        840       54                  nebraska      US-NE     US
    ## 63        840       55                    nevada      US-NV     US
    ## 64        124       56             new brunswick      CA-NB     CA
    ## 65        840       58             new hampshire      US-NH     US
    ## 66        840       59                new jersey      US-NJ     US
    ## 67        840       60                new mexico      US-NM     US
    ## 68        840       61                  new york      US-NY     US
    ## 69        124       57 newfoundland and labrador      CA-NL     CA
    ## 70        840       63            north carolina      US-NC     US
    ## 71        840       64              north dakota      US-ND     US
    ## 72        124       43     northwest territories      CA-NT     CA
    ## 73        124       65               nova scotia      CA-NS     CA
    ## 74        124       62                   nunavut      CA-NU     CA
    ## 75        840       66                      ohio      US-OH     US
    ## 76        840       67                  oklahoma      US-OK     US
    ## 77        124       68                   ontario      CA-ON     CA
    ## 78        840       69                    oregon      US-OR     US
    ## 79        840       72              pennsylvania      US-PA     US
    ## 80        124       75      prince edward island      CA-PE     CA
    ## 81        840       74               puerto rico      US-PR     PR
    ## 82        124       76                    quebec      CA-QC     CA
    ## 83        840       77              rhode island      US-RI     US
    ## 84        124       79              saskatchewan      CA-SK     CA
    ## 85        840       80            south carolina      US-SC     US
    ## 86        840       81              south dakota      US-SD     US
    ## 87        840       82                 tennessee      US-TN     US
    ## 88        840       83                     texas      US-TX     US
    ## 89        840       85                      utah      US-UT     US
    ## 90        840       87                   vermont      US-VT     US
    ## 91        840       88                  virginia      US-VA     US
    ## 92        840       89                washington      US-WA     US
    ## 93        840       90             west virginia      US-WV     US
    ## 94        840       91                 wisconsin      US-WI     US
    ## 95        840       92                   wyoming      US-WY     US
    ## 96        124       93                     yukon      CA-YT     CA
    ##                      name_fr                   name_es
    ## 1             Aguascalientes            Aguascalientes
    ## 2           Basse-Californie           Baja California
    ## 3    Basse-Californie du Sud       Baja California Sur
    ## 4                   Campeche                  Campeche
    ## 5                    Chiapas                   Chiapas
    ## 6                  Chihuahua                 Chihuahua
    ## 7                   Coahuila      Coahuila de Zaragoza
    ## 8                     Colima                    Colima
    ## 9                     Mexico          Ciudad de México
    ## 10                   Durango                   Durango
    ## 11                Guanajuato                Guanajuato
    ## 12                  Guerrero        Estado de Guerrero
    ## 13                   Hidalgo         Estado de Hidalgo
    ## 14                   Jalisco                   Jalisco
    ## 15            État de Mexico          Estado de México
    ## 16                 Michoacán                 Michoacán
    ## 17                   Morelos                   Morelos
    ## 18                   Nayarit                   Nayarit
    ## 19                Nuevo León                Nuevo León
    ## 20                    Oaxaca                    Oaxaca
    ## 21                    Puebla                    Puebla
    ## 22                 Querétaro                 Querétaro
    ## 23              Quintana Roo              Quintana Roo
    ## 24           San Luis Potosí           San Luis Potosí
    ## 25                   Sinaloa                   Sinaloa
    ## 26                    Sonora                    Sonora
    ## 27                   Tabasco                   Tabasco
    ## 28                Tamaulipas                Tamaulipas
    ## 29                  Tlaxcala                  Tlaxcala
    ## 30                  Veracruz                  Veracruz
    ## 31                   Yucatán                   Yucatán
    ## 32                 Zacatecas                 Zacatecas
    ## 33                   Alabama                   Alabama
    ## 34                    Alaska                    Alaska
    ## 35                   Alberta                   Alberta
    ## 36                   Arizona                   Arizona
    ## 37                  Arkansas                  Arkansas
    ## 38      Colombie-Britannique        Columbia Británica
    ## 39                Californie                California
    ## 40                  Colorado                  Colorado
    ## 41               Connecticut               Connecticut
    ## 42                  Delaware                  Delaware
    ## 43                Washington          Washington D. C.
    ## 44                   Floride                   Florida
    ## 45                   Géorgie                   Georgia
    ## 46                     Idaho                     Idaho
    ## 47                  Illinois                  Illinois
    ## 48                   Indiana                   Indiana
    ## 49                      Iowa                      Iowa
    ## 50                    Kansas                    Kansas
    ## 51                  Kentucky                  Kentucky
    ## 52                 Louisiane                  Luisiana
    ## 53                     Maine                     Maine
    ## 54                  Manitoba                  Manitoba
    ## 55                  Maryland                  Maryland
    ## 56             Massachusetts             Massachusetts
    ## 57                  Michigan                  Míchigan
    ## 58                 Minnesota                 Minnesota
    ## 59               Mississippi                  Misisipi
    ## 60                  Missouri                    Misuri
    ## 61                   Montana                   Montana
    ## 62                  Nebraska                  Nebraska
    ## 63                    Nevada                    Nevada
    ## 64         Nouveau-Brunswick           Nuevo Brunswick
    ## 65             New Hampshire           Nuevo Hampshire
    ## 66                New Jersey              Nueva Jersey
    ## 67           Nouveau-Mexique              Nuevo México
    ## 68          État de New York                Nueva York
    ## 69   Terre-Neuve-et-Labrador      Terranova y Labrador
    ## 70          Caroline du Nord        Carolina del Norte
    ## 71            Dakota du Nord          Dakota del Norte
    ## 72 Territoires du Nord-Ouest  Territorios del Noroeste
    ## 73           Nouvelle-Écosse             Nueva Escocia
    ## 74                   Nunavut                   Nunavut
    ## 75                      Ohio                      Ohio
    ## 76                  Oklahoma                  Oklahoma
    ## 77                   Ontario                   Ontario
    ## 78                    Oregon                    Oregón
    ## 79              Pennsylvanie               Pensilvania
    ## 80     Île-du-Prince-Édouard Isla del Príncipe Eduardo
    ## 81                Porto Rico               Puerto Rico
    ## 82                    Québec                    Quebec
    ## 83              Rhode Island              Rhode Island
    ## 84              Saskatchewan              Saskatchewan
    ## 85           Caroline du Sud          Carolina del Sur
    ## 86             Dakota du Sud            Dakota del Sur
    ## 87                 Tennessee                 Tennessee
    ## 88                     Texas                     Texas
    ## 89                      Utah                      Utah
    ## 90                   Vermont                   Vermont
    ## 91                  Virginie                  Virginia
    ## 92        État de Washington                Washington
    ## 93      Virginie-Occidentale       Virginia Occidental
    ## 94                 Wisconsin                 Wisconsin
    ## 95                   Wyoming                   Wyoming
    ## 96                     Yukon                     Yukón

### Filter on species names

View the species lists for your particular dataset by calling:

``` r
bbs_list$species_list
```

    ## # A tibble: 756 x 12
    ##    Seq     AOU English_Common_Na~ French_Common_N~ Spanish_Common_~ ORDER Family
    ##    <chr> <int> <chr>              <chr>            <chr>            <chr> <chr> 
    ##  1 6      1770 Black-bellied Whi~ "Dendrocygne \x~ Dendrocygna aut~ Anse~ Anati~
    ##  2 7      1780 Fulvous Whistling~ "Dendrocygne fa~ Dendrocygna bic~ Anse~ Anati~
    ##  3 8      1760 Emperor Goose      "Oie empereur"   Anser canagicus  Anse~ Anati~
    ##  4 9      1690 Snow Goose         "Oie des neiges" Anser caerulesc~ Anse~ Anati~
    ##  5 10     1691 (Blue Goose) Snow~ "Oie des neiges~ Anser caerulesc~ Anse~ Anati~
    ##  6 11     1700 Ross's Goose       "Oie de Ross"    Anser rossii     Anse~ Anati~
    ##  7 13     1710 Greater White-fro~ "Oie rieuse"     Anser albifrons  Anse~ Anati~
    ##  8 18     1730 Brant              "Bernache crava~ Branta bernicla  Anse~ Anati~
    ##  9 19     1740 (Black Brant) Bra~ "Bernache crava~ Branta bernicla~ Anse~ Anati~
    ## 10 21     1725 Cackling Goose     "Bernache de Hu~ Branta hutchins~ Anse~ Anati~
    ## # ... with 746 more rows, and 5 more variables: Genus <chr>, Species <chr>,
    ## #   Scientific_Name <chr>, AOU4 <chr>, AOU6 <chr>

or view the most recent species list (may be the same as yours..):

``` r
bbsAssistant::species_list
```

Keep only *Passer domesticus*:

``` r
# grab the aou code for House Sparrow  using common name 
hosp.aou.code <- bbs_list$species_list$AOU[bbs_list$species_list$English_Common_Name=="House Sparrow"]
# or genus and species epithet
hosp.aou.code <-
  bbs_list$species_list$AOU[bbs_list$species_list$Genus == "Passer" &
                         bbs_list$species_list$Species == "domesticus"]

# filter the observations along  BBS's "AOU" code:
## note capitalization but spelling matters. can provide species as common, latin, or BBS "AOU" code
hosp.df <- munge_bbs_data(bbs_list, 
                          species = c("House SPARROW", "passer Domesticus", hosp.aou.code)) 
```

    ## When zero.fill=TRUE, a single species should be provided in argument `species`. Not zero-filling the data.

    ## Collapsing BBS data and metadata into a single data frame.

    ## Joining, by = c("CountryNum", "StateNum", "Route", "RPID", "Year", "RTENO")

    ## Joining, by = c("CountryNum", "StateNum", "Route", "RTENO")
    ## Joining, by = c("CountryNum", "StateNum", "Route", "RPID", "Year", "RTENO")
    ## Joining, by = c("CountryNum", "StateNum", "Route", "RPID", "Year", "RTENO", "Month", "Day", "ObsN", "TotalSpp", "StartTemp", "EndTemp", "TempScale", "StartWind", "EndWind", "StartSky", "EndSky", "StartTime", "EndTime", "Assistant", "QualityCurrentID", "RunType", "Date", "julian")

## BBS Data Availability (including sb_id)

There are currently two primary products released from the USGS that are
derived from the annual BBS roadside surveys, the [observations
data](https://www.sciencebase.gov/catalog/item/52b1dfa8e4b0d9b325230cd9)
and the analysis results. The datasets (observations, results) are
permanently and publicly available at [USGS
ScienceBase](http://sciencebase.gov).

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

To make a contribution visit
[CONTRIBUTIONS.md](https://github.com/trashbirdecology/bbsAssistant/CONTRIBUTING.md).
Contributors **must adhere to the [Code of
Conduct](https://github.com/trashbirdecology/bbsAssistant/CODE_OF_CONDUCT.md).**
For questions, comments, or issues, feel free to email the maintainer
[Jessica Burnett](mailto:jburnett@usgs.gov) or submit an
[Issue](https://github.com/TrashBirdEcology/bbsAssistant/issues)
(preferred).
