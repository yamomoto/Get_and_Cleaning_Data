fn <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fn, tf <- tempfile(fileext = ".zip"))
unzip(tf, exdir = td <- file.path(getwd(), "Course3"))
(list.files(td, full.names = TRUE, recursive = TRUE))