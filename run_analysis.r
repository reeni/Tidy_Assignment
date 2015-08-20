
setwd("C:\\Users\\Irene\\Desktop\\coursera2015\\Clean_Assignment 1")

filename <- ".\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\features.txt"
FEATURE<-read.table(filename, header= FALSE, sep="")

filename <- ".\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\Activity_Labels.txt"
ACTIVITY_LABELS<-read.table(filename, header= FALSE, sep="")

filename <- ".\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt"
SUBJECT_TRAIN<-read.table(filename, header= FALSE, sep="")

filename <- ".\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt"
X_TRAIN<-read.table(filename, header= FALSE, sep="")

filename <- ".\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\Y_train.txt"
Y_TRAIN<-read.table(filename, header= FALSE, sep="")

x<-as.vector(FEATURE$V2)
colnames(X_TRAIN)<-x

M<-merge(Y_TRAIN,ACTIVITY_LABELS, by.x ="V1", by.y = "V1")

colnames(M)<-c("V1","Activity")

Y_TRAIN<-M[,"Activity"]

Table1<-cbind(SUBJECT_TRAIN,Y_TRAIN,X_TRAIN)

filename <- "C:\\Users\\Irene\\Desktop\\coursera2015\\Clean_Assignment 1\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt"
X_TEST<-read.table(filename, header= FALSE, sep="")

filename <- "C:\\Users\\Irene\\Desktop\\coursera2015\\Clean_Assignment 1\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\Y_test.txt"
Y_TEST<-read.table(filename, header= FALSE, sep="")

filename <- "C:\\Users\\Irene\\Desktop\\coursera2015\\Clean_Assignment 1\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt"
SUBJECT_TEST<-read.table(filename, header= FALSE, sep="")

colnames(X_TEST)<-x

M<-merge(Y_TEST, ACTIVITY_LABELS, by.x ="V1", by.y = "V1")

colnames(M)<-c("V1","Activity")

Y_TEST<-M[,"Activity"]


Table2<-cbind(SUBJECT_TEST,Y_TEST,X_TEST)


filename <- "C:\\Users\\Irene\\Desktop\\coursera2015\\Clean_Assignment 1\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\Y_test.txt"
Y_TEST<-read.table(filename, header= FALSE, sep="")

colnames(Table1)[1]<-"SUBJECT"
colnames(Table2)[1]<-"SUBJECT"
colnames(Table1)[2]<-"ACTIVITY"
colnames(Table2)[2]<-"ACTIVITY"


Table <- rbind(Table1, Table2)

m<-grep("mean",colnames(Table))

s<-grep("std",colnames(Table))

t<-c(1,2,m,s)
nt<-Table[,t]

f<-ddply(nt, .(SUBJECT,ACTIVITY),colwise(mean))

write.table(f, file = "run_analysis.txt", sep = "\t", col.names = TRUE, row.names = FALSE)





