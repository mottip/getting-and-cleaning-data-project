n_rows <- 10000

x_test <- read.fwf('UCI HAR Dataset/test/X_test.txt',widths=rep(16,561), header=FALSE, nrows=n_rows)
x_train <- read.fwf('UCI HAR Dataset/train/X_train.txt',widths=rep(16,561), header=FALSE,nrows=n_rows)
x <- rbind(x_test,x_train)

y_test <- read.fwf('UCI HAR Dataset/test/Y_test.txt',widths=1, colClasses='factor', header=FALSE,nrows=n_rows)
y_train <- read.fwf('UCI HAR Dataset/train/Y_train.txt',widths=1, colClasses='factor', header=FALSE,nrows=n_rows)
y <- rbind(y_test, y_train)

subj_test <- read.csv('UCI HAR Dataset/test/subject_test.txt', colClasses='factor', header=FALSE,nrows=n_rows)
subj_train <- read.csv('UCI HAR Dataset/train/subject_train.txt', colClasses='factor', header=FALSE,nrows=n_rows)
subj <- rbind(subj_test, subj_train)

features <- read.csv('UCI HAR Dataset/features.txt', sep=' ', colClasses='character', header=FALSE)
actvities <- read.csv('UCI HAR Dataset/activity_labels.txt', sep=' ', colClasses=c('NULL','character'), header=FALSE)
colnames(x) <- features[,2]
cols=grep('mean|std',features[,2])
x <- x[,cols]

levels(y[,1]) <- actvities[,1]
x$activity <- y[,1]
x$subject <- subj[,1]
tidy <- ddply(x,c("activity", "subject"),numcolwise(mean))
