# CleanDataCourseProject
Repository for the Getting and Cleaning Data Course Project

## Running the cleanup script
Running the cleanup script is pretty straightforward. 

1. Download the run_analysis.R file from the GitHub repo. The repo can be found at https://github.com/thecodefarmllc/CleanDataCourseProject.
2. Open the file in your development environment, such as R Studio.
3. Source the script file and run it.
4. During the script's excution, it will:
  * Create a new directory, __CleanDataProject__, under the current working directory. The directory will be created if it doesn't exist.
  * Downloads a zipped file, __UCI HAR Dataset.zip__, to the new directory.
  * Unzips the downloaded file. The unzip will create a new subdirectory, __UCI HAR Dataset__ and all files will be created under that folder. If the script had already been executed in the past, the directory and its files will be overwritten.
  * The __dplyr__ package will be installed if it hasn't already been installed.
  * Reads a series of files that will be the source of the data used by the script.
  * Cleans and reformats the data.
  * Stores the results of the work to a file, __tidyDataOutput.txt__. The file will be created under the CleanDataProject directory. If the file already exists, it will be overwritten.
5. The script can be executed any number of times as needed.
