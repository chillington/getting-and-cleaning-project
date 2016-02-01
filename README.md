# Getting and Cleaning Data Course Project

This project involves downloading data stored in several different files and writing an R script (run_analysis.R) to produce from these files a single, tidy data set.

##Data

Data is downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The data describe 30 volunteers who performed six activities while wearing a smartphone on their waist. Measurements were recorded using the phone's accelerometer and gyroscope. Volunteers were then randomly assigned to two groups - training and test. 

The script run_analysis.R uses the following files from the downloaded folder:

-train/X_train.txt
-train/Y_train.txt
-train/subject_train.txt
-test/X_test.txt
-test/Y_test.txt
-test/subject_test.txt
-activity_labels.txt
-features.txt

##Using the Script

The script "run_analysis.R" should be run from the working directory. When run, the script will download and unzip the files to a new folder, and set the working directory to the folder where the files listed above are located.

Files from the "test" and "train" folders listed above are merged into a single data frame containing columns for subject, activity, and several measurement variables. Descriptive activity labels are added from the activity_labels file. Names for the measurement variables are added from the features file, then edited to be more descriptive. Finally, a second, tidy data frame is created which contains averages on all measurement variables for each subject and activity. This data frame is written to "tidydata.txt".

The resulting tidy dataset is described in CodeBook.md.
