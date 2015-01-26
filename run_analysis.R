require(reshape2)
require(dplyr)

dir <- "./UCI HAR Dataset"

#'Read features.txt into a data.frame features
features <- read.table(paste(dir, "features.txt", sep = "/"), stringsAsFactors = F)
str(features)

#' Read activity_labels.txt into a data.frame activity_labels
activity_labels <- read.table(paste(dir, "activity_labels.txt", sep = "/"), stringsAsFactors = F)
names(activity_labels) <- c("id", "activity")
str(activity_labels)

activites <- activity_labels$activity

#'Read training data to build data set including features (X), subjects and activities (Y)
table_train  <- read.table(paste(dir, "train/X_train.txt", sep ="/"))
subjects <- read.table(paste(dir, "train/subject_train.txt", sep = "/"), stringsAsFactors = F)
names(subjects) <- c("subject")

table_train <- cbind(subjects, table_train)

y_s <- read.table(paste(dir, "train/y_train.txt", sep = "/"), stringsAsFactors = F)
names(y_s) <- c("activity")
table_train <- cbind(activity=activites[y_s$activity], table_train)


#'Read test data to build data set including features (X), subjects and activities (Y)
table_test  <- read.table(paste(dir, "test/X_test.txt", sep ="/"))
subjects <- read.table(paste(dir, "test/subject_test.txt", sep = "/"), stringsAsFactors = F)
names(subjects) <- c("subject")

table_test <- cbind(subjects, table_test)

y_s <- read.table(paste(dir, "test/y_test.txt", sep = "/"), stringsAsFactors = F)
names(y_s) <- c("activity")
table_test <- cbind(activity=activites[y_s$activity], table_test)

#' Merge test and training tables into a data.frame (table)
table <- rbind(table_train, table_test)

#' Select mean and std related columns via colunm names
indices <-c( grep("mean\\(",features$V2) ,grep("std\\(",features$V2))+2
labels <- features$V2[indices]
table <- table[,c(1:2,indices)]
names(table) <- c("activity", "subject",labels)

#'Melt data to get tidy data (long format) into a data frame
m <- melt(data = table, id.vars = c("activity", "subject"))

#' Transform the data set to get the average of each variable for each activity and each subject.
res <- m %>% group_by(activity, subject, variable) %>% summarise_each(funs(mean))
colnames(res)[4] <- "average"

#' Write the result to file in the current(study) directory
write.table(res, file = "tidy.txt", row.name=FALSE)
