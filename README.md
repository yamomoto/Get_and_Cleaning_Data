# GetandCleanDataProject
The project files for Getting and Cleaning Data coursera project

## Files

### README.md
This description...

### run_analysis.R 
run_analysis is the main cleanup script.  It can be run to perform a data tidy-up on the Samsung data found at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The data should be downloaded and saved to your working directory.  The script can be run from the same working directory.
The script uses stringr, dyplr and tidyr libraries.
The output is a tidy_data table.

### download_data.R
A utility script with commands to download and unzip the data to your working directory

### write_data.R
A utility script with commands to write the tidy data to a text file

### codebook.md
the codebook describes the variables found in the tidy data set.
