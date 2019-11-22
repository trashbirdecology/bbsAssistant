**bbsAssistant**: An R package for downloading and handling data and
information from the North American Breeding Bird Survey.
================
Last updated: 2019-11-21

<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- Silence lines 12 - 13 when rendering .pdf.  -->

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)[![Travis
build
status](https://travis-ci.org/trashbirdecology/bbsAssistant.svg?branch=master)](https://travis-ci.org/trashbirdecology/bbsAssistant)<img src="man/figures/logo.png" align="right" height=140/>
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
<!-- [![Coverage status](https://codecov.io/gh/trashbirdecology/bbsAssistant/master/graph/badge.svg)](https://codecov.io/github/trashbirdecology/bbsAssistant?branch=master) -->

## About

This package contains functions for downloading and munging data from
the North American Breeding Bird Survey (BBS) FTP server (Pardieck et
al. 2018; J. R. Sauer et al. 2017). Although the FTP server provides a
public interface for retrieving data and analysis results, this package
consolidates the efforts of the data user by automating downloading and
decompression of .zip data files, downloading route-level information,
and saving them as .feather files for speedy import from disk. The data
subsetting features of this package also allow the user to readily
import and save to file only the data necessary for her purposes.
Although the primary audience is for those wishing to use BBS data in
Program R for visualization or analysis, this package can be used to
quickly download the BBS data to file for use elsewhere.

The BBS team uses hierarchical modelling techniques to generate
population trend estimates (J. Sauer et al. 2017) at various spatial
scales [see the BBS results webpage](https://www.mbr-pwrc.usgs.gov/).
Given the variability in data availability, the BBS team also provides
data credibility scores for species-regions combinations. This package
contains two functions for retrieving the population trend estimates
produced by J. Sauer et al. (2017) and the associated data credibility
scores: a web-scraping function for obtaining current region and/or
species-specific population trend estimates and data credibility scores
via a supplied url,
[`get_credibility_trends()`](https://github.com/TrashBirdEcology/bbsAssistant/blob/master/R/get_credibility_trends.R);
and a function for the current and archived population trends estimates
for *all* species and regions,
[`get_analysis_results()`](https://github.com/TrashBirdEcology/bbsAssistant/blob/master/R/get_analysis_results.R).
Further, the package contains data objects of these analysis results,
and can be retrieved using the function utils::data(). Call
`data(package="bbsAssistant")` for data objects and descriptions.

## Installing `bbsAssistant`

Install the development version of this package using devtools and load
the package and dependencies:

``` r
devtools::install_github("trashbirdecology/bbsAssistant", 
                         dependencies = TRUE, force=FALSE)
library(bbsAssistant)
```

## Function Descriptions and Vignettes

For function descriptions please build the manual
(`devtools::build_manual("bbsAssistant)`) and for an example build the
vignette (`devtools::build_vignettes()`; or run
`/vignettes/vignettes.Rmd`).

## Contributions

To make a contribution visit the [contributions
instructions](https://trashbirdecology.github.io/bbsAssistant/CONTRIBUTING.html).
Contributors must adhere to the [Code of
Conduct](https://trashbirdecology.github.io/bbsAssistant/CODE_OF_CONDUCT.html).

## Acknowledgments

We especially thank the participatory scientists who collect data
annually for the North American Breeding Bird Survey, and the Patuxent
Wildlife Research Center for making these data publicly and easily
accessible.

## References

<div id="refs" class="references">

<div id="ref-pardieck2018north">

Pardieck, KL, DJ Ziolkowski Jr, M Lutmerding, and MAR Hudson. 2018.
“North American Breeding Bird Survey Dataset 1966–2017, Version
2017.0.” *US Geological Survey, Patuxent Wildlife Research Center,
Laurel, Maryland, USA.\[online\] URL: Https://Www. Pwrc. Usgs.
Gov/BBS/RawData*.

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
