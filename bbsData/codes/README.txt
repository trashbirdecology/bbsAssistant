I. Introduction
A. This document describes the data files of the North American Breeding Bird Survey (BBS).
They are available at ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/DataFiles/
The current dataset version is 2017.0, which replaces version 2016.0, and includes data from 1966 - 2017.  
Date Posted: 04/25/2018.

B. Citation: 
Pardieck, K.L., D.J. Ziolkowski Jr., M. Lutmerding and M.-A.R. Hudson. 2018. North American Breeding Bird Survey 
Dataset 1966 - 2017, version 2017.0. U.S. Geological Survey, Patuxent Wildlife Research 
Center. https://doi.org/10.5066/F76972V8.


For more information on updates, see whatsnew.txt.

C. Archived data from earlier years, that were posted on this ftp site, can be found at
ftp://ftpext.usgs.gov/pub/er/md/laurel/BBS/Archivefiles/.


II. Data Liability Disclaimer
This database, identified as the North American Breeding Bird Survey Dataset, 
has been approved for release and publication by the U.S. Geological Survey (USGS) 
and the Canadian Wildlife Service of Environment and Climate Change Canada (ECCCC). Although this database 
has been subjected to rigorous review and is substantially complete, the USGS and ECCC 
reserve the right to revise the data pursuant to further analysis and review. 

Furthermore, it is released on the condition that the USGS, the U.S. Government, the ECCC, 
and the Canadian Government may not be held liable for any damages resulting from its 
authorized or unauthorized use.

It is also strongly recommended that careful attention be paid to the contents of the 
metadata files associated with the dataset. Information concerning the accuracy and 
appropriate uses of these data may be obtained from the metadata files, or from 
the National Program Managers.  For example, all the data contained within these files 
do not necessarily meet the various BBS methodological criteria.  
Run type codes, as indicated in the Weather.zip file, are used to distinguish between 
routes that meet USGS-BBS criteria and those that do not.  Run type "1" is acceptable data;  
run type "0" is unacceptable data for USGS trend analyses purposes.  Both types of data 
are available in the files.  See the RunType.txt file for a more complete discussion 
of run type codes and their application.  Also inclusion of observer covariates 
has been found to be an important factor for mitigating potential effects of observer 
bias when analyzing these data; observer information can be found in weather.zip file.


III. Terms of Use
This database, identified as the North American Breeding Bird Survey Dataset, has been approved for release and 
publication by the U.S. Geological Survey (USGS) and the Canadian Wildlife Service of Environment and 
Climate Change Canada (ECCC). Although this database has been subjected to rigorous review and is substantially complete, 
the USGS and ECCC reserve the right to revise the data pursuant to further analysis and review.

Furthermore, it is released on the condition that the USGS, the U.S. Government, the ECCC, and the 
Canadian Government may not be held liable for any damages resulting from its authorized or unauthorized use.
    
Use of these BBS data should be formally recognized in publications, presentations and other outlets 
via appropriate citation and acknowledgements.  See citation above.

Additionally, all work using these data should acknowledge the thousands of dedicated U.S. and Canadian participants 
who annually perform and coordinate the survey.

If a publication is to be based on the analysis of BBS data, we encourage you to read and understand these metadata and supporting documents. 
The National BBS staff are also available to address any questions regarding the collection and presentation of these data.  
Also depending on time constraints and other factors BBS staff may be available to assist with the writing and/or review of the manuscript.

It is in the best interest of the BBS program to demonstrate the utility of the data.  One way we do this is by posting a BBS-based bibliography.  
Upon publication of your research, we encourage you to send the National BBS office a quick note with a link to your paper or a pdf copy so we can include it.   
Thank you for supporting the BBS program and we look forward to learning of your work.


USGS Patuxent Wildlife Research Center
Breeding Bird Survey
12100 Beech Forest Road
Laurel, MD 20708-4038


IV. General Description of Files
The data are stored in self-extracting zip files.  The data are provided as comma 
separated values text files.  The first line of each file contains the column headers.

V. How to Access the Data Files
1) Download the file(s) of interest to your device.
2) IF .txt file, double click to open.  If .zip file, double click to extract data.  
3) You can view the data file with a text editor (such as Notepad), spreadsheet program 
(e.g., Excel) or input it into a database program.

IV. Contacts
If you have any questions or notice any problems with the data, please let us
know.

