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
date: "22 November 2019"
output: pdf_document
bibliography: paper.bib
tags:
- breeding bird survey
- ornithology
- data
- web scraping
affiliations:
- index: 1
  name: Science Analytics and Synthesis, Core Science Systems, U.S. Geological Survey, Denver, Colorado, USA
- index: 2
  name: School of Natural Resources, University of Nebraska, Lincoln, Nebraska, USA
- index: 3
  name: School of Biological Sciences, University of Nebraska, Lincoln, Nebraska, USA
---

# Summary

This package contains functions for downloading and munging data from the North American Breeding Bird Survey (BBS) FTP server [@pardieck2018north; @sauer2017first]. Although the FTP server provides a public interface for retrieving data and analysis results, this package consolidates the efforts of the data user by automating downloading and decompression of .zip data files, downloading route-level information, and saving them as .feather files for speedy import from disk. The data subsetting features of this package also allow the user to readily import and save to file only the data necessary for their purposes. Although the primary audience is for those wishing to use BBS data in Program R for visualization or analysis, this package can be used to quickly download the BBS data to file for use elsewhere. 

# Retrieving and munging the North American Breeding Bird Survey Data and hierarhical modelling results 
The BBS team uses hierarchical modelling techniques to generate population trend estimates [@sauer2017north] at various spatial scales [see the BBS results webpage](https://www.mbr-pwrc.usgs.gov/). Given the variability in data availability, the BBS team also provides data credibility scores for species-regions combinations. This package retrieves the raw count BBS data from the U.S. Geological Survey's FTP server using function `get_bbsData()`. This function requires an on-line connection, and contains arguments for subsetting the data by species identity and/or region. The data are first downloaded into a temporary folder and then uploaded into the R workspace as a single data frame object. The function 
`export_bbsFeathers()` saves the data frame to a specified directory as .feather files, allowing for long-term local storage of the raw data. Importing the .feathers is expedited using the function `import_bbsFeathers()`, and provides arguments for further subsetting the data prior to loading it into the environment. Used in conjunction with the species list (`get_speciesList()`), post-hoc subsetting is simplified by the function `subset_speciesList()`. 

# Retrieving Population Trend Model Results from the BBS website
This package contains two options for obtaining the population trend estimates produced by @sauer2017north and the associated data credibility scores: on-line and off-line approaches. The current results (but not the archived results; we intend to save the archived results as data objects in a future release) are updated annually and are stored in this package as data objects; call `data(package="bbsAssistant")` for data objects and descriptions. 

# State of the Field
We are aware of three R packages which retrieve and/or munge the NABBS data: rdataretriever [@rdataretriever], rBBS [@rBBS], and bbsBayes [@bbsBayes], each of which provides various pathways for importing NABBS data into the local environment. rdataretriever provides a dataset which integrates components of the BBS data, however, requires the use of Python [@python] in conjunction with R. The rBBS package is perhaps most aligned with the bbsAssistant package, in that it also provides functions for downloading NABBS data, however, the existing repository is apparently stale. Furhter, bbsAssistant provides streamlined functionality for retrieving location and species-specific data. Finally, the bbsBayes package, was creating primarily to run hierarhical models in a Bayesian framework within R. bbsBayes provides a function, `bbsBayes::fetch_bbs_data()` which retrieves and imports all data at once yet does not allow for custom download and import of the dataset. 
 
# Acknowledgements
We thank the participatory scientists who collect data annually for the North American Breeding Bird Survey, and the Patuxent Wildlife Research Center for making these data publicly and easily accessible. Some functions in this package were adapted from the [rBBS](https://github.com/oharar/rbbs) package and are mentioned in function source code as applicable.

# References
