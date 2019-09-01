# Project---Getting-and-Cleaning-data
Getting and Cleaning data


R script called run_analysis.R that does the following.
1. Set working directory to where data are stored.
2. Using cbind and rbind, the training and the test sets are merged to create one data set, named data
3. Extracts only the measurements on the mean and standard deviation for each measurement using dplyr::select.
4. Uses descriptive activity names to name the activities in the data set. This was performed using merge by "code" to assign code value to an activity
5. Appropriately labels the data set with descriptive variable names. This was performed using gsub(..,...,...)
6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject. This was performed by using dplyr :: group_by and summarise (funs)
7. Output the tidy data in txt file using write.table

