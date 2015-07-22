# ----------------------------------------------------------
# Check if directory exists, if not create it.
# ----------------------------------------------------------
if (!file.exists("./CleanDataProject")){
	dir.create("./CleanDataProject")
}

# ----------------------------------------------------------
# Download the file to the directory
# ----------------------------------------------------------
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./CleanDataProject/UCI HAR Dataset.zip")

# ----------------------------------------------------------
# Unzip the file.
# Unzip to the same directory and accept the default to override any files that are there.
# ----------------------------------------------------------
unzip("./CleanDataProject/UCI HAR Dataset.zip", exdir="./CleanDataProject")

# ----------------------------------------------------------
# Install the dplyr package if it doesn't already exist.
# ----------------------------------------------------------
if("dplyr" %in% rownames(installed.packages()) == FALSE) 
{
    install.packages("dplyr")
}

# ----------------------------------------------------------
# Load the dply package so that we can use the methods available
# ----------------------------------------------------------
library(dplyr)

# ----------------------------------------------------------
# Set the location variables for the test and training data.
# We will be using this to load the data from the training and test files.
# ----------------------------------------------------------
testFilePath <- "./CleanDataProject/UCI HAR Dataset/test"
trainFilePath <- "./CleanDataProject/UCI HAR Dataset/train"
rootPath <- "./CleanDataProject/UCI HAR Dataset"

# ----------------------------------------------------------
# Attempt to read the test data from the files and store them in data.frames
# ----------------------------------------------------------
testData_subject <- read.table(paste(testFilePath, "/subject_test.txt", sep=""))
testData_X <- read.table(paste(testFilePath, "/X_test.txt", sep=""))
testData_Y <- read.table(paste(testFilePath, "/Y_test.txt", sep=""))

# ----------------------------------------------------------
# Attempt to read the training data from the files and store them in data.frames
# ----------------------------------------------------------
trainData_subject <- read.table(paste(trainFilePath, "/subject_train.txt", sep=""))
trainData_X <- read.table(paste(trainFilePath, "/X_train.txt", sep=""))
trainData_Y <- read.table(paste(trainFilePath, "/Y_train.txt", sep=""))

# ----------------------------------------------------------
# Get activity labels
# ----------------------------------------------------------
activityLabels <- read.table(paste(rootPath, "/activity_labels.txt", sep=""))

# ----------------------------------------------------------
# Attempt to read the column names
# ----------------------------------------------------------
columnNames <- read.table(paste(rootPath, "/features.txt", sep=""))

# ----------------------------------------------------------
# Get the column with the names, we don't care about the first column.
# ----------------------------------------------------------
columnNames <- columnNames %>% select(V2)

# ----------------------------------------------------------
# Replace the non-alphanumeric characters in the column names 
# with an underscore. This is to prevent issues with the duplicated method calls.
# ----------------------------------------------------------
columnNames[,1] <- gsub("[[:punct:]]", "_", columnNames[,1])

# ----------------------------------------------------------
# Assign the names to the columns
# ----------------------------------------------------------
colnames(testData_subject) <- "Subject"
colnames(trainData_subject) <- "Subject"
colnames(testData_X) <- columnNames[,1]
colnames(trainData_X) <- columnNames[,1]
colnames(testData_Y) <- "Activity"
colnames(trainData_Y) <- "Activity"

# ----------------------------------------------------------
# Merge the testData columns into one dataframe
# ----------------------------------------------------------
testData <- cbind(testData_subject,testData_X, testData_Y)

# ----------------------------------------------------------
# Merge the trainData columns into one dataframe
# ----------------------------------------------------------
trainData <- cbind(trainData_subject,trainData_X, trainData_Y)

# ----------------------------------------------------------
# Merge the test and training data into one dataframe
# ----------------------------------------------------------
fullData <- rbind(testData, trainData)

# ----------------------------------------------------------
# Remove the columns with the duplicate names from the data.frame.
# ----------------------------------------------------------
fullData <- fullData[,!duplicated(names(fullData))]

# ----------------------------------------------------------
# Reshape the data.frame to include the columns, we want:
# Subject, Activity, any column with the word "mean" or "std" in its title.
# ----------------------------------------------------------
fullData <- select(fullData, Subject,Activity, contains("mean", ignore.case = T), contains("std", ignore.case=T))

#Check if we have NA, in the columns.
#all(colSums(is.na(fullData)) == T)

# ----------------------------------------------------------
# Get the mean for each column, grouped by the Subject and Activity
# ----------------------------------------------------------
tidyData <- fullData %>% group_by (Subject, Activity) %>% summarise_each(funs(mean))

# ----------------------------------------------------------
# Merge by activity ID to get the activity label.
# ----------------------------------------------------------
tidyData <- merge(tidyData, activityLabels, by.x = "Activity", by.y = "V1")

# ----------------------------------------------------------
# Remove the extra column and tidy up the data.frame
# ----------------------------------------------------------
tidyData <- tidyData %>% mutate(Activity = V2) %>% select (Subject, Activity, tBodyAcc_mean___X:fBodyBodyGyroJerkMag_std__,-V2) %>% arrange(Subject, Activity)

# ----------------------------------------------------------
# Write out the data to a file.
# ----------------------------------------------------------
write.table(tidyData, file = "./CleanDataProject/tidyDataOutput.txt", row.names=FALSE)