Dave Ziolkowski, Jr.		Keith Pardieck
301-497-5753			301-497-5843
dziolkowski@usgs.gov		kpardieck@usgs.gov


VI. List of Files

Files in the main directory:
File Name         Format            Description
README.TXT        Text              This file
FiftySt.txt       Text              Description of the Fifty-Stop files.  Found in 
				    50_StopData/1997ToPresent_SurveyWide directory.
Summary.txt       Text              Description of the Ten-Stop Summary files
WeatherInf.txt    Text              Description of the Weather file
RouteInf.txt      Text              Description of the Route file
whatsnew.txt      Text              Changes and additions made in this version of 
				    the data
SpeciesList.txt   Text              Listing of the bird species and taxa found in this data set.  Unique species 
				    identification codes (AOU), English common names, French common names in 
				    phylogenetic order (seq) for birds in the BBS database.
RegionCodes.txt   Text              List of Country, State/Prov/Terr. identification 
				    numbers and Names
BBSStrata.txt     Text              List of BBS Strata names and identification numbers
BCR.txt		  Text		    List of Bird Conservation Regions 
				    (name and indentification numbers)
Weathercodes.txt  Text              Description of the wind and sky codes
RunType.txt       Text              Description of the RunType column
RunProtocolID.txt Text		    Description of survey protocols used on BBS 
				    routes

Routes.zip       Comma Delimited    List of Routes with Latitude, Longitude, 
				    Stratum, and whether it's currently active

Weather.zip      Comma Delimited    Sample history of routes; date sampled,
				    who sampled (observer ID), weather conditions, time.
				    



The fifty-stop data for 1997 to present can be found in the 50-StopData Directory, sub-directory 
1997ToPresent_SurveyWide.

Fifty1.zip       Comma Delimited   Part 1 of the fifty-stop data.  Contains 1997 to present data
                                    for Alabama, Alaska, Alberta, Arizona, and
                                    Arkansas
Fifty2.zip       Comma Delimited   Part 2 of the fifty-stop data.  Contains 1997 to present data
                                    for British Columbia, California, Colorado, 
                                    Connecticut, and Delaware
Fifty3.zip       Comma Delimited   Part 3 of the fifty-stop data.  Contains 1997 to present data
                                    for Florida, Georgia, Idaho, Illinois, Indiana, and
                                    Iowa
Fifty4.zip       Comma Delimited   Part 4 of the fifty-stop data.  Contains 1997 to present data
                                    for Kansas, Kentucky, Louisiana, Northwest
                                    Territories, Maine, Manitoba, Maryland, and 
                                    Massachusetts
Fifty5.zip       Comma Delimited   Part 5 of the fifty-stop data.  Contains 1997 to present data
                                    for Michigan, Minnesota, Mississippi, Missouri,
                                    Montana, Nebraska, Nevada, New Brunswick and Newfoundland
Fifty6.zip       Comma Delimited   Part 6 of the fifty-stop data.  Contains 1997 to present data
                                    for New Hampshire, New Jersey, New Mexico, New 
                                    York, and North Carolina
Fifty7.zip       Comma Delimited   Part 7 of the fifty-stop data.  Contains 1997 to present data
                                    for North Dakota, Nunavut, Nova Scotia, Ohio, Oklahoma, and
                                    Ontario
Fifty8.zip       Comma Delimited   Part 8 of the fifty-stop data.  Contains 1997 to present data
                                    for Oregon, Pennsylvania, Prince Edward Island, 
                                    Quebec, Rhode Island, Saskatchewan, and South
                                    Carolina
Fifty9.zip       Comma Delimited   Part 9 of the fifty-stop data.  Contains 1997 to present data
                                    for South Dakota, Tennessee, Texas, Utah, and
                                    Vermont
Fifty10.zip      Comma Delimited   Part 10 of the fifty-stop data.  Contains 1997 to present data
                                    for Virginia, Washington, West Virginia, Wisconsin,
                                    Wyoming, and Yukon Territories



The full set of ten stop summary data can be found in the States Directory.  Files within the States directory are divided by State, Province, Territory.

