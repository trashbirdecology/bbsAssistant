---
title: 'bbsAsssistant: A package for downloading and munging data and information from the North American Breeding Bird Survey'
authors:
- affiliation: '1'
  name: Jessica L Burnett
  orcid: 0000-0002-0896-5099
- affiliation: '2,3'
  name: Lyndsie Wszola
  orcid: 0000-0002-2660-2048
- affiliation: 2
  name: Gabriela Palomo-Muñoz
date: "26 November 2019"
output: pdf_document
bibliography: paper.bib
tags:
- breeding bird survey
- data retriever
- ecology
- point counts
affiliations:
- index: 1
  name: Science Analytics and Synthesis, Core Science Systems, U.S. Geological Survey, Denver, Colorado, USA
- index: 2
  name: School of Natural Resources, University of Nebraska, Lincoln, Nebraska, USA
- index: 3
  name: School of Biological Sciences, University of Nebraska, Lincoln, Nebraska, USA
---

# Summary
This R package contains functions for downloading and munging data from the [North American Breeding Bird Survey](https://www.pwrc.usgs.gov/bbs/) (BBS) [via file  transfer protocol (FTP)](https://www.pwrc.usgs.gov/BBS/RawData/) [@pardieck2018north; @sauer2017first]. This package was created to allow the user to bulk-download the BBS point count and related (e.g., route-level conditions) via FTP, and to quickly subset the data by taxonomic classifications and/or geographical locations. This package also maintains data containing the trend and annual indices from the most recent (1996-2017) [hierarhchical popultion trend analyses](https://www.mbr-pwrc.usgs.gov/bbs/) [@sauer2017north]. 

## Retrieving and Munging Point-count and Related Data
Although the USGS BBS provides a public interface for retrieving data and analysis results via FTP, __bbsAsssitant__ expedites the efforts of downloading, decompressing, importing, and subsetting the state/region-level point-count files, and other associated files (e.g., taxonomic information, geographic information, route-level conditions, geographical information). Further, __bbsAssistant__ provides subset  data e consolidates the efforts of the data user by automating downloading and decompression of .zip data files, downloading route-level information, and saving them as .feather files for speedy import from disk. The data subsetting features of this package also allow the user to readily import and save to file only the data necessary for their purposes. Although the primary audience is for those wishing to use BBS data in Program R for visualization or analysis, this package can be used to quickly download the BBS data to file for use elsewhere. 

## Retrieving Population Trend Model Results from the BBS website
The Patuxent Wildlife Research Center uses hierarchical modelling of the BBS data to generate population trend estimates and annual indices at various spatial scales [@sauer2017north; see also the BBS results webpage](https://www.mbr-pwrc.usgs.gov/). Given the variability in data availability, the BBS team also provides data credibility scores for species-regions combinations. This package contains the most recent results associated with these analyses as data objects, but also provides a function (`get_credibility_trends()`) for retrieving all analysis results which are public-facing. 

# State of the Field
We are aware of three R packages which retrieve and/or munge the NABBS data: __rdataretriever__ [@rdataretriever], __rBBS__ [@rBBS], and __bbsBayes__ [@bbsBayes], each of which provides various pathways for importing NABBS data into the local environment. rdataretriever provides a dataset which integrates components of the BBS data, however, requires the use of Python [@python] in conjunction with R. The __rBBS__ package is perhaps most aligned with the __bbsAssistant__ package, in that it also provides functions for downloading NABBS data, however, the existing repository is apparently stale. Furhter, bbsAssistant provides streamlined functionality for retrieving location and species-specific data. Finally, the bbsBayes package, was creating primarily to run hierarhical models in a Bayesian framework within R. __bbsBayes__ provides a function (`bbsBayes::fetch_bbs_data()`) for retrieving and importing all BBS data, yet does not currently allow for custom download and importation. 
 
# Acknowledgements
We especially thank the thousands of participatory scientists who have and continuie to collect data for the North American Breeding Bird Survey program, and the Patuxent Wildlife Research Center for making these data publicly and easily accessible.  We also thank [Ethan White; \@ethanwhite](https://github.com/ethanwhite) and [Joseph Stachelek; \@jsta](https://github.com/ethanwhite) for their feedback on a previous iteration of this software which greatly improved usability, functionality, and efficiency. This draft manuscript is distributed solely for purposes of scientific peer review. Its content is deliberative and predecisional, so it must not be disclosed or released by reviewers. Because the manuscript has not yet been approved for publication by the U.S. Geological Survey (USGS), it does not represent any official USGS finding or policy. This software is preliminary or provisional and is subject to revision. It is being provided to meet the need for timely best science. The software has not received final approval by the U.S. Geological Survey (USGS). No warranty, expressed or implied, is made by the USGS or the U.S. Government as to the functionality of the software and related material nor shall the fact of release constitute any such warranty. The software is provided on the condition that neither the USGS nor the U.S. Government shall be held liable for any damages resulting from the authorized or unauthorized use of the software.

# References
