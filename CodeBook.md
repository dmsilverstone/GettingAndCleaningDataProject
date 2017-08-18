# CodeBook

This file describes the dataset [TidyData.txt](https://github.com/dmsilverstone/GettingAndCleaningDataProject/blob/master/TidyData.txt).  The experimental design and format of the raw data source is described, before describing all transformations that have been performed on this data to arrive at the final dataset.

## Experimental Design
The data used in the project comes from an experiment carried out to recognise human activity using smartphones.

The file `README.txt` within the source data provides the following description of the experiment and data recording process: 

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
>
>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

A full description is available at the website where the data was initially obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

## Raw data
The raw data for this project can be downloaded from
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

Again from the file `README.txt` contained within the source data, the following is a description of the data contained within the source dataset

> The dataset includes the following files:
>
> - 'README.txt'
> - 'features_info.txt': Shows information about the variables used on the feature vector.
> - 'features.txt': List of all features.
> - 'activity_labels.txt': Links the class labels with their activity name.
> - 'train/X_train.txt': Training set.
> - 'train/y_train.txt': Training labels.
> - 'test/X_test.txt': Test set.
> - 'test/y_test.txt': Test labels.
> 
> The following files are available for the train and test data. Their descriptions are equivalent. 
> 
> - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
> 
> - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
> 
> - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
> 
> - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 
> 
> 
> For each record it is provided:
> 
> - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
> - Triaxial Angular velocity from the gyroscope. 
> - A 561-feature vector with time and frequency domain variables. 
> - Its activity label. 
> - An identifier of the subject who carried out the experiment.
> 
> Notes: 
> 
> - Features are normalized and bounded within [-1,1].
> - Each feature vector is a row on the text file.

## Required files
Of the files within the source data that are listed above, only the following are required to create the final file: 

* `subject_train.txt`
* `Y_train.txt`
* `X_train.txt`
* `subject_test.txt`
* `Y_test.txt`
* `X_test.txt`
* `activity_labels.txt`
* `features.txt`

Note that, while not required explicitly, the source data files `README.txt` and `features_info.txt` also contain information that will be useful to the reader.  Files within the `\Inertial Signals\` subfolders are not required.

## Transformations
To construct the final dataset, the following transformations were made on the raw data

1. Combine files:

    The files `subject_train.txt`, `Y_train.txt` and `X_train.txt` are binded by columns.  The equivalent `..._test.txt` files were similarly combined.  These two files are then binded by rows to form a single dataset.

2. Initial lookups and variable names applied:

    The variable representing the column from the file `subject_[train/test].txt` has been called `subject`.   
    
    The variable representing the column from the file `Y_[train/test].txt` has been called `activity`, and the values within this variable (integers in the range [1,6]) have been replaced by a factor, whose labels are looked up from the file `activity_labels.txt`.
    
    The variable names from the file `X_[train/test].txt` are initially named according to the looked up labels from the file `features.txt`.  
    
3. Variable selection:

    Variables have been downsampled such that only those relating to the mean or standard deviation of a measurement are kept (along with the `subject` and `activity` variables).  As indicated within the file `features_info.txt`, these have been identified by those variables containing the strings `mean()` or `std()` within their names.  Note that variable names containing `meanFreq()`, described as the *"weighted average of the frequency components to obtain a mean frequency"*, have not been considered to be in scope.

4. Variable names have been made descriptive by applying the following rules:
   
    * Special characters such as `(`, `)` and `-` have been removed.
    * Strings `mean` and `std` have been replaced by `Mean` and `StdDev`
    * Prefixes `t` and `f` have been expanded to `time` and `freq` (describing whether the variable relates to the time domain or frequency domain)
    * Strings `Acc` and `Gyro` have been replaced by `Accelerometer` and `Gyroscope`, (describing the sensor signal used to create the variable)
    * String `Mag` has been expanded to `Magnitude` (describing variables representing the Euclidean Norm of the component `X`, `Y` and `Z` coordinate variables)
    * The seemingly incorrect string `BodyBody` present in some variable names has been replaced by `Body`.  
    
    Further descriptions of these variables can be found within the file `features_info.txt`.

5.  Averaging variables:

    The average (mean) for each variable has been calculated for each subject and each activity.


