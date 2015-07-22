# CleanDataCourseProject Code Book
The aim of this project was to collect data from a data set sourced from UCI's archive of the Human Activity Recognition Using Smartphones Data Set. The data was to be reformatted and cleaned so that some rudimentary analysis could be performed.

## Source Files
The data used by this project was downloaded from a zip file located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The files used were
* `subject_test.txt` - contains the identifiers for each subject that performed the activity tracked by the X and Y test files
* `X_test.txt` - contains the test set 
* `Y_test.txt` - contains the test data labels for activity
* `subject_train.txt` - contains the identifiers for each subject that performed the activity tracked by the X and Y training files
* `X_train.txt` - contains the trainging set 
* `Y_train.txt` - contains the training data labels for activity
* `activity_labels.txt` - links the unique identifiers in the Y_test and Y_train data with the activity name
* `features.txt` - links all the measurements in the X_test and X_train data files with descriptive names

## Output File
The script generates a tidy dataset that is saved to the file "./CleanDataProject/tidyDataOutput.txt".
 
## Variables Used

In the list below, _xxx_ is a place holder for either "_test_" or "_train_".
* `features.txt` - Second variable used
* `activity_labels.txt' all variables used
* `subject_xxx.txt` - all variables used
* `Y_xxx.txt` - all variables used
* `X_xxx.txt` - Used the following variables (please note that these are the renamed column names):
`
tBodyAcc_mean___X					 tBodyAcc_mean___Y                   
tBodyAcc_mean___Z
tGravityAcc_mean___X                 tGravityAcc_mean___Y                 tGravityAcc_mean___Z                
tBodyAccJerk_mean___X                tBodyAccJerk_mean___Y                tBodyAccJerk_mean___Z                tBodyGyro_mean___X                  
tBodyGyro_mean___Y                   tBodyGyro_mean___Z                   tBodyGyroJerk_mean___X               tBodyGyroJerk_mean___Y              
tBodyGyroJerk_mean___Z               tBodyAccMag_mean__                   tGravityAccMag_mean__                tBodyAccJerkMag_mean__              
tBodyGyroMag_mean__                  tBodyGyroJerkMag_mean__              fBodyAcc_mean___X                    fBodyAcc_mean___Y                   
fBodyAcc_mean___Z                    fBodyAcc_meanFreq___X                fBodyAcc_meanFreq___Y                fBodyAcc_meanFreq___Z               
fBodyAccJerk_mean___X                fBodyAccJerk_mean___Y                fBodyAccJerk_mean___Z                fBodyAccJerk_meanFreq___X           
fBodyAccJerk_meanFreq___Y            fBodyAccJerk_meanFreq___Z            fBodyGyro_mean___X                   fBodyGyro_mean___Y                  
fBodyGyro_mean___Z                   fBodyGyro_meanFreq___X               fBodyGyro_meanFreq___Y               fBodyGyro_meanFreq___Z              
fBodyAccMag_mean__                   fBodyAccMag_meanFreq__               fBodyBodyAccJerkMag_mean__           fBodyBodyAccJerkMag_meanFreq__      
fBodyBodyGyroMag_mean__              fBodyBodyGyroMag_meanFreq__          fBodyBodyGyroJerkMag_mean__          fBodyBodyGyroJerkMag_meanFreq__     
angle_tBodyAccMean_gravity_          angle_tBodyAccJerkMean__gravityMean_ angle_tBodyGyroMean_gravityMean_     angle_tBodyGyroJerkMean_gravityMean_
angle_X_gravityMean_                 angle_Y_gravityMean_                 angle_Z_gravityMean_                 tBodyAcc_std___X                    
tBodyAcc_std___Y                     tBodyAcc_std___Z                     tGravityAcc_std___X                  tGravityAcc_std___Y                 
tGravityAcc_std___Z                  tBodyAccJerk_std___X                 tBodyAccJerk_std___Y                 tBodyAccJerk_std___Z                
tBodyGyro_std___X                    tBodyGyro_std___Y                    tBodyGyro_std___Z                    tBodyGyroJerk_std___X               
tBodyGyroJerk_std___Y                tBodyGyroJerk_std___Z                tBodyAccMag_std__                    tGravityAccMag_std__                
tBodyAccJerkMag_std__                tBodyGyroMag_std__                   tBodyGyroJerkMag_std__               fBodyAcc_std___X                    
fBodyAcc_std___Y                     fBodyAcc_std___Z                     fBodyAccJerk_std___X                 fBodyAccJerk_std___Y                
fBodyAccJerk_std___Z                 fBodyGyro_std___X                    fBodyGyro_std___Y                    fBodyGyro_std___Z                   
fBodyAccMag_std__                    fBodyBodyAccJerkMag_std__            fBodyBodyGyroMag_std__               fBodyBodyGyroJerkMag_std__`          

## Processing and Transformations:
* Test and training data were merged to produce was data.frame
* Activity id was replaced with matching the activity label.
* Feature names were renamed to remove non-alphanumeric characters, such as -, (, ).
* Duplicate columns were removed
* The features variables used were those that had mean and std in the name. All other feature variables were dropped from the tidy data set.
* The mean was calculated on each feature variable by Subject and Activity
* The tidy data was sorted by Subject and Activity