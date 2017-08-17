# Getting and Cleaning Data - Course Project
Course project for 'Getting And Cleaning Data', part of the Data Science Specialization offered by John Hopkins University on Coursera.

## Project Description
The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The data used for the project relates to wearable computing, one of the most exciting areas in all of data science right now - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to below represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

## R Version
All scripts and datasets contained within this project have been created and run using R version 3.4.0, under a 64-bit Windows operating platform.
In order to run the scripts contained within this repo, the only additional R packages required are `dplyr` and ...

## Dataset source
The raw data for this project can be downloaded from
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

This data should be downloaded and unzipped into the R working directory before running any scripts.

## Project Structure
The R code file [run_analysis.R](https://github.com/dmsilverstone/GettingAndCleaningDataProject/blob/master/run_analysis.R) contains the script required to transform the raw data as downloaded above into the final tidy dataset, [TidyData.txt](https://github.com/dmsilverstone/GettingAndCleaningDataProject/blob/master/TidyData.txt).

The main steps in this file are:

1. Read in the train and test datasets and merge to form a single dataset
2. Extract only the measurements on the mean and standard deviation for each measuremnt
3. Apply desciptive activity names to name the activities in the dataset
4. Appropriately labels the data set with descriptive variable names
5. Creates the tidy data set TidyData.txt, containing the average for each variable for each activity and each subject

The final data set is 'tidy' as per the general principles of tidy data as descibed in [this paper](http://vita.had.co.nz/papers/tidy-data.pdf) by Hadley Wickham.

The R Markdown file [CodeBook.md](https://github.com/dmsilverstone/GettingAndCleaningDataProject/blob/master/CodeBook.md) contains further information about the data, including variable descriptions, units, and transformations performed on the raw data.