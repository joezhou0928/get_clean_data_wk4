rm(list=ls())
# Import dplyr
library(dplyr)
library(plyr)
library(stringr)
# Set working directory to the source file location - this R file
# Run it using RStudio
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
# Set file paths
x_train_path <- '.\\UCI HAR Dataset\\train\\X_train.txt'
x_test_path <- '.\\UCI HAR Dataset\\test\\X_test.txt'
sub_train_path <- '.\\UCI HAR Dataset\\train\\subject_train.txt'
sub_test_path <- '.\\UCI HAR Dataset\\test\\subject_test.txt'
feature_map_path <- '.\\UCI HAR Dataset\\features.txt'
y_train_path <- '.\\UCI HAR Dataset\\train\\y_train.txt'
y_test_path <- '.\\UCI HAR Dataset\\test\\y_test.txt'
actv_lbls_path <- '.\\UCI HAR Dataset\\activity_labels.txt'
# Read in the data
x_train <- read.table(x_train_path, 
                      header = FALSE, sep = "")
x_test <- read.table(x_test_path, 
                     header = FALSE, sep = "")
sub_train <- read.table(sub_train_path, 
                      header = FALSE, sep = "")
sub_test <- read.table(sub_test_path, 
                     header = FALSE, sep = "")
feature_map <- read.table(feature_map_path,
                          header = FALSE, sep = "")
y_train <- read.table(y_train_path, 
                     header = FALSE, sep = "")
y_test <- read.table(y_test_path, 
                     header = FALSE, sep = "")
actv_lbls <- read.table(actv_lbls_path,
                        header = FALSE, sep = "")
# Replace feature names in x_train and x_test with the correct ones
names(x_train) <- feature_map[,'V2']
names(x_test) <- feature_map[,'V2']
# Extract only the mean and std variables
mean_vars <- names(x_train)[str_detect(names(x_train), "mean\\(\\)")]
std_vars <- names(x_train)[str_detect(names(x_train), "std\\(\\)")]
# Drop extra columns from x_train and x_test
x_train <- x_train[,names(x_train) %in% c(mean_vars,std_vars)]
x_test <- x_test[,names(x_test) %in% c(mean_vars,std_vars)]
# Append subject to x_train and x_test
x_train <- cbind(sub_train, x_train)
x_test <- cbind(sub_test, x_test)
# Rename the subject column
names(x_train)[1] <- 'subject'
names(x_test)[1] <- 'subject'
# Append label columns to x_train and x_test
all_train <- cbind(x_train, y_train)
all_test <- cbind(x_test, y_test)
# Replace the label columns with descriptive activity names
all_train <- join(all_train, actv_lbls)
all_test <- join(all_test, actv_lbls)
# Drop the V1 column(activity code) wigth only the V2 column(activity names)
all_train <- all_train[,!names(all_train) %in% c('V1')]
all_test <- all_test[,!names(all_test) %in% c('V1')]
# Rename the activity column
names(all_train)[68] <- 'activity'
names(all_test)[68] <- 'activity'
# Merge the training and test data set
all_data <- rbind(all_train, all_test)
# Summarized data: average of each variable for each activity and each subject
summarised_data <- all_data %>% 
  group_by(subject, activity) %>% 
  summarise(across(everything(), mean))
# Output the data
write.table(summarised_data,
            file = ".\\output_data.txt",
            row.name = FALSE)
