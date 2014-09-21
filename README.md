The data analysed here was collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data used in this analysis:

1. X_test.txt and X__train.txt  is used to form the main body of the dataframe 
        
2. Y_test.txt and Y_train.txt will form the activities column
        
3. features.txt is used to create the column names of the main dataframe
        
4. activity_labels.txt is used to label the activities that are originally specified by numbers in y_test.txt and y_train.txt
5. the files subject_test.txt and subject_train.txt should have been used to specify who performed which activity, but 
I didn't realize it until it was too late and  I ran out of time


What I did:

1. Added features.txt as the column names to both dataframes X_test and X_train individually
 
2. I added the activity columns y_test and y_train to X_test and X_train respecitvely under the column "activity"

3. I created a single dataframe from the two databases from step 2.
4. I merged the dataframe from step 3 with the activity_labels dataframe creating a new dataframe with one additional column "activity_name"
5. Created a vector V that contained all the column names that contained "mean()" or "std()"
6. Subsetted the dataframe from step 4 so that it contained only the columns from V and the column "activity_name"
7. Cleaned up the remaining column names 





