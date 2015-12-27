# This repo was created for the JHU Data Science "Getting and Cleaning Data" course project

As per the course website, *"The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set."*

## Project Data

The data is related to activity tracking from "wearable computing" and is available from the UCI Machine Learning Repository 
[link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 
It was also made available through a link on the course project page (which is referenced in ```run_analysis.R```).

## Instructions (from the course website) 

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


## R program

```run_analysis.R``` as written assumes the user has not yet downloaded and extracted the project data.

If the data is already available in the current working directory, the applicable function calls (```download.file``` and ```unzip```)
can be commented out before running the code.  Note that the working directory should be set as the directory containing the folder named 
"UCI HAR Dataset". 

This is the only script needed to generate the required data sets.
 

## Code book

See CodeBook.md for further details on the data