Files in the States Directory:
File Name      Format                 Description
Alabama.zip    Comma Delimited        Alabama
Alaska.zip     Comma Delimited        Alaska
Alberta.zip    Comma Delimited        Alberta
Arizona.zip    Comma Delimited        Arizona
Arkansa.zip    Comma Delimited        Arkansas
BritCol.zip    Comma Delimited        British Columbia
Califor.zip    Comma Delimited        California
Colorad.zip    Comma Delimited        Colorado
Connect.zip    Comma Delimited        Connecticut
Delawar.zip    Comma Delimited        Delaware
Florida.zip    Comma Delimited        Florida
Georgia.zip    Comma Delimited        Georgia
Idaho.zip      Comma Delimited        Idaho
Illinoi.zip    Comma Delimited        Illinois
Indiana.zip    Comma Delimited        Indiana
Iowa.zip       Comma Delimited        Iowa
Kansas.zip     Comma Delimited        Kansas
Kentuck.zip    Comma Delimited        Kentucky
Louisia.zip    Comma Delimited        Louisiana
Maine.zip      Comma Delimited        Maine
Manitob.zip    Comma Delimited        Manitoba
Marylan.zip    Comma Delimited        Maryland
Massach.zip    Comma Delimited        Massachusetts
Michiga.zip    Comma Delimited        Michigan
Minneso.zip    Comma Delimited        Minnesota
Mississ.zip    Comma Delimited        Mississippi
Missour.zip    Comma Delimited        Missouri
Montana.zip    Comma Delimited        Montana
Nebrask.zip    Comma Delimited        Nebraska
NBrunsw.zip    Comma Delimited        New Brunswick
Newfoun.zip    Comma Delimited        Newfoundland
NHampsh.zip    Comma Delimited        New Hampshire
NJersey.zip    Comma Delimited        New Jersey
NMexico.zip    Comma Delimited        New Mexico
NYork.zip      Comma Delimited        New York
Nevada.zip     Comma Delimited        Nevada
NCaroli.zip    Comma Delimited        North Carolina
NDakota.zip    Comma Delimited        North Dakota
NWTerri.zip    Comma Delimited        Northwest Territories
NovaSco.zip    Comma Delimited        Nova Scotia
Nunavut.zip    Comma Delimited        Nunavut
Ohio.zip       Comma Delimited        Ohio
Oklahom.zip    Comma Delimited        Oklahoma
Ontario.zip    Comma Delimited        Ontario
Oregon.zip     Comma Delimited        Oregon
PEI.zip        Comma Delimited        Prince Edward Island
Pennsyl.zip    Comma Delimited        Pennsylvania
Quebec.zip     Comma Delimited        Quebec
RhodeIs.zip    Comma Delimited        Rhode Island
Saskatc.zip    Comma Delimited        Saskatchewan
SCaroli.zip    Comma Delimited        South Carolina
SDakota.zip    Comma Delimited        South Dakota
Tenness.zip    Comma Delimited        Tennessee
Texas.zip      Comma Delimited        Texas
Utah.zip       Comma Delimited        Utah
Vermont.zip    Comma Delimited        Vermont
Virgini.zip    Comma Delimited        Virginia
W_Virgi.zip    Comma Delimited        West Virginia
Washing.zip    Comma Delimited        Washington
Wiscons.zip    Comma Delimited        Wisconsin
Wyoming.zip    Comma Delimited        Wyoming
Yukon.zip      Comma Delimited	      Yukon	


The Migrant,Vagrant, Nonbreeder data is found in the MigrantNonBreeder Directory.  
These data began to be collected systematically in 1999.  
Limited amounts of data also exists for some earlier years.

Migrant.txt	    Text file	    	Description of Migrants.zip file.
MigrantSum.txt      Text file       	Description of MigrantSummary.zip file.
Migrants.zip	    Comma Delimited	Incidental Migrant, Vagrant, Nonbreeding
					bird data in 50-stop format.
MigrantSummary.zip  Comma Delimited     Incidental Migrant, Vagrant, Nonbreeding 
					bird data in 10-stop summary format.



Pre-1997 50-stop bird count data is found in the 50_StopData Directory, 
sub-directory Pre-1997_Canada.


Count of vehicles passing by during each 3-min count and unrelated excessive noise 
data are found in the VehicleData Directory.  
Systematic collection of these data began in 1997.

VehicleSt.txt	    Text file	    	Description of VehicleData.zip file.
VehicleSum.txt      Text file       	Description of VehicleSummary.zip file.
VehicleData.zip	    Comma Delimited	Vehicle count and excessive noise data 
					in 50-stop format.
VehicleSummary.zip  Comma Delimited     Vehicle count and excessive noise data 
					in 10-stop summary format.



