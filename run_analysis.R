# Assuming the data has been downloaded and extracted, this file
# will read the data, merge it, extract only relevant subsets, label it
# and finally provide a tidy-data set to run further analysis on.

features <- read.csv('C:/Users/acer/Documents/R/UCI HAR Dataset/features.txt', header = FALSE)
features <- as.character(features[,2])


## Load training data

train.x <- read.csv ('C:/Users/acer/Documents/R/UCI HAR Dataset/train/X_train.txt', header = FALSE)
train.activity <- read.csv('C:/Users/acer/Documents/R/UCI HAR Dataset/train/y_train.txt', header = FALSE)
train.subject <- read.csv('C:/Users/acer/Documents/R/UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

train <-  frame(train.subject, train.activity, train.x)
names(train) <- c(c("subject", "activity"), features)

## Load testing data

test.x <- read.table('C:/Users/acer/Documents/R/UCI HAR Dataset/test/X_test.txt', header = FALSE)
test.activity <- read.csv('C:/Users/acer/Documents/R/UCI HAR Dataset/test/y_test.txt', header = FALSE)
test.subject <- read.csv('C:/Users/acer/Documents/R/UCI HAR Dataset/test/subject_test.txt', header = FALSE)

test <-  frame(test.subject, test.activity, test.x)
names(test) <- c(c('subject', 'activity'), features)

all <- rbind(train, test)

activity.labels <- read.table('C:/Users/acer/Documents/R/UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity.labels <- as.character(activity.labels[,2])
sub$activity <- activity.labels[sub$activity]

## Add the column names to all
name.new <- names(sub)
name.new <- gsub(name.new)
name.new <- gsub("TimeDomain_", name.new)
name.new <- gsub("FrequencyDomain_", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "_Mean_", name.new)
name.new <- gsub("-std-", "_StandardDeviation_", name.new)
name.new <- gsub("-", "_", name.new)
names(sub) <- name.new

## Write tidy_data
tidy <- aggregate(sub[,3:81], by = list(activity = sub$activity, subject = sub$subject),FUN = mean)
write.table(x = tidy, file = 'data_tidy.txt', row .names = FALSE)
