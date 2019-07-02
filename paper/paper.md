---
title: 'bbsAsssistant: A package for downloading and munging data and information from the North American Breeding Bird Survey'
authors:
- affiliation: '1,2'
  name: Jessica L Burnett
  orcid: 0000-0002-0896-5099
- affiliation: '2,3' #multiple affilitations in quotes
  name: Lyndsie Wszola
  orcid: 0000-0000-0000-0000
- affiliation: 2
  name: Gabriela Munoz-Palomo
  orcid: 0000-0000-0000-0000
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

# References
