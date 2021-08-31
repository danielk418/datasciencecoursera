library(dplyr)
library(tidyr)

test_data <- read.table("./data/X_test.txt")
test_subject <- read.table("./data/subject_test.txt", col.names = c("subjectID"))
test_labels <- read.table("./data/y_test.txt", col.names = c("label"))
test_data_full <-  cbind(test_subject, test_data, test_labels)

train_data <- read.table("./data/X_train.txt")
train_subject <- read.table("./data/subject_train.txt", col.names = c("subjectID"))
train_labels <- read.table("./data/y_train.txt", col.names = c("label"))
train_data_full <- cbind(train_subject, train_data, train_labels)


activity_labels <- read.table("./data/activity_labels.txt")

full_data <- rbind(test_data_full, train_data_full)

var_names <- read.table("./data/features.txt", stringsAsFactors = FALSE)

names(full_data)[grep("^V", names(full_data))] <- var_names$V2

mean_and_std_data <- select(full_data, contains("mean") | contains("std")| subjectID | label)

names(mean_and_std_data) <- gsub("^f", "frequency", names(mean_and_std_data))
names(mean_and_std_data) <- gsub("^t", "time", names(mean_and_std_data))
names(mean_and_std_data) <- gsub("Acc", "acceleration", names(mean_and_std_data))
names(mean_and_std_data) <- gsub("Mag", "magnitude", names(mean_and_std_data))
names(mean_and_std_data) <- tolower(names(mean_and_std_data))

mean_and_std_data <- merge(x = mean_and_std_data, y = activity_labels, by.x = "label", by.y = "V1")

mean_and_std_data <- mean_and_std_data %>%  
                      select(-label) %>% 
                      rename(activity = V2)

tidy_data <- mean_and_std_data %>% 
             gather(metric, value, -c(subjectid, activity)) %>% 
             group_by(subjectid, activity) %>% 
             summarize(avg = mean(value))

write.table(tidy_data, row.names = FALSE, "./data/tidy_data.txt")

