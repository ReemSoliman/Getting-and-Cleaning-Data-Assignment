# Getting-and-Cleaning-Data-Assignment

This README.md file describes how the assignment scripts are designed and coded.

## 1-run_analysis.R

- Read the moves data from the training and test folders and row bind them
>x_train <- read.table("./UCI HAR Dataset//train//X_train.txt", header = FALSE)
x_test <- read.table("./UCI HAR Dataset//test//X_test.txt", header = FALSE)
functions_train_test <- rbind(x_train, x_test)

- Do the same with activities data and persons data
>y_train <- read.table("./UCI HAR Dataset//train//y_train.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset//test//y_test.txt", header = FALSE)
activity_train_test <- rbind(y_train, y_test)

subject_train <- read.table("./UCI HAR Dataset//train//subject_train.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset//test//subject_test.txt", header = FALSE)
subject_train_test <- rbind(subject_train, subject_test)
names(subject_train_test) <- c("PersonID")
 