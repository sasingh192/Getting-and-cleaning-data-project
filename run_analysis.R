# This code, features.txt, "train" folder, and "test" folder all reside in the 
# working directory

# Code chunk to read feature names
con1 <- file("features.txt", "r")
featurnames <- readLines(con1)
close(con1)

# Read Train dataset
setwd("train")
X_train = read.table("X_train.txt", col.names = featurnames)
y_train = read.table("y_train.txt", col.names = "Activity_type")
subject_train = read.table("subject_train.txt", col.names = "subject")
df_train = cbind(subject_train, y_train, X_train)

# Read Test dataset
setwd("../test")
X_test = read.table("X_test.txt", col.names = featurnames)
y_test = read.table("y_test.txt", col.names = "Activity_type")
subject_test = read.table("subject_test.txt", col.names = "subject")
df_test = cbind(subject_test, y_test, X_test)

# Combine train and test dataframs
df = rbind(df_train, df_test)
columns <- names(df)
matchcols <- grep("(\\.mean\\.)|(\\.std\\.)", columns, value=TRUE)
matchcols <- append(matchcols, c("subject", "Activity_type"), after=0)
df <- df[, matchcols]

# Use descriptive activity names to name the activities in the dataset
assignlabel <- function(x) {
        if (x==1){y <- "WALKING"}
        if (x==2) {y <- "WALKING_UPSTAIRS"}
        if (x==3) {y <- "WALKING_DOWNSTAIRS"}
        if (x==4) {y <- "SITTING"}
        if (x==5) {y <- "STANDING"}
        if (x==6) {y <- "LAYING"}
        y
}

df$Activity_type <- lapply(df$Activity_type, assignlabel)

# Appropriately label the datasets with descriptive variable names
splitnames <- strsplit(names(df), "\\.")

newname <- function(x) {paste(x[2], x[3], x[length(x)], sep=" ")}

newnames <- lapply(splitnames, newname)

newnames[[1]] <- "subject"
newnames[[2]] <- "activity"

names(df) <- newnames
df$activity <- unlist(df$activity)
df$activity <- as.factor(df$activity)

# Averaging of each variable for each activity and each subject
library(dplyr)
df_agg <- df %>% group_by(subject, activity) %>% summarise_all("mean")
setwd("../")

# Export the Averaged data as "tidy.txt"
write.table(df_agg, "tidy.txt", row.names = FALSE)
