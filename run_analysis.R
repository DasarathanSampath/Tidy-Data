run_analysis <- function(){
  # Pre-requisit - Install.packages("reshape2")
  # Pre-requisit - library(reshape2)
  #File URL from course project - coursera - Getting & cleaning data
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  #Destination file name
  filename <- "UCIHARdataset.zip"
  
  #Download from URL if doesnot exist
  #Download file to the current working directory
  if(!file.exists(filename)){download.file(url, destfile=filename, mode="wb")}
  
  #Directory name uptained from the ZIP file manually
  # Verify, if the folder is Unzipped, if not unzip the files to current directory
  dirname <- "UCI HAR Dataset"
  if(!file.exists(dirname)){unzip(filename)}
  
  #Training data
  #subject ID
  subject_train_path <- file.path(dirname, "train", "subject_train.txt")
  subject_train <- read.table(subject_train_path)
  #variable values
  X_train_path <- file.path(dirname, "train", "X_train.txt")
  X_train <- read.table(X_train_path)
  #activity ID
  y_train_path <- file.path(dirname, "train", "y_train.txt")
  y_train <- read.table(y_train_path)
  
  #Test data
  #subject ID
  subject_test_path <- file.path(dirname, "test", "subject_test.txt")
  subject_test <- read.table(subject_test_path)
  #variable values
  X_test_path <- file.path(dirname, "test", "X_test.txt")
  X_test <- read.table(X_test_path)
  #activity ID
  y_test_path <- file.path(dirname, "test", "y_test.txt")
  y_test <- read.table(y_test_path)
  
  #Activity labels - Description of activity variables
  activity_labels_path <- file.path(dirname, "activity_labels.txt")
  activity_labels <- read.table(activity_labels_path)
  
  #Features - Description of each variables
  features_path <- file.path(dirname, "features.txt")
  features <- read.table(features_path)
  
  # 1. Merges the training and the test sets to create one data set.
  #Merging data sets of X_train.txt & X_test.txt
  merged_X_data <- rbind(X_train, X_test)
  
  # 4. Appropriately labels the data set with descriptive variable names.
  clear_name <- gsub("[()]", "", features[,2])
  names(merged_X_data) <- clear_name
  
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  # Extracts all the feature variables containing mean() & std()
  mean_std <- grep("mean()|std()", features[, 2])
  mean_std_data <- merged_X_data[,mean_std]
  
  # 3. Uses descriptive activity names to name the activities in the data set
  #Combine subject data
  subject_data <- rbind(subject_train, subject_test)
  names(subject_data) <- 'subject'
  #Combine activity data
  activity_data <- rbind(y_train, y_test)
  names(activity_data) <- 'activity'
  #Combine columns of mean_std_data, subject_data & activity_data
  combined_data <- cbind(subject_data, activity_data, mean_std_data)
  # Get activity column, find its levels & 
  #replace the level name with activity_labels
  activity_column <- factor(combined_data$activity)
  levels(activity_column) <- activity_labels[,2]
  combined_data$activity <- activity_column
  
  # 5. From the data set in step 4, creates a second, independent tidy data 
  #set with the average of each variable for each activity and each subject.
  # Melt combined_data columns except "subject & activity"
  melted_data <- melt(combined_data, id=c("subject", "activity"))
  casted_data <- dcast(melted_data, subject + activity ~ variable, mean)
  names(casted_data)[-c(1:2)] <- paste("[mean of]" , names(casted_data)[-c(1:2)] )
  write.table(casted_data, "tidy_data.txt", sep = ",")
  
}