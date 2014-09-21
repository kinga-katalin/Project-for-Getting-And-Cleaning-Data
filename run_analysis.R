library(dplyr)
library(tidyr)
#Reading in the data
test_df <- tbl_df(read.table("X_test.txt"))
train_df <- tbl_df(read.table("X_train.txt"))
test_y <- read.table("y_test.txt")
train_y <- read.table("y_train.txt")
column_names <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

#adding column names to the test,train and activity label dataframes
colnames(train_df)<-(column_names[,2])
colnames(test_df) <-(column_names[,2])
colnames(activity_labels) <- (c("activity_number", "activity_name"))

#adding an activity column to both data frames
test_plus_df <- cbind(test_df, activity = test_y[,1])
train_plus_df <- cbind(train_df, activity = train_y[,1])

#creating a single data frame from test_plus_df and train_plus_df
all_df <- rbind(train_plus_df, test_plus_df)

#adding a new column containing the activity labels

all_plus_labels <- merge(all_df, activity_labels, by.x="activity", by.y="activity_number")

#searching for the column names that contain the word "-mean" 

V1 <- grep("-mean", names(all_df), ignore.case=TRUE, value =TRUE)

#ignoring column names that contain the phrase "-meanFreq()"
V1 <- V1[!grepl("meanFreq()", V1)]


V2 <- unique(grep("std", names(all_df), ignore.case=TRUE, value =TRUE))

#creating a vector that contains all the column names that we want to keep
V <- c(V1, V2, "activity_name")

#filtering out the unwanted columns
filtered_all_df <- subset(all_plus_labels,select=V)
#cleaning up the column names
names(filtered_all_df)<-tolower(names(filtered_all_df))
names(filtered_all_df)<-sub("()","", names(filtered_all_df),fixed=TRUE)
names(filtered_all_df)<-sub("mean$", "mean-None", names(filtered_all_df))
names(filtered_all_df)<-sub("std$", "std-None", names(filtered_all_df))
names(filtered_all_df)<-sub("^t", "t-", names(filtered_all_df))
names(filtered_all_df)<-sub("^f", "f-", names(filtered_all_df))
#saving results in a tbl_df using dplyr package
df <- tbl_df(filtered_all_df)

#rearranging the data using the tidyr package
result <-df %>% 
      gather(What, value, -activity_name) %>%
      separate(What, c("domain","name", "type", "direction"))

#cleaning up the names column values 
result$domain[result$domain=="t"]<-"time"
result$domain[result$domain=="f"]<-"frequency"
result$name[result$name=="bodyacc"]<-"bodyacceleration"
result$name[result$name=="gravityacc"]<-"gravityacceleration"
result$name[result$name=="bodyaccjerk"]<-"bodyaccelerationjerk"
result$name[result$name=="bodygyro"]<-"bodyangularacceleration"
result$name[result$name=="bodygyrojerk"]<-"bodyangularaccelerationjerk"
result$name[result$name=="bodyaccmag"]<-"bodyaccelerationmagnitude"
result$name[result$name=="gravityaccmag"]<-"gravityaccelerationmagnitude"
result$name[result$name=="bodyaccjerkmag"]<-"bodyaccelerationjerkmagnitude"
result$name[result$name=="bodygyromag"]<-"bodyangularaccelerationmagnitude"
result$name[result$name=="bodygyrojerkmag"]<-"bodyangularaccelerationjerkmagnitude"

#caluclating the averages
final_results <- result %>%
  group_by(activity_name, name, type, domain, direction)%>%
  summarise(average = mean(value, na.rm = TRUE))
write.table(final_results, file = "tidy_data_set.txt", row.name=FALSE)
