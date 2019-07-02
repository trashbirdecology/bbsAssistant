Function Manual
---------------

For function descriptions and examples please see the
[manual](/man/bbsAssistant_0.0.0.9000.pdf).

Contributions
-------------

If you would like to contribute, please submit a pr or email me
(jessicaleighburnett at gmail). I am especially interested in having
another set of eyes and hands to transfer and clean up the functions
listed in [Issue
1](https://github.com/TrashBirdEcology/bbsAssistant/issues/1).

Simple Runthrough of `bbsAssistant`
===================================

Install package
---------------

Define and/or create local directories
--------------------------------------

This function will create, if it does not already exist, folder
**./bbsData/** within which to locally store BBS data and results.
**NOTE**: If the directory exists, it will not overwrite files. If the
bbs data already exists inside bbsDir, then we will create a logical to
NOT download the data (see below). If you wish to download more, or
overwrite existing data, please specify downloadBBSData=TRUE or remove
.zip files from **/bbsData/**.

Download the BBS data, import, and save R objects to file.
==========================================================

If necessary, download all the state data. This takes 10-15 minutes, so
only run if you have not recently downloaded the BBS data.

If the BBS data was downloaded previously and saved as .feather, we can
import it using `import_bbsFeathers`. The code below is particularly
useful if you are importing multiple files…

If you wish to download and/or import ALL the data, you might choose to
do so in a loop. Note: this is expensive! The following are not run in
this example.

Or import a lot of data files.

Optional: Subset BBS data by taxonomic groupings, functional traits.
====================================================================

Subset individual species
-------------------------

First, let’s retrieve the species list from the BBS FTP server.

We can sort by AOU \# (e.g. House Sparrow aou = 06882)

We could merge the bbs count data with the species list to avoid having
to refer to AOU, then just subset using species name (e.g. ’House
Sparrow).

We can also use the `subset_SpeciesList` as a convenient way to
**remove** taxonomic groups from the BBS data.

Species trend estimates and credibility
---------------------------------------

Another huge component of this package is the ability to retrieve data
credibility and species trend estimates from the BBS results using the
function `get_credibility_trends`.

As an example, we will retrieve the credibility scores and species trend
estimates for **House Sparrows in Florida**.

### Steps for obtaining argument ‘url’ in `get_credibility_trends`:

First, visit the USGS Patuxent Wildlife Research Center’s [website for
BBS results](https://www.mbr-pwrc.usgs.gov/) Online
<a href="https://www.mbr-pwrc.usgs.gov/" class="uri">https://www.mbr-pwrc.usgs.gov/</a>.

Next, enable the drop-down **Survey Results**, and choose **Trend
Estimates (by region)**:
![](/images/regcred_select_trendests_byregion.png)

Next, choose the desired region: ![](/images/regcred_select_fl.png)

Then, copy the URL address when you see a page like this: Next, choose
the desired region: ![](/images/regcred_fl_ex.png)
