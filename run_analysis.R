library(dplyr)
library(tidyr)
library(stringr)

print ("Reading in and processing data. This may take a while ...")

#read test files into data frames
activity_labels <- tbl_df(read.table("./Course3/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE))
features <- tbl_df(read.table("./Course3/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE))
x_test <- tbl_df(read.table("./Course3/UCI HAR Dataset/test/x_test.txt", stringsAsFactors = FALSE))
y_test <- tbl_df(read.table("./Course3/UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE))
subject_test <- tbl_df(read.table("./Course3/UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE))
x_train <- tbl_df(read.table("./Course3/UCI HAR Dataset/train/x_train.txt", stringsAsFactors = FALSE))
y_train <- tbl_df(read.table("./Course3/UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE))
subject_train <- tbl_df(read.table("./Course3/UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE))

#convert data vectors into test and training data frames.
test <- bind_cols(list(subject_test, y_test, x_test))
train <- bind_cols(list(subject_train, y_train, x_train))

#remove the individual tables that are no longer required
rm(list = "x_test", "y_test", "subject_test", "x_train", "y_train", "subject_train")

#give the columns sensible names, taken from the feature list with spaces and punctuation removed
features <- mutate(features, col_name = tolower(str_replace_all(V2, "[[:punct:]]", "")))
names(test) <- c("subjectid", "activityid", features$col_name)
names(train) <- c("subjectid", "activityid", features$col_name)

#merge the testing and training data
subject_data <- bind_rows(test, train)

#remove features and intermediate objects, now that we're finished with them
rm(list = "features", "test", "train")

#Get only the mean and std columns
subject_data <- select(subject_data, subjectid, activityid, contains("mean"), contains("std"))

#give activities readable names (and the column a sensible name)
subject_data <- merge(subject_data, activity_labels, by.x="activityid", by.y="V1")
names(subject_data)[names(subject_data) == 'V2'] <- 'activity'

# get rid of the activityid column and the activity table, now that they are no longer necessary
subject_data <- select(subject_data, -activityid)
rm(activity_labels)

tidy_data <- subject_data %>%
    group_by(activity, subjectid) %>%
    summarise_each("mean")

#clean up remaining items.
rm(subject_data)

print(tidy_data)
print("Done!")