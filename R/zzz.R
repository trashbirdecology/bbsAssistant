
## Startup functions ------------------------------------
#' .onAttach start message
#'
#' @param libname defunct
#' @param pkgname defunct
#'
#' @return invisible()
.onAttach <- function(libname, pkgname) {
    start_message <- c( "TERMS OF USE: North American Breeding Bird Survey Data:\n\n"
                        , "Users of these BBS data are obligated to formally recognize their use of the program's\n"
                        , "data in publications, presentations and other outlets. Additionally, all work using these data\n"
                        , "should acknowledge the thousands of U.S. and Canadian participants who annually perform \n"
                        , "and coordinate the survey. It is in the best interest for the continued success of\n"
                        , "the BBS that authors submit a reprint or pdf of their work featuring BBS data\n"
                        , "to the National BBS staff for inclusion in the program's bibliography.\n"
                        , "If a publication is based solely on the analysis of BBS data, we recommend\n"
                        , "that you involve National BBS staff with the writing and/or review of the manuscript.\n\n\n"
                        ,"DATA LIABILITY DISCLAIMER: North American Breeding Bird Survey Data"
                        , "This database, identified as the North American Breeding Bird Survey Dataset," 
                        , "has been approved for release and publication by the U.S. Geological Survey (USGS)" 
                        , "and the Canadian Wildlife Service of Environment Canada (EC). Although this database" 
                        , "has been subjected to rigorous review and is substantially complete, the USGS and EC" 
                        , "reserve the right to revise the data pursuant to further analysis and review." 
                        , "Furthermore, it is released on the condition that the USGS, the U.S. Government,"
                        , "the EC, and the Canadian Government may not be held liable "
                        , "for any damages resulting from its authorized or unauthorized use."
                        
    )
    packageStartupMessage(start_message)
    invisible()
}

