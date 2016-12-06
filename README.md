# Getting-and-Cleaning-Data-Assignment

This README.md file describes how the assignment scripts are designed and coded.

## 1-run_analysis.R

* Read the moves data from the training and test folders and row bind them

> x_train <- read.table("./UCI HAR Dataset//train//X_train.txt", header = FALSE)

> x_test <- read.table("./UCI HAR Dataset//test//X_test.txt", header = FALSE)

> functions_train_test <- rbind(x_train, x_test)


* Do the same with activities data and persons data

> y_train <- read.table("./UCI HAR Dataset//train//y_train.txt", header = FALSE)

> y_test <- read.table("./UCI HAR Dataset//test//y_test.txt", header = FALSE)

> activity_train_test <- rbind(y_train, y_test)


> subject_train <- read.table("./UCI HAR Dataset//train//subject_train.txt", header = FALSE)

> subject_test <- read.table("./UCI HAR Dataset//test//subject_test.txt", header = FALSE)

> subject_train_test <- rbind(subject_train, subject_test)

> names(subject_train_test) <- c("PersonID")


* Read the features txt file and subset the the moves data with mean and standard deviation only

> features <- read.table("./UCI HAR Dataset//features.txt", header = FALSE)

> names(functions_train_test) <- features[,2]

> subsetted <- functions_train_test[grep("std|mean", features[,2], ignore.case = TRUE)]

* Rename the variables names by changing the word "mean" to "Mean", "std" to "StandardDeviation" and removing "()" and "-"

> variableNames <- names(subsetted)

> variableNames <- gsub("mean","Mean", variableNames)

> variableNames <- gsub("std","StandardDeviation", variableNames)

> variableNames <- gsub("\\(\\)|-","", variableNames)

> names(subsetted) <- variableNames


* Read the activities labels txt file and column bind it with movments and persons Ids

> activity_labels <- read.table("./UCI HAR Dataset//activity_labels.txt", header = FALSE)

>activity <- join(activity_train_test, activity_labels)[,2]

> merged <- cbind(subject_train_test, activity, subsetted)

* Group the merged tidy data with PersonId and activity and summerise it.

> by_Subject_Activity <- merged %>% group_by(PersonID, activity)
grouped_sum <- by_Subject_Activity %>% summarise_all(funs(mean))


* Write the tidy summerised data in a cvs file

> write.csv(grouped_sum,"tidy_summerised.csv",sep = "," )



## 2- Codebook.R
This scripts reads the tidy summerised data, gets the column names, classes, and value ranges and  write this information in  codebook.md.

> summerisedData <- read.csv("tidy_summerised.csv", header = TRUE)


> df <- data.frame( row.names= NULL,

>             ColNames = names(summerisedData),

>             DataType = sapply(summerisedData, class),

>             range = sapply(summerisedData, function(col)

>                 if(class(col) == "factor")

>                   paste(levels(col), collapse  = "/")

>                 else if (class(col) == "integer" || class(col) 
== "numeric")

 >                 paste( min(col), max(col), sep = "/")

 >              ),

 >              mean = sapply(summerisedData, function(col)

  >                 if (class(col) == "numeric")

 >                    mean(col)

   >                else
> 

  >                   "Not available"
    >                        )

    >                )

                
  >     write.table(df,"codebook.md", sep = " | " )          
             

 