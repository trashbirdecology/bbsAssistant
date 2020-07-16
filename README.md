**bbsAssistant**: An R package for downloading and handling data and
information from the North American Breeding Bird Survey.
================
Last updated: 2020-07-16

<!-- README.md is generated from README.Rmd. Please edit that file and render to push updates.-->

<!-- badges: start -->

[![R build
status](https://github.com/trashbirdecology/bbsAssistant/workflows/R-CMD-check/badge.svg)](https://github.com/trashbirdecology/bbsAssistant/actions)
[![DOI](https://joss.theoj.org/papers/10.21105/joss.01768/status.svg)](https://doi.org/10.21105/joss.01768)[![License:
CC0-1.0](https://img.shields.io/badge/License-CC0%201.0-lightgrey.svg)](http://creativecommons.org/publicdomain/zero/1.0/)
[![Contributors](https://img.shields.io/badge/all_contributors-8-lightgrey.svg?style=flat-square)](#contributors)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-lightgrey.svg)](https://www.tidyverse.org/lifecycle/#maturing)
![usgs](https://img.shields.io/badge/USGS-Core-lightgrey.svg)
<!-- [![Travis build status](https://travis-ci.org/trashbirdecology/bbsAssistant.svg?branch=main)](https://travis-ci.org/trashbirdecology/bbsAssistant) -->
<!-- badges: end -->
<img src="man/figures/logo.png" align="right" height=140/>

## About

*This repository contains the development version of **bbsAssistant**.
Please submit [Issues
here](https://github.com/TrashBirdEcology/bbsAssistant/issues). Major
releases will be pushed to the [USGS Biolab
GitHub](https://github.com/usgs-biolab/bbsAssistant).*

This R package contains functions for downloading and munging data from
the [North American Breeding Bird
Survey](https://www.pwrc.usgs.gov/bbs/) (BBS) [via
FTP](https://www.pwrc.usgs.gov/BBS/RawData/) (Pardieck et al. 2018; J.
R. Sauer et al. 2017). This package was created to allow the user to
bulk-download the BBS point count and related (e.g., route-level
conditions) via FTP, and to quickly subset the data by taxonomic
classifications and/or geographical locations. This package also
maintains data containing the trend and annual indices from the most
recent (1996-2017) [hierarchical population trend
analyses](https://www.mbr-pwrc.usgs.gov/bbs/) (J. Sauer et al. 2017).

### Citation

Burnett, J.L., Wszola, L., and Palomo-Muñoz, G. 2019, bbsAssistant: An R
package for downloading and handling data and information from the North
American Breeding Bird Survey: U.S. Geological Survey software release,
<https://doi.org/10.5066/P93W0EAW>.

## Quick Start

### Installing **bbsAssistant**

Install the development version of this package using devtools and load
the package and dependencies:

``` r
devtools::install_github("trashbirdecology/bbsAssistant", 
                         dependencies = TRUE, 
                         ref="main" # ensure it pulls from the 'main' branch, default
                         force=TRUE) # force to get most recent dev version
library(bbsAssistant)
```

## Quick-download and import

Quickly retrieve all or a subset (states/regions) of the BBS data using
the wrapper function,
`quick_get_bbs()`:

``` r
bbs<- bbsAssistant::quick_get_bbs(state.names = c("Florida", "Nebraska"),  # get only two states for convenience. Leave blank to retrieve all states/regions.
                     overwrite.bbs = FALSE, overwrite.routes = FALSE,  # overwrite routes.csv and bbs data = FALSE
                     get.conditions = TRUE, overwrite.conditions = FALSE) # get weather conditions, does not overwrite
```

## Additional Information

### Vignettes and package manual

For function descriptions please build the manual
(`devtools::build_manual("bbsAssistant)`) and for an example build the
vignette(s) (`devtools::build_vignettes()`; or run
`/vignettes/vignettes.Rmd`).

### Contributions to and interactions within the project

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

## Contributors

Thanks to our contributors:
<!-- ALL-CONTRIBUTORS-LIST:START-->

<table>

<tr>

<td align="center">

<a href="http://ethanwhite.org"><img src="https://avatars0.githubusercontent.com/u/744427?v=4" width="100px;" alt="Ethan White"/><br /><sub><b>Ethan
White</b></sub></a><br />
<!-- <a href="#userTesting-Ethan White" title="User Testing">📓</a>  -->
<!-- <a href="#review-Ethan White" title="Documentation">📖</a> -->

</td>

<td align="center">

<a href="https://jsta.rbind.io/"><img src="https://avatars0.githubusercontent.com/u/7844578?s=400&v=4" width="100px;" alt="Joseph Stachelek"/><br /><sub><b>Joseph
Stachelek</b></sub></a><br />
<!-- <a href="#userTesting-jsta" title="User Testing">📓</a> -->
<!-- <a href="#review-jsta" title="Documentation">📖</a> -->
<!-- <a href="#bugs-jsta" title="Bugs">🐛</a> -->

</td>

<td align="center">

<a href="https://mbjoseph.github.io"><img src="https://avatars3.githubusercontent.com/u/2664564?v=4" width="100px;" alt="Max Joseph"/><br /><sub><b>Max
Joseph</b></sub></a><br />
<!-- <a href="https://github.com/TrashBirdEcology/bbsAssistant/commits?author=mbjoseph" title="Documentation">📖</a> -->

</td>

<td align="center">

<a href="https://github.com/Bisaloo"><img src="https://avatars1.githubusercontent.com/u/10783929?s=460&v=4" width="100px;" alt="Hugh Gruson"/><br /><sub><b>Hugh
Gruson</b></sub></a>
<!-- <a href="#review-bisaloo" title="Documentation">📖</a> -->

</td>

</tr>

</table>

<!-- ALL-CONTRIBUTORS-LIST:END -->

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

## References

<div id="refs" class="references">

<div id="ref-pardieck2018north">

Pardieck, KL, DJ Ziolkowski Jr, M Lutmerding, and MAR Hudson. 2018.
“North American Breeding Bird Survey Dataset 1966–2017, Version
2017.0.” *US Geological Survey, Patuxent Wildlife Research Center,
Laurel, Maryland, USA. \[Online\] URL:
Https://Www.pwrc.usgs.gov/BBS/RawData*.

</div>

<div id="ref-sauer2017first">

Sauer, John R, Keith L Pardieck, David J Ziolkowski Jr, Adam C Smith,
Marie-Anne R Hudson, Vicente Rodriguez, Humberto Berlanga, Daniel K
Niven, and William A Link. 2017. “The First 50 Years of the North
American Breeding Bird Survey.” *The Condor: Ornithological
Applications* 119 (3). Oxford University Press: 576–93.
<https://doi.org/10.1650/CONDOR-17-83.1>.

</div>

<div id="ref-sauer2017north">

Sauer, JR, D Niven, J Hines, David Ziolkowski Jr, KL Pardieck, JE
Fallon, and William Link. 2017. “The North American Breeding Bird
Survey, Results and Analysis 1966-2015.”

</div>

</div>
