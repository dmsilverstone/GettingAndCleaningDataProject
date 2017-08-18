############
## 00 Setup
############

## Load required package: dplyr
# If not already installed then do so
if (!"dplyr" %in% installed.packages()) {
  install.packages("dplyr")
}
# Load package
library(dplyr)

##############################################################
##1: Download and unzip the data if it does not already exist
##############################################################
data_directory <- "UCI HAR Dataset"

if (!file.exists(data_directory)) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "data_zipped")
  unzip("data_zipped")
}

#################################################################################################
##2: Read in the train and test datasets, assign column names, and merge to form a single dataset
#################################################################################################

#Read in feature and activity labels
labels_feat <- read.table("UCI HAR Dataset/features.txt")
labels_act <- read.table("UCI HAR Dataset/activity_labels.txt")
names(labels_act) <- c("activityId", "activity")


#Read in train datasets
df_train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
df_train_y <- read.table("UCI HAR Dataset/train/Y_train.txt")
df_train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

#Set column names
names(df_train_x) <- labels_feat[,2]
names(df_train_y) <- "activityId"
names(df_train_subject) <- "subject"

#Combine into single train dataset
df_train <- cbind(df_train_subject, df_train_y, df_train_x)

#Read in test datasets
df_test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
df_test_y <- read.table("UCI HAR Dataset/test/Y_test.txt")
df_test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

#Set column names
names(df_test_x) <- labels_feat[,2]
names(df_test_y) <- "activityId"
names(df_test_subject) <- "subject"

df_test <- cbind(df_test_subject, df_test_y, df_test_x)

#Combine test and train into single dataset
df_all <- rbind(df_train,df_test)

#########################################################################################
##3: Extract only the measurements on the mean and standard deviation for each measuremnt
#########################################################################################

#Determine which feature names contain "mean()" or "std()"
required_features <- grep(".*mean\\(\\).*|.*std\\(\\).*", names(df_all))

#Also include the subject and activity id columns
required_features <- c(1,2,required_features)

#Subset data
df_all <- df_all[,required_features]

##########################################################################
##4: Apply desciptive activity names to name the activities in the dataset
##########################################################################

#Create factor with appropriate labels
df_all$activityId <- factor(df_all$activityId, levels=labels_act$activityId, labels=labels_act$activity)
#Rename to remove "id"
names(df_all)[2] <- "activity"

#######################################################
##5: Label the data set with descriptive variable names
#######################################################

#Clean descriptive variable names
for (i in 3:length(names(df_all))){
  
  #Remove brackets from "mean()" and "std()"
  names(df_all)[i] <- gsub("\\()","",names(df_all[i]))
  #Remove hyphen from "-mean" and "-std".  Instead capitalise "M" and "S"
  names(df_all)[i] <- gsub("-mean","Mean",names(df_all[i]))
  names(df_all)[i] <- gsub("-std","StdDev",names(df_all[i]))
  #Remove further hyphens preceeding X,Y,Z
  names(df_all)[i] <- gsub("-","",names(df_all[i]))
  #Expand "t" and "f" prefix to descriptive "time" and "freq"
  names(df_all)[i] <- gsub("^(t)","time",names(df_all[i]))
  names(df_all)[i] <- gsub("^(f)","freq",names(df_all[i]))
  #Expand "Acc" to descriptive "Accelerometer"
  names(df_all)[i] <- gsub("Acc","Accelerometer",names(df_all[i]))
  #Expand "Gyro" to descriptive "Gyroscope"
  names(df_all)[i] <- gsub("Gyro","Gyroscope",names(df_all[i]))
  #Expand "Mag" to descriptive "Magnitude"
  names(df_all)[i] <- gsub("Mag","Magnitude",names(df_all[i]))
  #Remove repeated "BodyBody" from erroneous variable names
  names(df_all)[i] <- gsub("BodyBody","Body",names(df_all[i]))
  
}

#########################################################################################
##6: Average each variable for each activity and each subject, and output final data file
#########################################################################################

#Summarise
df_tidy <- df_all %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

#Output as .txt file
write.table(df_tidy, './TidyData.txt',row.names=FALSE)


