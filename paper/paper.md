---
title: 'bbsAsssistant: A package for downloading and munging data and information from the North American Breeding Bird Survey'
authors:
- affiliation: '1,2'
  name: Jessica L Burnett
  orcid: 0000-0002-0896-5099
- affiliation: '2,3'
  name: Lyndsie Wszola
  orcid: 0000-0002-2660-2048
- affiliation: 2
  name: Gabriela Palomo-Muñoz
date: "05 July 2019"
output: pdf_document
bibliography: paper.bib
tags:
- breeding bird survey
- ornithology
- data
- web scraping
affiliations:
- index: 1
  name: Nebraska Cooperative Fish and Wildlife Research Unit, University of Nebraska, USA
- index: 2
  name: School of Natural Resources, University of Nebraska, USA
- index: 3
  name: School of Biological Sciences, University of Nebraska, USA
---

# Summary

This package contains functions for downloading and munging data from the North American Breeding Bird Survey (BBS) FTP server [@pardieck2018north; @sauer2017first]. Although the FTP server provides a public interface for retrieving data and analysis results, this package consolidates the efforts of the data user by automating downloading and decompression of .zip data files, downloading route-level information, and saving them as .feather files for speedy import from disk. The data subsetting features of this package also allow the user to readily import and save to file only the data necessary for her purposes. Although the primary audience is for those wishing to use BBS data in Program R for visualization or analysis, this package can be used to quickly download the BBS data to file for use elsewhere. 

The BBS team uses hierarhical modelling techniques to generate population trend estimates [@sauer2017north] at various spatial scales [see the BBS results webpage](https://www.mbr-pwrc.usgs.gov/). Given the variability in data availability, the BBS team also provides data credibility scores for species-regions combinations. This package contains two functions for retrieving the population trend estimates produced by @sauer2017north and the associated data credibility scores: a web-scraping function for obtaining current region and/or species-specific population trend estimates and data credibility scores via a supplied url, [`get_credibility_trends()`](https://github.com/TrashBirdEcology/bbsAssistant/blob/master/R/get_credibility_trends.R); and a function for the current and archived population trends estimates for *all* species and regions, [`get_analysis_results()`](https://github.com/TrashBirdEcology/bbsAssistant/blob/master/R/get_analysis_results.R). 

# Acknowledgements
We thank the volunteer citizen scientists who collect data annually for the North American Breeding Bird Survey, and the Patuxent Wildlife Research Center for making these data publicly and easily accessible. Some functions in this package were adapted from the [rBBS](github.com/oharar/rbbs) package and are mentioned in function source code as appicable.

# References
