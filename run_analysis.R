## Getting and Cleaning Data ##
## Peer Assessment ##
## Derek Brown ##

install.packages("reshape2")
library(reshape2)

# Merge the training and the test sets to create one data set.
directory <- "UCI HAR Dataset"
folders <- c("train", "test")
Xdata <- c()
Ydata <- c()
Sdata <- c()

# Loop over data folders and read in data
for (folder in folders){
    Xdata <- rbind(Xdata, read.table(paste(directory,"/",folder,"/","X_",folder,".txt", sep=""), colClasses = "numeric"))
    Ydata <- rbind(Ydata, read.table(paste(directory,"/",folder,"/","Y_",folder,".txt", sep=""), colClasses = "integer"))
    Sdata <- rbind(Sdata, read.table(paste(directory,"/",folder,"/","subject_",folder,".txt", sep=""), colClasses = "integer"))
}

# Give the datasets useful names
names(Xdata) <- read.table(paste(directory,"/","features.txt",sep=""))[,2]
names(Ydata) <- "activity"
names(Sdata) <- "subject"

# Extract only the measurements on the mean and standard deviation for each measurement.
# include parentheses in regular expression to exclude meanFreq() measurements
XdataSubset <- Xdata[,grep("(.*mean[()].*)|(.*std[()].*)",names(Xdata))]

# Combine all datasets
data <- data.frame(Sdata, XdataSubset, Ydata)

# Read in the descriptive activity names to name the activities in the data set
activities <- data.frame(read.table(paste(directory,"/","activity_labels.txt", sep="")))

# Appropriately label the data set with descriptive activity names.
data <- merge(data, activities, by.x="activity", by.y="V1")
names(data)[names(data) == "V2"] <- "activityName"
data <- data[, names(data) != "activity"]

# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
meltData <- melt(data, c("subject", "activityName"))
avgData <- aggregate(meltData$value, list(meltData$subject, meltData$activityName, meltData$variable), mean)
names(avgData) <- c("subject","activityName","variable","value")
tidyData <- dcast(avgData, subject + activityName ~ variable)
write.table(tidyData, file="tidyData.txt", sep="|")
