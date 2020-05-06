---
title: "README"
author: "Saurabh Singh"
date: "5/6/2020"
output: pdf_document
---

# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Coursera course.
The R script run_analysis.R, does the following:

1. Read the feature names from featurenames.txt stored in the working directory

2. Read the train dataset from "train" folder stored in the working directory

3. Read the test dataset from teh "test" folder stored in the working directory

4. Combine train and test data

5. Provide descriptive activity names to name the activities in the dataset

6. Appropriately label the datasets with descriptive variable names

7. Generate a new data with averaging of each variable for each activity and each subject

8. Export the averaged data as "tidy.txt"