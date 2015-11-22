library(gsubfn)
library(reshape2)
xtrain <- read.table("C:/Users/Varun/Desktop/Coursera/Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("C:/Users/Varun/Desktop/Coursera/Getting and Cleaning Data/UCI HAR Dataset/train/y_train.txt")
subjecttrain <- read.table("C:/Users/Varun/Desktop/Coursera/Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt")
xtest <- read.table("C:/Users/Varun/Desktop/Coursera/Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("C:/Users/Varun/Desktop/Coursera/Getting and Cleaning Data/UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("C:/Users/Varun/Desktop/Coursera/Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt")
train <- cbind(xtrain,ytrain,subjecttrain)
test<-cbind(xtest,ytest,subjecttest)
dataset<-rbind(train,test)
features <- read.table("C:/Users/Varun/Desktop/Coursera/Getting and Cleaning Data/UCI HAR Dataset/features.txt", strip.white=TRUE, stringsAsFactors=FALSE)
# only retain features of mean and standard deviation
features.mean.std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]
#mean_std_cols<-c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543,562,563)
dataset_mean_std<-dataset[,c(features.mean.std$V1,562,563) ]
activities <- read.table("C:/Users/Varun/Desktop/Coursera/Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
dataset_mean_std[,67]<-activities[dataset_mean_std[,67],2]
colname<-c(features.mean.std$V2,"activity","subject")
good.colname<-tolower(gsubfn("[^[:alpha:]]", "",colname))
colnames(dataset_mean_std)<-good.colname
melt<-melt(dataset_mean_std,id=c("activity","subject"),measure.vars=c(colnames(dataset_mean_std[,1:66])))
final_dataset<-dcast(melt,activity+subject~variable,mean)
write.table(final_dataset,file="result.txt",row.names = FALSE)
#colnames(dataset_mean_std)<-c("tBodyAccXmean","tBodyAccYmean","tBodyAccZmean","tBodyAccXstd","tBodyAccYstd","tBodyAccZstd","tGravityAccXmean","tGravityAccYmean","tGravityAccZmean","tGravityAccXstd","tGravityAccYstd","tGravityAccZstd","tBodyAccJerkXmean","tBodyAccJerkYmean","tBodyAccJerkZmean","tBodyAccJerkXstd","tBodyAccJerkYstd","tBodyAccJerkZstd","tBodyGyroXmean","tBodyGyroYmean","tBodyGyroZmean","tBodyGyroXstd","tBodyGyroYstd","tBodyGyroZstd","tBodyGyroJerkXmean","tBodyGyroJerkYmean","tBodyGyroJerkZmean","tBodyGyroJerkXstd","tBodyGyroJerkYstd","tBodyGyroJerkZstd","tBodyAccMagmean","tBodyAccMagstd","tGravityAccMagmean","tGravityAccMagstd","tBodyAccJerkMagmean","tBodyAccJerkMagstd","tBodyGyroMagmean","tBodyGyroMagstd","tBodyGyroJerkMagmean","tBodyGyroJerkMagstd","fBodyAccXmean","fBodyAccYmean","fBodyAccZmean","fBodyAccXstd","fBodyAccYstd","fBodyAccZstd","fBodyAccJerkXmean","fBodyAccJerkYmean","fBodyAccJerkZmean","fBodyAccJerkXstd","fBodyAccJerkYstd","fBodyAccJerkZstd","fBodyGyroXmean","fBodyGyroYmean","fBodyGyroZmean","fBodyGyroXstd","fBodyGyroYstd","fBodyGyroZstd","fBodyAccMagmean","fBodyAccMagstd","fBodyAccJerkMagmean","fBodyAccJerkMagstd","fBodyGyroMagmean","fBodyGyroMagstd","fBodyGyroJerkMagmean","fBodyGyroJerkMagstd","ytrain","subjecttrain")
