# Getting and Cleaning Data - Course Project

# You should create one R script called run_analysis.R that does 
# the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for 
#    each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.


# download the zip file containing the project data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
               destfile="GCD_project.zip")

# extract the files
unzip("GCD_project.zip", overwrite=TRUE)

# read training and test data 
trainAct <- read.table("UCI HAR Dataset/train/Y_train.txt", col.names="ActivityCode")
trainSub <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names="Subject")
train <- read.table("UCI HAR Dataset/train/X_train.txt")

testAct <- read.table("UCI HAR Dataset/test/Y_test.txt", col.names="ActivityCode")
testSub <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names="Subject")
test <- read.table("UCI HAR Dataset/test/X_test.txt")

# read activity and feature labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", 
                              col.names=c("ActivityCode","Activity")) 
features <- read.table("UCI HAR Dataset/features.txt")

# identify the features related to mean and standard deviation measurements
# excluding the pattern "angle" since this word is found in 7 column names
# which also include "Mean" (e.g., angle(tBodyAccMean,gravity))

mean_std_ft_col <- intersect(grep(".*mean.*|.*std.*", features$V2, ignore.case=TRUE),
                   grep(".*angle.*", features$V2, ignore.case=TRUE, invert=TRUE))
mean_std_ft <- features[mean_std_ft_col,]$V2

# rename the columns of train and test with the feature labels
colnames(train) <- features$V2
colnames(test) <- features$V2

# keep only the mean and std. dev. features
train1 <- train[,names(train) %in% mean_std_ft]
test1 <- test[,names(test) %in% mean_std_ft]

# combine subject and activity identifers with features
train_all <- cbind(trainSub, trainAct, train1)
test_all  <- cbind(testSub, testAct, test1)

# merge train and test data sets into one
full_samp <- rbind(train_all, test_all) 

# include the activity description, drop the "ActivityCode" column
  
full_samp <- merge(full_samp, activityLabels, by="ActivityCode")
full_samp <- subset(full_samp, select=-ActivityCode)

# reorder the columns so that Activity is the 2nd column instead of
# the last, and order by Subject 

full_samp <- full_samp[c(1, ncol(full_samp), 3:ncol(full_samp)-1)]
full_samp <- full_samp[order(full_samp$Subject),]
 
# attempt to make the measurement variable names more "human readable"

varnames  <- colnames(full_samp)

for (i in 1:ncol(full_samp)) 
{
  varnames[i] = gsub("\\()","",varnames[i])
  varnames[i] = gsub("std","StdDev",varnames[i])
  varnames[i] = gsub("mean","Mean",varnames[i]) 
  varnames[i] = gsub("Acc","Accel",varnames[i])
  varnames[i] = gsub("Mag","Magnitude",varnames[i])
  varnames[i] = gsub("^(t)","Time-",varnames[i])
  varnames[i] = gsub("^(f)","Freq-",varnames[i])
  varnames[i] = gsub("gravity","Gravity",varnames[i])
  varnames[i] = gsub("BodyBody","Body",varnames[i])

}

colnames(full_samp) <- varnames


# verify that there are 30 subjects in the sample
length(unique(full_samp$Subject))

# verify that the mean and std. dev. feature values are all numeric
f<- lapply(full_samp[,3:ncol(full_samp)], class)
unique(f)


# generate a data set containing the average of each variable 
# by activity for each subject

library(plyr)
AverageActivityMeasures <- ddply(full_samp, ~Subject + Activity, 
                                 numcolwise(mean))

write.table(AverageActivityMeasures, "AverageActivityMeasures.txt", 
            sep=" ", row.names = FALSE, quote = FALSE)
 
