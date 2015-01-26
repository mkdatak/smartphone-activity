---
title: "CodeBook.md"
output: html_document
---

## Pre requisite :

 - Clone the git repository : git clone https://github.com/mkdatak/smartphone-activity.git
 - Download data for the project from  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 - Unzip its content in the  smartphone-activity directory : you will get a new UCI HAR Dataset directory
 
## Analysis steps

- Read features.txt into a data.frame features
- Read activity_labels.txt into a data.frame activity_labels
- Read training data to build data set including features (X), subjects and activities (Y)
- Read test data to build data set including features (X), subjects and activities (Y)
- Merge test and training tables into a data.frame (table)
- Select mean and std related columns via colunm names
- Melt data to get tidy data (long format) into a data frame
- Transform the data set to get the average of each variable for each activity and each subject via the R command

`res <- table  %>% group_by(activity, subject, variable) %>% summarise_each(funs(mean))`

- Here is the new data set structure (11880 obs. of  4 variables) :

      + activity: Factor w/ 6 levels "LAYING","SITTING",..: 1 1 1 1 1 1 1 1 1 1 ...
      + subject : int  1 1 1 1 1 1 1 1 1 1 ...
      + variable: Factor w/ 66 levels "tBodyAcc-mean()-Z",..: 1 2 3 4 5 6 7 8 9 10 ...
      + average : num  0.2216 -0.0405 -0.1132 -0.2489 0.7055 ...
  
- Here is the data set "head" :  `head(res)`

      + activity subject             variable     average
      + 1   LAYING       1    tBodyAcc-mean()-Z  0.22159824
      + 2   LAYING       1     tBodyAcc-std()-X -0.04051395
      + 3   LAYING       1     tBodyAcc-std()-Y -0.11320355
      + 4   LAYING       1 tGravityAcc-mean()-Z -0.24888180
      + 5   LAYING       1  tGravityAcc-std()-X  0.70554977
      + 6   LAYING       1  tGravityAcc-std()-Y  0.44581772

- Write the result to file tidy.txt in the current(study) directory

