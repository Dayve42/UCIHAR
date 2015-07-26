---
title: "UCI HAR README"
author: "Dave H"
date: "July 24, 2015"
output: html_document
---
## Coursera Getting and Cleaning Data Course Project


### Structure of data files
*All paths are relative to the current working directory in R*

file                    | description
---                     | ---
./activity_labels.txt   | Cross references activity codes with descriptions
./features.txt          | Full list of measured variables
./test/X_test.txt       | Measured data for test Data set
./test/subject_test.txt | Subject IDs for test data set
./test/y_test.txt       | Activity codes for test data set
./train/X_train.txt       | Measured data for training Data set
./train/subject_train.txt | Subject IDs for training data set
./train/y_train.txt       | Activity codes for training data set


### Necessary R packages
The following packages must be installed before running import script. The script will load them as needed.

* dplyr
* rshape2

###Description of import process
1. The activity descriptions are read from ./activity_labels.txt into the object *activityLabels*
2. The full list of measured variables in the data set is read from ./features.txt into the object *setCols*. The 2nd column contains the variable names, and is converted into a vector named *setColVector*. This will be used to label the columns during the data set import process.
3. The test data are read from ./test/X_test.txt into the object *testSet*. The *setColVector* object from step 2 is used to label the columns.
4. The list of test subjects is read from ./test/subject_test.txt into the object *testSubject*.
5. The list of activity codes is read from ./test/y_test.txt in to the object *testActivity*. In order to covert the numeric activity codes to test descriptions, the activity codes are converted to a factor variable and assigned their levels from the object *activityLabels*.
6. The *testSubject*, *testActivity*, *testSet* objects are column bound into a single object named *testData*. Since the second column now contains activity labels instead of activity codes, it is renamed to "activity".
7. The *testSubject*, *testActivity*, *testSet* objects are removed to free up system resources.
8. The training data are read from ./train/X_train.txt into the object *trainingSet*. The *setColVector* object from step 2 is used to label the columns.
9. The list of trianing subjects is read from ./train/subject_train.txt into the object *trainingSubject*.
10. The list of activity codes is read from ./train/y_train.txt in to the object *trainingActivity*. In order to covert the numeric activity codes to test descriptions, the activity codes are converted to a factor variable and assigned their levels from the object *activityLabels*.
11. The *trainingSubject*, *trainingActivity*, *trainingSet* objects are column bound into a single object named *trainingData*. Since the second column now contains activity labels instead of activity codes, it is renamed to "activity".
12. The *trainingSubject*, *trainingActivity*, *trainingSet* objects are removed to free up system resources.
13. The *testData* and *trainingData* objects are concatenated into a new object named *allData*.
14. The *testData* and *trainingData* objects are removed to free up system resources.
15. The *dplyr* library is loaded.
16. The dplyr *select* command is used to select the subject_id, activity, and all column names containing "mean" or "std". The resulting set is saved in the object *meanstdData*.
17. The *reshape2* library is loaded.
18. The reshape2 *melt* command is used to transform the wide data set into a tall format. The subject_id and activity columns are used as the identifier columns. The resulting set is saved in the object *meltedData*.
19. The reshape2 *dcast* command is used to calculate the mean of each type of measurement by activity by subject. This becomes the "wide tidy" format. The resulting set is saved in the object *widetidyData*.
20. The reshape2 *melt* command is used to transform the wide tidy data set into a tall format. The subject_id and activity columns are used as the identifier columns. The resulting set is saved in the object *talltidyData*.