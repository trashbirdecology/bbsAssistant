---
title: 'bbsAsssistant: A package for downloading and munging data and information from the North American Breeding Bird Survey'
authors:
- affiliation: '1,2'
  name: Jessica L Burnett
  orcid: 0000-0002-0896-5099
- affiliation: '2,3' #multiple affilitations in quotes
  name: Lyndsie Wszola
  orcid: 0000-0002-2660-2048
- affiliation: 2
  name: Gabriela Palomo-Munoz
date: "XX July 2019"
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

This package contains functions for downloading and munging data from the North American Breeding Bird Survey (BBS) FTP server [@pardieck2018north; @sauer2017first]. Although the FTP server provides a user-friendly interface for retrieving data, this package consolidates the efforts of the data user by automating downloading and decompression of .zip data files, downloading route-level information, and saving them as .feather files for speedy import from disk. Notably, the package contains a web-scraping function for retrieving population trend estimates and data credibility of the results of the BBS hierarchical analyses [@sauer2017north]. 

This package is intended for those who wish to download and manipulate the BBS data using Program R.

The BBS is an annual, roadside, volunteer-based survey of North American birds which began in 1966. It includes data from the continental United States, southern Canada, and more recently Alaska and northern Mexico.  More than 5,000 survey routes are tracked each June at the peak of the nesting season by experienced birders. Each route is aproximately 24.5 miles long, has 50 stops each located at 0.5 mile intervals. At each stop, the observer conducts a three-minute point count of all the birds heard or seen within 0.25 miles [@sauer1997north]. 

The North American BBS [website] (https://www.pwrc.usgs.gov/bbs/index.cfm) produces an index of relative abundance and not a complete count of breeding bird populations. BBS data can be used to make continental- or regional-scale maps of relative abundance of breeding bird species; analyze population change on survey routes of some species over time to produce regional and continental estimates of trends; guild population trends and perform community analysis (e.g., neotropical migrant birds). For more information on how the BBS data can be used go to the BBS [website] (https://www.mbr-pwrc.usgs.gov/bbs/genintro.html).

# References
