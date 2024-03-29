% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/grab_bbs_data.R
\name{grab_bbs_data}
\alias{grab_bbs_data}
\title{Downloads and Imports the BBS Observations and Associated Metadata}
\usage{
grab_bbs_data(sb_id = NULL, bbs_dir = NULL, overwrite = FALSE)
}
\arguments{
\item{sb_id}{ScienceBase item number/identifier, used in sbtools.}

\item{bbs_dir}{The location where the BBS data will be stored. If not specified, will create a directory within the working directory called "data-raw."}

\item{overwrite}{Logical. Defaults to FALSE. FALSE will not download files if they exist in the specified directory.}
}
\description{
This function will download, unpack, and import the BBS dataset and associated metadata for a single dataset release. Defaults to the most recent version of the BBS dataset.
Wrapper for internal functions download_bbs_data(), unpack_bbs_data(), and import_bbs_data().
}
