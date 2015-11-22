Ytest=read.table("y_test.txt")
Xtest=read.table("X_test.txt")
subjecttest=read.table("subject_test.txt")
testcombo=cbind(subjecttest,Ytest,Xtest)

Ytrain=read.table("y_train.txt")
Xtrain=read.table("X_train.txt")
subjecttrain=read.table("subject_train.txt")
traincombo=cbind(subjecttrain,Ytrain,Xtrain)

step1=rbind(testcombo,traincombo)

features1=read.table("features.txt")
features1$V2=as.character(features1$V2)
features2=features1[,2]

colnames(step1)=c("subject","activity",features2)

getfirst=step1[,1:2]
getmean=step1[,grepl("mean",colnames(step1))]
getstd=step1[,grepl("std",colnames(step1))]
step2=cbind(getfirst,getmean,getstd)

actlabels=read.table("activity_labels.txt")
colnames(actlabels)=c("activitynum","activityname")
step3=merge(step2,actlabels,by.x="activity",by.y="activitynum")

melted=melt(step3,id=c("subject","activityname"),measure.vars = colnames(step3)[3:81])
tidy=dcast(melted,subject + activityname ~ variable, mean)
