# get-and-clean-data
Analysis script with explainantions

#First section: reads in all the test data pieces and combines them into one dataframe
  Ytest=read.table("y_test.txt")
  Xtest=read.table("X_test.txt")
  subjecttest=read.table("subject_test.txt")
  testcombo=cbind(subjecttest,Ytest,Xtest)

#Second section: reads in all the training data pieces and combines them into one dataframe
  Ytrain=read.table("y_train.txt")
  Xtrain=read.table("X_train.txt")
  subjecttrain=read.table("subject_train.txt")
  traincombo=cbind(subjecttrain,Ytrain,Xtrain)

#Third section: creates one combined dataframe
  step1=rbind(testcombo,traincombo)

#Fourth section: gets all the proper column names from the features.txt file and 
#and adds them to the data frame from the above steps
  features1=read.table("features.txt")
  features1$V2=as.character(features1$V2)
  features2=features1[,2]
  colnames(step1)=c("subject","activity",features2)

#Fifth section: only includes the subject, activity name, and mean/std measurements
  getfirst=step1[,1:2]
  getmean=step1[,grepl("mean",colnames(step1))]
  getstd=step1[,grepl("std",colnames(step1))]
  step2=cbind(getfirst,getmean,getstd)

#Sixth section: add activity names by matching activity numbers to the names
  actlabels=read.table("activity_labels.txt")
  colnames(actlabels)=c("activitynum","activityname")
  step3=merge(step2,actlabels,by.x="activity",by.y="activitynum")

#Seventh step: takes the mean of each variable 
#for each combination of subject and activity
  melted=melt(step3,id=c("subject","activityname"),measure.vars = colnames(step3)[3:81])
  tidy=dcast(melted,subject + activityname ~ variable, mean)
