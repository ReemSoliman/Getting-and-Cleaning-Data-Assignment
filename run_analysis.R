#Read the movements data from the training and test files and bind them
x_train <- read.table("./UCI HAR Dataset//train//X_train.txt", header = FALSE)
x_test <- read.table("./UCI HAR Dataset//test//X_test.txt", header = FALSE)
functions_train_test <- rbind(x_train, x_test)

#Read the activities data from the training and test files and bind them
y_train <- read.table("./UCI HAR Dataset//train//y_train.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset//test//y_test.txt", header = FALSE)
activity_train_test <- rbind(y_train, y_test)

#Read the subject ids training and test files and bind them
subject_train <- read.table("./UCI HAR Dataset//train//subject_train.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset//test//subject_test.txt", header = FALSE)
subject_train_test <- rbind(subject_train, subject_test)
names(subject_train_test) <- c("PersonID")

##Read features.txt file
features <- read.table("./UCI HAR Dataset//features.txt", header = FALSE)
names(functions_train_test) <- features[,2]
#subset the dataset with the mean and standard deviation only
subsetted <- functions_train_test[grep("std|mean", features[,2], ignore.case = TRUE)]

#Rename the variables
variableNames <- names(subsetted)
variableNames <- gsub("mean","Mean", variableNames)
variableNames <- gsub("std","StandardDeviation", variableNames)
variableNames <- gsub("\\(\\)|-","", variableNames)
names(subsetted) <- variableNames

#Read the activity labels file
activity_labels <- read.table("./UCI HAR Dataset//activity_labels.txt", header = FALSE)


activity <- join(activity_train_test, activity_labels)[,2]
merged <- cbind(subject_train_test, activity, subsetted)

#group the data by PersonId and activity
by_Subject_Activity <- merged %>% group_by(PersonID, activity)
grouped_sum <- by_Subject_Activity %>% summarise_all(funs(mean))

write.csv(grouped_sum,"tidy_summerised.csv",sep = "," , row.names = FALSE)


