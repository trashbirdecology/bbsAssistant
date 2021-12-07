**bbsAssistant**: An R package for downloading and handling data and
information from the North American Breeding Bird Survey.
================
Last updated: 2021-12-02

<!-- badges: start -->

[![DOI](https://joss.theoj.org/papers/10.21105/joss.01768/status.svg?style=flat-square&logo=appveyor)](https://doi.org/10.21105/joss.01768)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-lightgrey.svg?style=flat-square&logo=appveyor)](https://www.tidyverse.org/lifecycle/#maturing)
![usgs](https://img.shields.io/badge/USGS-Core-lightgrey.svg?style=flat-square&logo=appveyor)
[![R build
status](https://github.com/trashbirdecology/bbsAssistant/workflows/R-CMD-check/badge.svg?style=flat-square&logo=appveyor)](https://github.com/trashbirdecology/bbsAssistant/actions)
[![License:
CC0](https://img.shields.io/badge/License-CC0%201.0-lightgrey.svg?style=flat-square&logo=appveyor)](http://creativecommons.org/publicdomain/zero/1.0/)
[![Contributors](https://img.shields.io/badge/all_contributors-8-lightgrey.svg?style=flat-square&logo=appveyor)](#contributors)
![downloads](https://img.shields.io/github/downloads/trashbirdecology/bbsAssistant/total?style=flat-square&logo=appveyor)
<!-- ![dependencies](https://img.shields.io/librariesio/github/trashbirdecology/bbsassistant?style=flat-square&logo=appveyor) -->
<!-- [![Travis build status](https://travis-ci.org/trashbirdecology/bbsAssistant.svg?branch=main)](https://travis-ci.org/trashbirdecology/bbsAssistant) -->
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
devtools::load_all()
```

## Download, Unpack, and Import the Most Recent Dataset

``` r
bbs <- grab_bbs_data(sb_dir=NULL)
# Optional: specify `sb_id` as the USGS ScienceBase identifier for a specific data release. If sb_id is not supplied, will default to the most recent data release.
sb_id="5ea04e9a82cefae35a129d65"
```

The object resulting from `bbsAssistant::import_bbs_data()` is a list
comprising the following objects:

``` r
names(bbs)
```

    ## [1] "observations" "routes"       "observers"    "weather"      "species_list"
    ## [6] "citation"     "vehicle_data"

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
<td style="text-align:left;width: 40em; font-weight: bold;background-color: yellow !important;">
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
<td style="text-align:left;width: 40em; ">
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
<td style="text-align:left;width: 40em; ">
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
<td style="text-align:left;width: 40em; ">
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
<td style="text-align:left;width: 40em; ">
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
<td style="text-align:left;width: 40em; ">
The North American Breeding Bird Survey, Analysis Results 1966 - 2018
</td>
<td style="text-align:right;">
2020
</td>
<td style="text-align:left;">
sauer_results
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
<td style="text-align:left;width: 40em; ">
The North American Breeding Bird Survey, Analysis Results 1966 - 2017
</td>
<td style="text-align:right;">
2018
</td>
<td style="text-align:left;">
sauer_results
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

<!-- ## Quick Start -->

## Contributing

To make a contribution visit the
[CONTRIBUTIONS.md](https://github.com/trashbirdecology/bbsAssistant/CONTRIBUTING.md).
Contributors **must adhere to the [Code of
Conduct](https://github.com/trashbirdecology/bbsAssistant/CODE_OF_CONDUCT.md).**
For questions, comments, or issues, feel free to email the maintainer
[Jessica Burnett](mailto:jburnett@usgs.gov) or submit an
[Issue](https://github.com/TrashBirdEcology/bbsAssistant/issues)
(preferred).

<!-- ## Project Team -->
<!-- <table> -->
<!--   <tr> -->
<!--      <td align="center"> -->
<!--           <a href="http://trashbirdecology.github.io/"><img src="https://avatars2.githubusercontent.com/u/9939381?s=460&v=4" width="100px;" alt="Jessica Burnett"/><br /><sub><b>Jessica Burnett <br>Team Lead & Maintainer</b></sub></a><br /> -->
<!--            <td align="center"> -->
<!--           <a href="https://github.com/GabsPalomo"><img src="https://avatars1.githubusercontent.com/u/28967490?s=460&v=4" width="100px;" alt="Gabby Palomo-Muñoz"/><br /><sub><b>Gabby Palomo-Muñoz <br>Team Member</b></sub></a><br /></td> -->
<!--            <td align="center"> -->
<!--           <a href="https://github.com/lsw5077"><img src="https://avatars0.githubusercontent.com/u/22730128?s=460&v=4" width="100px;" alt="Lyndsie Wszola"/><br /><sub><b>Lyndsie Wszola <br>Team Member</b></sub></a><br /> -->
<!--      </td> -->
<!--   </tr> -->
<!-- </table> -->
