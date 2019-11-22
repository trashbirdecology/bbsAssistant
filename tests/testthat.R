library("testthat")
library("bbsAssistant")

# Skip on travis
if (Sys.getenv("USER") != "travis") {
 test_check("bbsAssistant")
}
