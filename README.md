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
5. Created a vector V that contained all the column names that contained "mean()" or "std()" only
6. Subsetted the dataframe from step 4 so that it contained only the columns from V and the column "activity_name"


7.Cleaned up the remaining column names:

1. changed all the letters to lower case

2. removed parentheses "()"
3. changed the names of the files that ended in "mean" or "std" to end in "mean-None" and "std-None" respectively, which took care of the missing direction "X", "Y" or "Z"   This way all column names now include the variable "direction".
4. changed the prefix "t" into "t-" and "f" into "f-" which represented the variable "domain" within each column name.  By changing these prefixes I made it possible for the column names to be split up easier into separate variables.  


The dataframe resuling from the column name clean up was still not a tidy date frame.  It had four different variables crammed into a single column: "domain" (which can be either t or time, f or frequency), "name" (which is the measurement's actual name), "type" (mean or std) and "direction" (X, Y, Z or None).  
In order to create these new variables in the dataframe I used the "tidyr" package:

1. I gathered all columns, but the "activity_name" one under the temporary name "What" and their values under the name "value". 
2. I separated the "What" column into the 4 variables: "domain", "name", "type", and "direction"

The resulting data set was nearly tidy, except for the garbled look of the entries under the "name" heading and for the abbreviations in the "domain" column
So, to tidy all this up:

1. I replaced most garbled expressions by more meaningful (if crammed) English phrases in the "name" column
2. I replaced "t" by "time" and "f" by "frequency" in  the "domain" column


Finally, I used the "dplyr" package  to group the data frame by "activity_name", "name", "type", "domain" and "direction" and calculated the average value of "value" for each group by using summarise().   

Saved the results as "tidy_data_set.txt"







