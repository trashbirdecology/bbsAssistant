**bbsAssistant**: An R package for downloading and handling data and
information from the North American Breeding Bird Survey.
================
Last updated: 2021-04-30

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
![dependencies](https://img.shields.io/librariesio/github/trashbirdecology/bbsassistant?style=flat-square&logo=appveyor)

<!-- [![Travis build status](https://travis-ci.org/trashbirdecology/bbsAssistant.svg?branch=main)](https://travis-ci.org/trashbirdecology/bbsAssistant) -->

<!-- badges: end -->

<img src="man/figures/logo.png" align="right" height=140/>

## ALERT

Due to changes in the location of the BBS observations and results
datasets, this package is undergoing a transformation (written
2020-09-09).

Currently (as of 2020-09-09), we are working on the following and in the
following order:

  - Providing the most recent Sauer analysis results as data objects
  - Updating the subsetting functions
  - Functions for obtaining old observations dataset versions
  - Functions for obtaining old analysis results
  - Updating the taxonomic matching capacity
  - Mapping and visualization features

## About

\_This repository contains the development version of **bbsAssistant**.
Please submit [Issues here](https://github.com/TrashBirdEcology/bbsAssistant/issues). Major
releases will be pushed to the [this
repository](https://github.com/usgs-biolab/bbsAssistant) and to the
[USGS ScienceBase digital
repository](https://www.sciencebase.gov/catalog/item/5de53a0fe4b02caea0e8fa72).

This R package contains functions for downloading, importing, and
munging the the observations data and the analysis results from the
[North American Breeding Bird Survey](https://www.pwrc.usgs.gov/bbs/)
(BBS) [via USGS ScienceBase repository](https://sciencebase.gov/). This
package was created to allow the user to bulk-download the BBS point
count and related (e.g., route-level conditions) via the ScienceBase API
(using [R package
`sbtools`](https://cran.r-project.org/package=sbtools), and to quickly
subset the data by taxonomic classifications, jurisdictional boundaries,
and geospatial bounding boxes.

### Citations

**For the BBS dataset and analysis results**, call
`citation("bbsAssistant")` or see library loading message.

**For general use of the R package bbsAssistant** and/or **companion
paper**:  
Burnett, J.L., Wszola, L., and Palomo-Muñoz, G. (2019). bbsAssistant: An
R package for downloading and handling data and information from the
North American Breeding Bird Survey: U.S. Geological Survey software
release, <https://doi.org/10.5066/P93W0EAW>.

*or*

Burnett, J.L., Wszola, L., and Palomo-Muñoz, G. (2019). bbsAssistant: An
R package for downloading and handling data and information from the
North American Breeding Bird Survey. Journal of Open Source Software,
4(44), 1768, <https://doi.org/10.21105/joss.01768>

## Quick Start

### Installing **bbsAssistant**

Install the development version of this package using devtools and load
the package and dependencies:

``` r
devtools::install_github("trashbirdecology/bbsAssistant", 
                         ref="main", # ensure it pulls from the 'main' branch. Function may still default to 'master' branch.
                         force=TRUE) # force to get most recent dev version
library(bbsAssistant)
```

## Quick Start

Start here to quickly retrieve the most recent version of the BBS
observations dataset (this dataset currently contains \>6.5 million
rows). The BBS datasets are typically released on an annual basis, and
comprise the QA/QC’d dataset containing observations from years 1966 to
the most recent. **Unless you are reproducing analyses of historical
versions of the BBS annual releases, the most recent release should
suffice for your purposes.**

We have stored a data package inside `bbsAssistant` called
**bbs\_recent** containing the most recent observations dataset.
Retrieve the most recent data in the package:

``` r
data <- bbsAssistant::bbs_obs
```

or download the data files directly:

``` r
sb_id = "5ea04e9a82cefae35a129d65" #specify the item identifier 
```

## BBS Data Availability

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

A lookup table containing the available datasets (N = 5) and analysis
results will be regularly updated, and comprises the following entries:

<table class="table table-striped" style="">

<caption>

List of datasets currently available for download at USGS ScienceBase.
Highlighted and bold row indicates the default BBS observations dataset
stored internally in the
package.

</caption>

<thead>

<tr>

<th style="text-align:left;">

sb\_title

</th>

<th style="text-align:right;">

release\_year

</th>

<th style="text-align:left;">

data\_type

</th>

<th style="text-align:right;">

year\_start

</th>

<th style="text-align:right;">

year\_end

</th>

<th style="text-align:left;">

sb\_item

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;width: 40em; font-weight: bold;background-color: yellow !important;">

2020 Release - North American Breeding Bird Survey Dataset
(1966-2019)

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

5d00efafe4b0573a18f5e03a

</td>

</tr>

</tbody>

</table>

## Vignettes and package manual

VIGNETTES ARE CURRENTLY UNDER CONSTRUCTION DUE TO PACKAGE
OVERHAUL/MAKEOVER\!
<!-- For function descriptions please build the manual (`devtools::build_manual("bbsAssistant)`) and for an example build the vignette(s) (`devtools::build_vignettes()`; or run `/vignettes/vignettes.Rmd`); or visit the [package website]().  -->

## Contributing

To make a contribution visit the
[CONTRIBUTIONS.md](https://github.com/trashbirdecology/bbsAssistant/CONTRIBUTING.md).
Contributors **must adhere to the [Code of
Conduct](https://github.com/trashbirdecology/bbsAssistant/CODE_OF_CONDUCT.md).**
For questions, comments, or issues, feel free to email the maintainer
[Jessica Burnett](mailto:jburnett@usgs.gov) or submit an
[Issue](https://github.com/TrashBirdEcology/bbsAssistant/issues)
(preferred).

## Project Team

<table>

<tr>

<td align="center">

<a href="http://trashbirdecology.github.io/"><img src="https://avatars2.githubusercontent.com/u/9939381?s=460&v=4" width="100px;" alt="Jessica Burnett"/><br /><sub><b>Jessica
Burnett <br>Team Lead &
Maintainer</b></sub></a><br />

<td align="center">

<a href="https://github.com/GabsPalomo"><img src="https://avatars1.githubusercontent.com/u/28967490?s=460&v=4" width="100px;" alt="Gabby Palomo-Muñoz"/><br /><sub><b>Gabby
Palomo-Muñoz <br>Team
Member</b></sub></a><br />

</td>

<td align="center">

<a href="https://github.com/lsw5077"><img src="https://avatars0.githubusercontent.com/u/22730128?s=460&v=4" width="100px;" alt="Lyndsie Wszola"/><br /><sub><b>Lyndsie
Wszola <br>Team Member</b></sub></a><br />

</td>

</tr>

</table>

## Acknowledgments

We especially thank the participatory scientists who collect data
annually for the North American Breeding Bird Survey, and the Patuxent
Wildlife Research Center for making these data publicly and easily
accessible. We thank those who have made
[contributions](https://github.com/TrashBirdEcology/bbsAssistant/graphs/contributors)
of all sizes to this project. Finally, we thank two peer reviewers,
[Ethan White](www.github.com/ethanwhite) and [Josepha
Stachelek](www.github.com/jsta) whose feedback greatly improved the
quality of this software and the [associated software
paper](www.github.com/trashbirdecology/bbsassistant/paper/paper.md).
[Logo](https://github.com/TrashBirdEcology/bbsAssistant/blob/main/man/figures/logo.png)
by Gabby Palomo-Munoz.

This software has been approved for release by the U.S. Geological
Survey (USGS). Although the software has been subjected to rigorous
review, the USGS reserves the right to update the software as needed
pursuant to further analysis and review. No warranty, expressed or
implied, is made by the USGS or the U.S. Government as to the
functionality of the software and related material nor shall the fact of
release constitute any such warranty. Furthermore, the software is
released on condition that neither the USGS nor the U.S. Government
shall be held liable for any damages resulting from its authorized or
unauthorized use.

## How to Cite the Data

Easily retrieve the text citation for the specified dataset using
`sbtools`:

``` r
sbtools::item_get_fields(sb_id, "citation")
```

    ## [1] "Pardieck, K.L., Ziolkowski Jr., D.J., Lutmerding, M., Aponte, V.I., and Hudson, M-A.R., 2020, North American Breeding Bird Survey Dataset 1966 - 2019: U.S. Geological Survey data release, https://doi.org/10.5066/P9J6QUF6."

If you use the package data, the text citations are available in the
package citation file:

``` r
citation("bbsAssistant")
```

    ## 
    ## To cite the R package bbsAssistant, please use: To cite the most recent
    ## version of the Breeding Bird Survey dataset, please use: To cite a
    ## different version of the Breeding Bird Survey dataset, please visit the
    ## [project
    ## page](https://www.sciencebase.gov/catalog/item/52b1dfa8e4b0d9b325230cd9).
    ## 
    ##   Burnett, J.L., L.S. Wszola, and G. Palomo-Muñoz (2019). bbsAssistant:
    ##   An R package for downloading and handling data and information from
    ##   the North American Breeding Bird Survey. Journal of Open Source
    ##   Software. DOI:10.21105/joss.01768
    ## 
    ##   Pardieck, K.L., Ziolkowski Jr., D.J., Lutmerding, M., Aponte, V.I.,
    ##   and Hudson, M-A.R., 2020, North American Breeding Bird Survey Dataset
    ##   1966 - 2019: U.S. Geological Survey data release,
    ##   https://doi.org/10.5066/P9J6QUF6
    ## 
    ## To see these entries in BibTeX format, use 'print(<citation>,
    ## bibtex=TRUE)', 'toBibtex(.)', or set
    ## 'options(citation.bibtex.max=999)'.

``` r
# print(citation("bbsAssistant"), bibtex=TRUE)# for bibtex
```
