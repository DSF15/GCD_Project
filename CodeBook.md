# Code Book for "Getting and Cleaning Data" course project


## Original Data Overview

Source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities 
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded 
accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been 
video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for 
generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec 
and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth 
low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz 
cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


## Code Book 

### The essential data elements for this project are described here

* Subject: A unique indentifier for the participant in the experiments.  Takes integer values 1 through 30.
* Activity: 1=WALKING, 2=WALKING_UPSTAIRS, 3=WALKING_DOWNSTAIRS, 4=SITTING, 5=STANDING, 6=LAYING
* 561 measurements recorded for each subject and activity. See [features_info.txt](https://github.com/DSF15/GCD_Project/blob/master/features_info.txt) for information on the names and descriptions of the 
  measurement variables, how the data was collected and the units of measurement.


## Data Transformations

The following transformations are applied within ```run_analysis.R``` 

* Feature descriptions are added as variable names.
* Only the mean and standard deviation measurement variables are retained (79 of 561 variables).  This is accomplished by searching for the patterns 
  "mean" or "std" within the labels provided by the researchers.  Features related to "angle" measurements are excluded. 
* The training and test data sets are combined. 
* The activity descriptions (e.g. "WALKING", "SITTING") are appended to the data using the integer activity code (1,2,...,6) and the activity
  label mapping provided by the resarchers.  The integer version of activity is subsequently dropped from the data.
* The data is ordered by subject identifier.
* The activity measurement variable names are modified to be somewhat more descriptive and "human readable."
* A data set containing the average (mean) of each measurement by subject and activity is generated using the ```ddply``` function (```plyr``` package). 
This data set is written to an external file named "AverageActivityMeasures.txt."  










